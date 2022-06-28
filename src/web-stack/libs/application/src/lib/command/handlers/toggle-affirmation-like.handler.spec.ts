import { Test } from '@nestjs/testing';
import {
  AffirmationDto,
  AffirmationEntity,
  AffirmationLikeEntity,
  AffirmationLikeRepository,
  affirmationLikeStub,
  AffirmationObjectResponseDto,
  AffirmationRepository,
  affirmationStub,
  FirebaseUserInfo,
  MissingRequiredParamException,
  ObjectNotFoundException,
  userStub,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';
import { ToggleAffirmationLikeCommand } from '../impl/toggle-affirmation-like.command';
import { ToggleAffirmationLikeHandler } from './toggle-affirmation-like.handler';

describe('ToggleAffirmationLikeHandler', () => {
  // Reference to solution for ensuring objects match in function tests:
  // https://stackoverflow.com/a/64414223/5472560
  const _userStub = userStub();
  const _affirmationStub = affirmationStub();
  const _affirmationLikeStub = affirmationLikeStub();

  let mockAffirmationRepository = {};
  let affirmationRepository: AffirmationRepository;
  let mockAffirmationLikeRepository = {};
  let affirmationLikeRepository: AffirmationLikeRepository;
  const mockAuthUserService = {
    user: jest.fn().mockResolvedValue(_userStub),
  };
  let userService: AuthUserService;
  let handler: ToggleAffirmationLikeHandler;

  const authUser = new FirebaseUserInfo({
    uid: '123',
    emailVerified: false,
    displayName: 'Test full name',
    email: 'test@email.com',
    phoneNumber: null,
    photoURL: null,
    providerId: null,
  });

  const validCommand = new ToggleAffirmationLikeCommand({
    id: 123,
    byUser: authUser,
  });

  beforeEach(async () => {
    mockAffirmationRepository = {
      findOneOrFail: jest.fn().mockResolvedValue(_affirmationStub),
      save: jest.fn().mockResolvedValue(_affirmationStub),
    };
    mockAffirmationLikeRepository = {
      findOne: jest.fn().mockResolvedValue(_affirmationLikeStub),
      save: jest.fn().mockResolvedValue(_affirmationLikeStub),
      remove: jest.fn().mockResolvedValue(_affirmationLikeStub),
    };
    const moduleRef = await Test.createTestingModule({
      providers: [
        ToggleAffirmationLikeHandler,
        {
          provide: AuthUserService,
          useValue: mockAuthUserService,
        },
        {
          provide: AffirmationRepository,
          useValue: mockAffirmationRepository,
        },
        {
          provide: AffirmationLikeRepository,
          useValue: mockAffirmationLikeRepository,
        },
      ],
    }).compile();

    handler = moduleRef.get<ToggleAffirmationLikeHandler>(
      ToggleAffirmationLikeHandler
    );
    userService = moduleRef.get<AuthUserService>(AuthUserService);
    affirmationRepository = moduleRef.get<AffirmationRepository>(
      AffirmationRepository
    );
    affirmationLikeRepository = moduleRef.get<AffirmationLikeRepository>(
      AffirmationLikeRepository
    );

    jest.clearAllMocks();
  });

  it('throws error if `id` param is missing', async () => {
    const command = new ToggleAffirmationLikeCommand({
      id: undefined,
      byUser: authUser,
    });
    await expect(handler.execute(command)).rejects.toThrow(
      new MissingRequiredParamException(
        ToggleAffirmationLikeCommand.name,
        'id',
        'number'
      )
    );
  });

  it('throws error if `authUser` param is missing', async () => {
    const command = new ToggleAffirmationLikeCommand({
      id: 123,
      byUser: undefined,
    });
    await expect(handler.execute(command)).rejects.toThrow(
      new MissingRequiredParamException(
        ToggleAffirmationLikeCommand.name,
        'byUser',
        FirebaseUserInfo.name
      )
    );
  });

  it('calls authUserService correctly', async () => {
    jest.spyOn(userService, 'user');
    await handler.execute(validCommand);
    expect(userService.user).toHaveBeenCalledWith(validCommand.byUser);
  });

  it('given authUserService.user success, fetches affirmation correctly', async () => {
    jest.spyOn(affirmationRepository, 'findOneOrFail');
    await handler.execute(validCommand);
    expect(affirmationRepository.findOneOrFail).toHaveBeenCalledWith({
      where: { id: validCommand.id },
    });
  });

  it('given error in fetching affirmation, throws `ObjectNotFoundException` correctly', async () => {
    const thrownError = new Error('test error');
    jest
      .spyOn(affirmationRepository, 'findOneOrFail')
      .mockRejectedValue(thrownError);
    await expect(handler.execute(validCommand)).rejects.toThrow(
      new ObjectNotFoundException(
        AffirmationEntity.name,
        validCommand.id,
        ToggleAffirmationLikeCommand.name,
        JSON.stringify(validCommand)
      )
    );
  });

  describe('affirmation successfully fetched', () => {
    it('checks if an AffirmationLikeEntity for the affirmation by the same user already exists', async () => {
      jest.spyOn(affirmationLikeRepository, 'findOne');
      await handler.execute(validCommand);
      expect(affirmationLikeRepository.findOne).toHaveBeenCalledWith({
        where: {
          byUser: _userStub,
          affirmation: _affirmationStub,
        },
      });
    });

    describe('given AffirmationLikeEntity already exists', () => {
      let resultDto: AffirmationObjectResponseDto;
      beforeEach(async () => {
        jest.spyOn(affirmationLikeRepository, 'findOne');
        resultDto = await handler.execute(validCommand);
      });
      it('deletes the existing AffirmationLikeEntity', () => {
        jest.spyOn(affirmationLikeRepository, 'remove');
        expect(affirmationLikeRepository.remove).toHaveBeenCalledWith(
          _affirmationLikeStub
        );
      });

      it('results in an unliked Affirmation', () => {
        const expectedDto = new AffirmationObjectResponseDto({
          affirmationData: new AffirmationDto({ ..._affirmationStub }),
          liked: false,
        });

        expect(resultDto).toEqual(expectedDto);
      });
    });

    describe('given AffirmationLikeEntity does not already exist', () => {
      let resultDto: AffirmationObjectResponseDto;
      beforeEach(async () => {
        jest
          .spyOn(affirmationLikeRepository, 'findOne')
          .mockResolvedValue(null);
        jest.spyOn(affirmationLikeRepository, 'save');
        resultDto = await handler.execute(validCommand);
      });

      it('creates a new AffirmationLikeEntity', () => {
        expect(affirmationLikeRepository.save).toHaveBeenCalledWith(
          new AffirmationLikeEntity({
            affirmation: _affirmationStub,
            byUser: _userStub,
          })
        );
      });

      it('results in a liked Affirmation', () => {
        const expectedDto = new AffirmationObjectResponseDto({
          affirmationData: new AffirmationDto({ ..._affirmationStub }),
          liked: true,
        });

        expect(resultDto).toEqual(expectedDto);
      });
    });
  });
});
