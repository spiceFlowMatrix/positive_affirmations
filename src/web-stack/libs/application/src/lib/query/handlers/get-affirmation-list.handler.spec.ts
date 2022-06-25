import {Test, TestingModule} from '@nestjs/testing';
import {GetAffirmationListHandler} from './get-affirmation-list.handler';
import {AffirmationEntity, UserEntity} from '@web-stack/domain';
import {getRepositoryToken, TypeOrmModule} from '@nestjs/typeorm';
import {SnakeNamingStrategy} from 'typeorm-naming-strategies';
import {AuthUserService} from '../../services/auth-user.service';
import {of} from 'rxjs';
import {getRepository} from 'typeorm';

/* WIP learning testing. References:
https://stackoverflow.com/questions/55366037/inject-typeorm-repository-into-nestjs-service-for-mock-data-testing
https://codesandbox.io/s/kmlrj?file=/apps/cqrs-sample/src/say-hello.handler.spec.ts

* */

describe('GetAffirmationListHandler', () => {
  let handler: GetAffirmationListHandler;
  let moduleRef: TestingModule;
  let mockAuthUser: UserEntity = undefined;
  let authUserServiceStub = {
    user: jest.fn((authUser) => of(mockAuthUser))
  };

  beforeEach(async () => {
    moduleRef = await Test.createTestingModule({
      imports: [
        TypeOrmModule.forRoot({
          type: 'postgres',
          host: '127.0.0.1',
          port: 5432,
          username: 'postgres',
          password: 'mypassword',
          database: 'postgres',
          schema: 'testing',
          autoLoadEntities: true,
          synchronize: true,
          useUTC: true,
          namingStrategy: new SnakeNamingStrategy(),
          dropSchema: true
        }),
        TypeOrmModule.forFeature([AffirmationEntity])
      ],
      providers: [
        GetAffirmationListHandler,
        {
          provide: AuthUserService,
          useFactory: () => authUserServiceStub
        }
      ]
    }).compile();

    handler = moduleRef.get(GetAffirmationListHandler);
  });

  afterEach(async () => {
    await moduleRef.close();
  });

  it('should be defined', () => {
    expect(handler).toBeDefined();
  });

  it('throws error if arguments are missing', async () => {
    // Solution for testing errors adapted from following solution:
    // https://stackoverflow.com/a/50656680/5472560
    await expect(handler.execute({skip: undefined, take: undefined, authUser: undefined}))
      .rejects.toThrowError();
  });

  // it('fetches user from user service', async () => {
  //   const repoSpy = jest.spyOn(authUserServiceStub, 'user');
  //   await handler.execute({skip: undefined, take: undefined, authUser: undefined});
  //   expect(repoSpy).toBeCalled();
  // });
});
