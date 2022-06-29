import { Test } from '@nestjs/testing';
import { GetAffirmationListHandler } from './get-affirmation-list.handler';
import {
  AffirmationEntity,
  AffirmationRepository,
  affirmationStub,
  FirebaseUserInfo,
  MissingRequiredParamException,
  userStub,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';
import { GetAffirmationListQuery } from '../impl/get-affirmation-list.query';
import { ResourceLimits } from 'worker_threads';

describe('GetAffirmationListHandler', () => {
  const _userStub = userStub();
  const _affirmationStub = affirmationStub();

  let mockAffirmationRepository = {};
  let affirmationRepository: AffirmationRepository;
  const mockAuthUserService = {
    user: jest.fn().mockResolvedValue(_userStub),
  };
  let userService: AuthUserService;
  let handler: GetAffirmationListHandler;

  const authUser = new FirebaseUserInfo({
    uid: '123',
    emailVerified: false,
    displayName: 'Test full name',
    email: 'test@email.com',
    phoneNumber: null,
    photoURL: null,
    providerId: null,
  });

  const validQuery = new GetAffirmationListQuery({
    skip: 0,
    take: 10,
    authUser,
  });

  const mockCreateQueryBuilder = {
    where: jest.fn().mockReturnThis(),
    setParameter: jest.fn().mockReturnThis(),
    leftJoinAndSelect: jest.fn().mockReturnThis(),
    getOne: jest.fn().mockReturnThis(),
    getMany: jest.fn().mockResolvedValue([_affirmationStub]),
    andWhere: jest.fn().mockReturnThis(),
    orderBy: jest.fn().mockReturnThis(),
  };

  beforeEach(async () => {
    mockAffirmationRepository = {
      findOneOrFail: jest.fn().mockResolvedValue(_affirmationStub),
      findAndCount: jest
        .fn()
        .mockResolvedValue(<[AffirmationEntity[], number]>[
          [_affirmationStub],
          1,
        ]),
      save: jest.fn().mockResolvedValue(_affirmationStub),
      getLikedAffirmationsIn: jest.fn().mockResolvedValue([_affirmationStub]),
      createQueryBuilder: jest.fn(() => mockCreateQueryBuilder),
    };
    const moduleRef = await Test.createTestingModule({
      providers: [
        GetAffirmationListHandler,
        {
          provide: AuthUserService,
          useValue: mockAuthUserService,
        },
        {
          provide: AffirmationRepository,
          useValue: mockAffirmationRepository,
        },
      ],
    }).compile();

    handler = moduleRef.get<GetAffirmationListHandler>(
      GetAffirmationListHandler
    );
    affirmationRepository = moduleRef.get<AffirmationRepository>(
      AffirmationRepository
    );
    userService = moduleRef.get<AuthUserService>(AuthUserService);

    jest.clearAllMocks();
  });

  describe('args', () => {
    // Solution for testing errors adapted from following solution:
    // https://stackoverflow.com/a/50656680/5472560
    it('throws MissingRequiredParamException if `skip` param is missing', async () => {
      await expect(
        handler.execute({ skip: undefined, take: 10, authUser })
      ).rejects.toThrow(
        new MissingRequiredParamException(
          GetAffirmationListQuery.name,
          'skip',
          'number'
        )
      );
    });
    it('throws MissingRequiredParamException if `take` param is missing', async () => {
      await expect(
        handler.execute({ skip: 0, take: undefined, authUser })
      ).rejects.toThrow(
        new MissingRequiredParamException(
          GetAffirmationListQuery.name,
          'take',
          'number'
        )
      );
    });
    it('throws MissingRequiredParamException if `authUser` param is missing', async () => {
      await expect(
        handler.execute({ skip: 0, take: 10, authUser: undefined })
      ).rejects.toThrow(
        new MissingRequiredParamException(
          GetAffirmationListQuery.name,
          'authUser',
          FirebaseUserInfo.name
        )
      );
    });
  });

  it('fetches user from user service', async () => {
    jest.spyOn(userService, 'user');
    await handler.execute(validQuery);
    expect(userService.user).toHaveBeenCalledWith(authUser);
  });
});
