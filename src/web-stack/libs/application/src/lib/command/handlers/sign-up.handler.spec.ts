import {SignUpHandler} from "./sign-up.handler";
import {Test} from "@nestjs/testing";
import {CqrsModule} from "@nestjs/cqrs";
import {UserEntity} from "@web-stack/domain";
import {getRepositoryToken} from "@nestjs/typeorm";
import {FirebaseAdminService} from "@web-stack/services";
import {Repository} from "typeorm";

describe('SignUpHandler', () => {
  let signUpHandler: SignUpHandler;
  let userRepository: Repository<UserEntity>;
  let firebaseAdminService: FirebaseAdminService;

  beforeEach(async () => {

    // Reference for WIP CQRS testing:
    // https://github.com/nestjs/nest/issues/274
    const moduleRef = await Test.createTestingModule({
      imports: [CqrsModule],
      providers: [
        {
          // Solution for injecting typeorm entity repositories for tests:
          // https://stackoverflow.com/a/58163804/5472560
          provide: getRepositoryToken(UserEntity),
          useFactory: () => jest.fn(),
        },
        {
          provide: FirebaseAdminService,
          useFactory: () => jest.fn(),
        },
        SignUpHandler
      ],
    }).compile();

    signUpHandler = moduleRef.get<SignUpHandler>(SignUpHandler);
    userRepository = moduleRef.get<Repository<UserEntity>>(getRepositoryToken(UserEntity));
    firebaseAdminService = moduleRef.get<FirebaseAdminService>(FirebaseAdminService);
  });

  it('is defined', () => {
    expect(signUpHandler).toBeDefined();
    expect(userRepository).toBeDefined();
    expect(firebaseAdminService).toBeDefined();
  });
});
