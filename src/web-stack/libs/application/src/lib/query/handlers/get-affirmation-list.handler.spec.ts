import {Test} from '@nestjs/testing';
import {GetAffirmationListHandler} from './get-affirmation-list.handler';
import {createConnection, getConnection, getRepository, Repository} from 'typeorm';
import {AffirmationEntity} from '@web-stack/domain';
import {getRepositoryToken} from '@nestjs/typeorm';
import {ENTITIES} from '../../../../../domain/src/lib/entity';

/* WIP learning testing. References:
https://stackoverflow.com/questions/55366037/inject-typeorm-repository-into-nestjs-service-for-mock-data-testing
https://codesandbox.io/s/kmlrj?file=/apps/cqrs-sample/src/say-hello.handler.spec.ts

* */

describe('GetAffirmationListHandler', () => {
  let handler: GetAffirmationListHandler;
  const testConnectionName = 'testConnection';

  beforeEach(async () => {
    const connection = await createConnection({
      type: 'sqlite',
      database: ':memory:',
      dropSchema: true,
      entities: [...ENTITIES],
      synchronize: true,
      logging: false,
      name: testConnectionName
    });

    const moduleRef = await Test.createTestingModule({
      providers: [
        GetAffirmationListHandler,
        {
          provide: getRepositoryToken(AffirmationEntity, connection),
          useFactory: () => getRepository(AffirmationEntity, testConnectionName)
        }
      ]
    }).compile();

    handler = moduleRef.get(GetAffirmationListHandler);
  });

  afterEach(async () => {
    await getConnection(testConnectionName).close()
  });

  it('should be defined', () => {
    expect(handler).toBeDefined();
  });
});
