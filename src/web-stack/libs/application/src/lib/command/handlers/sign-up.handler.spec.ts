import { SignUpHandler } from './sign-up.handler';
import { Test } from '@nestjs/testing';
import {
  firebaseUserInfoStub,
  UserRepository,
  userStub,
} from '@web-stack/domain';
import { FirebaseAdminService } from '@web-stack/services';

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

  it('is defined', () => {
    expect(handler).toBeDefined();
    expect(repository).toBeDefined();
    expect(adminService).toBeDefined();
  });
});
