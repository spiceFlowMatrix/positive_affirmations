import { Test } from '@nestjs/testing';
import {
  FirebaseUserInfo,
  MissingRequiredParamException,
  PersistenceErrorException,
  UserEntity,
  UserRepository,
  userStub,
} from '@web-stack/domain';
import { AuthUserService } from './auth-user.service';

describe('AuthUserService', () => {
  const _userStub = userStub();
  const _savedAuthUser: UserEntity = {
    ..._userStub,
    displayName: 'Save result auth user',
  };
  let service: AuthUserService;
  let repository: UserRepository;

  const mockRepository = {
    find: jest.fn().mockResolvedValue([_userStub]),
    findOne: jest.fn().mockResolvedValue(_userStub),
    save: jest.fn().mockResolvedValue(_savedAuthUser),
  };

  const authUser = new FirebaseUserInfo({
    uid: '123',
    emailVerified: false,
    displayName: 'Test full name',
    email: 'test@email.com',
    phoneNumber: null,
    photoURL: null,
    providerId: null,
  });

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        AuthUserService,
        {
          provide: UserRepository,
          useValue: mockRepository,
        },
      ],
    }).compile();

    service = moduleRef.get<AuthUserService>(AuthUserService);
    repository = moduleRef.get<UserRepository>(UserRepository);

    jest.clearAllMocks();
  });

  describe('function: user', () => {
    it('throws `MissingRequiredParamException` if authUser param is missing', async () => {
      await expect(service.user(undefined)).rejects.toThrow(
        new MissingRequiredParamException(
          `${AuthUserService.name}.user(authUser)`,
          'authUser',
          FirebaseUserInfo.name
        )
      );
    });

    it('checks if given authUser is already registered in database', async () => {
      jest.spyOn(repository, 'findOne');
      await service.user(authUser);
      expect(repository.findOne).toHaveBeenCalledWith({
        where: { uid: authUser.uid },
      });
    });

    describe('authUser already registered', () => {
      it('does not attempt to register the user again', async () => {
        jest.spyOn(repository, 'save');
        await service.user(authUser);
        expect(repository.save).toHaveBeenCalledTimes(0);
      });

      it('returns the resulting UserEntity', async () => {
        const resultEntity = await service.user(authUser);
        expect(resultEntity).toEqual(_userStub);
      });
    });

    describe('authUser not registered', () => {
      let savedUserResult: UserEntity;
      beforeEach(async () => {
        jest.spyOn(repository, 'save');
        jest.spyOn(repository, 'findOne').mockResolvedValue(undefined);

        savedUserResult = await service.user(authUser);
      });

      it('registers a new UserEntity in database for the given authUser', () => {
        expect(repository.save).toHaveBeenCalledWith(
          new UserEntity({
            displayName: authUser.displayName,
            email: authUser.email,
            emailVerified: authUser.emailVerified,
            phoneNumber: authUser.phoneNumber,
            photoURL: authUser.photoURL,
            providerId: authUser.providerId,
            uid: authUser.uid,
          })
        );
      });

      it('returns newly saved UserEntity', () => {
        expect(savedUserResult).toEqual(_savedAuthUser);
      });
    });

    it('throws correct PersistenceErrorException if repository.save fails', async () => {
      const thrownError = new Error('test error');
      jest.spyOn(repository, 'save').mockRejectedValue(thrownError);

      await expect(service.user(authUser)).rejects.toThrow(
        new PersistenceErrorException(
          UserEntity.name,
          JSON.stringify(thrownError),
          `${AuthUserService.name}.user(authUser)`,
          JSON.stringify(authUser)
        )
      );
    });
  });
});
