import { SignUpHandler } from './sign-up.handler';
import { Test } from '@nestjs/testing';
import {
  firebaseUserInfoStub,
  MissingRequiredParamException,
  PersistenceErrorException,
  UserDto,
  UserEntity,
  UserRepository,
  userStub,
} from '@web-stack/domain';
import { FirebaseAdminService } from '@web-stack/services';
import { SignUpCommand } from '../impl/sign-up.command';

describe('SignUpHandler', () => {
  let mockRepository = {};
  let repository: UserRepository;
  let handler: SignUpHandler;
  let adminService: FirebaseAdminService;
  let mockAdminService = {};

  beforeEach(async () => {
    mockRepository = {
      find: jest.fn().mockResolvedValue([userStub()]),
      save: jest.fn().mockResolvedValue(userStub()),
    };
    mockAdminService = {
      signUpWithEmailPassword: jest
        .fn()
        .mockResolvedValue(firebaseUserInfoStub()),
    };
    // Reference for WIP CQRS testing:
    // https://github.com/nestjs/nest/issues/274
    const moduleRef = await Test.createTestingModule({
      providers: [
        {
          provide: UserRepository,
          useValue: mockRepository,
        },
        {
          provide: FirebaseAdminService,
          useValue: mockAdminService,
        },
        SignUpHandler,
      ],
    }).compile();

    handler = moduleRef.get<SignUpHandler>(SignUpHandler);
    repository = moduleRef.get<UserRepository>(UserRepository);
    adminService = moduleRef.get<FirebaseAdminService>(FirebaseAdminService);

    jest.clearAllMocks();
  });

  it('throws error if email is undefined', async () => {
    const command = new SignUpCommand({
      email: undefined,
      password: '1234567As',
      displayName: 'Full Name',
    });
    await expect(handler.execute(command)).rejects.toThrow(
      new MissingRequiredParamException(SignUpCommand.name, 'email', 'string')
    );
  });

  it('throws error if password is undefined', async () => {
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: undefined,
      displayName: 'Full Name',
    });
    await expect(handler.execute(command)).rejects.toThrow(
      new MissingRequiredParamException(
        SignUpCommand.name,
        'password',
        'string'
      )
    );
  });

  it('throws error if displayName is undefined', async () => {
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: '1234567As',
      displayName: undefined,
    });
    await expect(handler.execute(command)).rejects.toThrow(
      new MissingRequiredParamException(
        SignUpCommand.name,
        'displayName',
        'string'
      )
    );
  });

  it('signs user up through firebase admin service', async () => {
    jest.spyOn(adminService, 'signUpWithEmailPassword');
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: '1234567As',
      displayName: 'Full Name',
    });
    handler.execute(command);
    expect(adminService.signUpWithEmailPassword).toHaveBeenCalledWith(
      command.email,
      command.password,
      command.displayName
    );
  });

  it('given signup failure, throws error', async () => {
    jest
      .spyOn(adminService, 'signUpWithEmailPassword')
      .mockRejectedValue(new Error('Test error'));
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: '1234567As',
      displayName: 'Full Name',
    });
    await expect(handler.execute(command)).rejects.toThrowError();
  });

  it('given signup success, saves user entity in repository using values from saved user record', async () => {
    jest.spyOn(repository, 'save');
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: '1234567As',
      displayName: 'Full Name',
    });
    await handler.execute(command);
    expect(repository.save).toHaveBeenCalledWith(<UserEntity>{
      displayName: firebaseUserInfoStub().displayName,
      email: firebaseUserInfoStub().email,
      emailVerified: firebaseUserInfoStub().emailVerified,
      phoneNumber: firebaseUserInfoStub().phoneNumber,
      photoURL: firebaseUserInfoStub().photoURL,
      uid: firebaseUserInfoStub().uid,
    });
  });

  it('saves user entity with given nickname', async () => {
    jest.spyOn(repository, 'save');
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: '1234567As',
      displayName: 'Full Name',
      nickName: 'testGivenNickName',
    });
    await handler.execute(command);
    expect(repository.save).toHaveBeenCalledWith(<UserEntity>{
      displayName: firebaseUserInfoStub().displayName,
      email: firebaseUserInfoStub().email,
      emailVerified: firebaseUserInfoStub().emailVerified,
      phoneNumber: firebaseUserInfoStub().phoneNumber,
      photoURL: firebaseUserInfoStub().photoURL,
      uid: firebaseUserInfoStub().uid,
      nickName: command.nickName,
    });
  });

  it('returns correct dto on success', async () => {
    const expectedDto = new UserDto({
      ...userStub(),
    });
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: '1234567As',
      displayName: 'Full Name',
    });
    const actualDto = await handler.execute(command);
    expect(JSON.stringify(actualDto)).toEqual(JSON.stringify(expectedDto));
  });

  it('throws `PersistenceErrorException` if repostiroy throws error', async () => {
    const thrownError = new Error('Test error');
    jest.spyOn(repository, 'save').mockRejectedValue(thrownError);
    const command = new SignUpCommand({
      email: 'test@email.com',
      password: '1234567As',
      displayName: 'Full Name',
    });
    await expect(handler.execute(command)).rejects.toThrow(
      new PersistenceErrorException(
        UserEntity.name,
        JSON.stringify(thrownError),
        SignUpCommand.name,
        JSON.stringify(command)
      )
    );
  });
});
