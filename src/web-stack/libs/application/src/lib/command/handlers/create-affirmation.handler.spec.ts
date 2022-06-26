import { CqrsModule } from '@nestjs/cqrs';
import { Test } from '@nestjs/testing';
import { IFirebaseUserInfo } from '@web-stack/api-interfaces';
import {
  AffirmationDto,
  AffirmationEntity,
  AffirmationRepository,
  affirmationStub,
  PersistenceErrorException,
  userStub,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';
import { CreateAffirmationCommand } from '../impl/create-affirmation.command';
import { CreateAffirmationHandler } from './create-affirmation.handler';

describe('CreateAffirmationHandler', () => {
  let mockRepository = {};
  const mockAuthUserService = {
    user: jest.fn().mockResolvedValue(userStub()),
  };
  let handler: CreateAffirmationHandler;
  let repository: AffirmationRepository;
  let userService: AuthUserService;
  beforeEach(async () => {
    mockRepository = {
      find: jest.fn().mockResolvedValue([affirmationStub()]),
      save: jest.fn().mockResolvedValue(affirmationStub()),
    };
    const moduleRef = await Test.createTestingModule({
      imports: [CqrsModule],
      providers: [
        CreateAffirmationHandler,
        {
          provide: AffirmationRepository,
          useValue: mockRepository,
        },
        {
          provide: AuthUserService,
          useValue: mockAuthUserService,
        },
      ],
    }).compile();

    handler = moduleRef.get<CreateAffirmationHandler>(CreateAffirmationHandler);
    repository = moduleRef.get<AffirmationRepository>(AffirmationRepository);
    userService = moduleRef.get<AuthUserService>(AuthUserService);

    jest.clearAllMocks();
  });

  describe('execute', () => {
    const authUser: IFirebaseUserInfo = {
      uid: '123',
      emailVerified: false,
      displayName: '',
      email: 'test@email.com',
      phoneNumber: null,
      photoURL: null,
      providerId: null,
    };
    it('calls authUserService', () => {
      jest.spyOn(userService, 'user');
      handler.execute({ title: 'test', authUser });
      expect(userService.user).toHaveBeenCalledWith(authUser);
    });

    it('saves new affirmation through repository', async () => {
      jest.spyOn(repository, 'save');
      await handler.execute({ title: 'test', authUser });
      expect(repository.save).toHaveBeenCalledWith(<AffirmationEntity>{
        title: 'test',
        createdBy: userStub(),
      });
    });

    it('given `subtitle` parameter, saves value in database', async () => {
      jest.spyOn(repository, 'save');
      await handler.execute({
        title: 'test',
        subtitle: 'test subtitle',
        authUser,
      });
      expect(repository.save).toHaveBeenCalledWith(<AffirmationEntity>{
        title: 'test',
        subtitle: 'test subtitle',
        createdBy: userStub(),
      });
    });

    it('returns correct dto on success', async () => {
      const expectedDto: AffirmationDto = {
        ...affirmationStub(),
      };
      const actualDto = await handler.execute({
        title: affirmationStub().title,
        authUser,
      });
      expect(JSON.stringify(actualDto)).toEqual(JSON.stringify(expectedDto));
    });

    it('throws error if `title` is missing', async () => {
      await expect(
        handler.execute({ title: undefined, authUser })
      ).rejects.toThrowError();
    });

    it('given repository throws error, returns `PersistenceErrorException`', async () => {
      const thrownError = new Error('async error');
      const command: CreateAffirmationCommand = { title: 'test', authUser };
      jest.spyOn(repository, 'save').mockRejectedValue(thrownError);
      await expect(handler.execute(command)).rejects.toThrow(
        new PersistenceErrorException(
          AffirmationEntity.name,
          JSON.stringify(thrownError),
          CreateAffirmationCommand.name,
          JSON.stringify(command)
        )
      );
    });
  });
});
