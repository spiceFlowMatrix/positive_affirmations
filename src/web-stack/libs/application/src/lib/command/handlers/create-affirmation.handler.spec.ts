import { CqrsModule } from '@nestjs/cqrs';
import { Test } from '@nestjs/testing';
import {
  AffirmationRepository,
  affirmationStub,
  userStub,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';
import { CreateAffirmationHandler } from './create-affirmation.handler';

describe('CreateAffirmationHandler', () => {
  const mockRepository = jest.fn().mockReturnValue({
    find: jest.fn().mockResolvedValue([affirmationStub()]),
  });
  const mockAuthUserService = jest.fn().mockReturnValue({
    user: jest.fn().mockReturnValue(userStub()),
  });
  let handler: CreateAffirmationHandler;
  let repository: AffirmationRepository;
  let userService: AuthUserService;
  beforeEach(async () => {
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

  test('exists', () => {
    expect(handler).toBeDefined();
    expect(repository).toBeDefined();
    expect(userService).toBeDefined();
  });
});
