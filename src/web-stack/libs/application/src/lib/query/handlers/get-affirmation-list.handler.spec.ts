import { Test } from '@nestjs/testing';
import { GetAffirmationListHandler } from './get-affirmation-list.handler';
import {
  AffirmationDto,
  AffirmationEntity,
  AffirmationObjectResponseDto,
  AffirmationRepository,
  affirmationStub,
  FirebaseUserInfo,
  GetAffirmationListQueryResponseDto,
  MissingRequiredParamException,
  userStub,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';
import { GetAffirmationListQuery } from '../impl/get-affirmation-list.query';

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

  const _likedAffirmations = [_affirmationStub];

  const mockCreateQueryBuilder = {
    where: jest.fn().mockReturnThis(),
    setParameter: jest.fn().mockReturnThis(),
    leftJoinAndSelect: jest.fn().mockReturnThis(),
    getOne: jest.fn().mockReturnThis(),
    getMany: jest.fn().mockResolvedValue(_likedAffirmations),
    andWhere: jest.fn().mockReturnThis(),
    orderBy: jest.fn().mockReturnThis(),
  };

  const [_findResults, _findTotal] = [[_affirmationStub], 1];

  beforeEach(async () => {
    mockAffirmationRepository = {
      findOneOrFail: jest.fn().mockResolvedValue(_affirmationStub),
      findAndCount: jest
        .fn()
        .mockResolvedValue(<[AffirmationEntity[], number]>[
          _findResults,
          _findTotal,
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

  describe('fetching paginated list of affirmations', () => {
    it('fetches affirmations from repository based on given args', async () => {
      jest.spyOn(affirmationRepository, 'findAndCount');
      await handler.execute(validQuery);
      expect(affirmationRepository.findAndCount).toHaveBeenCalledWith({
        relations: ['createdBy'],
        skip: validQuery.skip,
        take: validQuery.take,
      });
    });

    describe('no affirmations exist', () => {
      let resultDto: GetAffirmationListQueryResponseDto;
      beforeEach(async () => {
        jest
          .spyOn(affirmationRepository, 'findAndCount')
          .mockResolvedValue([[], 0]);
        resultDto = await handler.execute(validQuery);
      });

      it('does not build query to filter likes', () => {
        jest.spyOn(affirmationRepository, 'createQueryBuilder');
        expect(affirmationRepository.createQueryBuilder).toBeCalledTimes(0);
      });

      it('returns valid dto with empty list of affirmations', () => {
        const expectedDto = new GetAffirmationListQueryResponseDto({
          totalResults: 0,
          results: [],
        });

        expect(resultDto).toEqual(expectedDto);
      });
    });

    describe('returns list of affirmations', () => {
      let resultDto: GetAffirmationListQueryResponseDto;
      beforeEach(async () => {
        resultDto = await handler.execute(validQuery);
      });

      it('returns valid dto with list of affirmations showing likes', () => {
        const expectedDto = new GetAffirmationListQueryResponseDto({
          totalResults: _findTotal,
          results: _findResults.map((result) => {
            return new AffirmationObjectResponseDto({
              affirmationData: new AffirmationDto({ ...result }),
              liked:
                _likedAffirmations.filter((e) => e.id == result.id).length > 0,
            });
          }),
        });

        expect(resultDto).toEqual(expectedDto);
      });

      it('builds query to fetch likes for returned affirmations', async () => {
        // Solution for testing chained functions adapted from:
        // https://stackoverflow.com/a/57727703/5472560
        jest.spyOn(affirmationRepository, 'createQueryBuilder');

        expect(affirmationRepository.createQueryBuilder).toHaveBeenCalledWith(
          'affirmation'
        );

        expect(
          affirmationRepository.createQueryBuilder().leftJoinAndSelect
        ).toHaveBeenCalledWith('affirmation.likes', 'like');

        expect(
          affirmationRepository.createQueryBuilder().leftJoinAndSelect
        ).toHaveBeenCalledWith('like.byUser', 'likedBy');

        expect(
          affirmationRepository.createQueryBuilder().where
        ).toHaveBeenCalledWith('affirmation.id IN (:...affirmationIds)', {
          affirmationIds: _findResults.map((e) => e.id),
        });

        expect(
          affirmationRepository.createQueryBuilder().andWhere
        ).toHaveBeenCalledWith('likedBy.dbId = :byUserId', {
          byUserId: _userStub.dbId,
        });

        expect(
          affirmationRepository.createQueryBuilder().orderBy
        ).toHaveBeenCalledWith('affirmation.createdOn', 'DESC');

        expect(
          affirmationRepository.createQueryBuilder().getMany
        ).toHaveBeenCalled();
      });
    });
  });
});
