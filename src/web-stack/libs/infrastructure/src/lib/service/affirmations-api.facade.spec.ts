import { CommandBus, QueryBus } from '@nestjs/cqrs';
import { Test } from '@nestjs/testing';
import { IAuthenticatedFirebaseRequest } from '../interfaces/authenticated-firebase-request';
import { AffirmationsApiFacade } from './affirmations-api.facade';
import { REQUEST } from '@nestjs/core';

describe('AffirmationsApiFacade', () => {
  const _userStub = {
    displayName: 'test name',
    phoneNumber: '5454545454',
    photoURL: 'http://photo.url.com',
    providerId: 'oauth2',
    uid: 'oauth2/123',
    email: 'test@email.com',
    emailVerified: false,
  };
  let facade: AffirmationsApiFacade;
  const mockQueryBus = {
    execute: jest.fn(),
  };
  const mockCommandBus = {
    execute: jest.fn().mockResolvedValue({}),
  };
  const mockRequest = {
    user: jest.fn().mockReturnValue(_userStub),
  };
  let queryBus: QueryBus;
  let commandBus: CommandBus;
  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        AffirmationsApiFacade,
        { provide: QueryBus, useFactory: () => mockQueryBus },
        { provide: CommandBus, useFactory: () => mockCommandBus },
        {
          provide: REQUEST,
          useFactory: () => mockRequest,
        },
      ],
    }).compile();

    facade = await moduleRef.resolve<AffirmationsApiFacade>(
      AffirmationsApiFacade
    );
    queryBus = await moduleRef.resolve<QueryBus>(QueryBus);
    commandBus = await moduleRef.resolve<CommandBus>(CommandBus);

    jest.clearAllMocks();
  });

  it('is defined', async () => {
    expect(facade).toBeDefined();
    expect(queryBus).toBeDefined();
    expect(commandBus).toBeDefined();
    // expect(request).toBeDefined();
    jest.spyOn(commandBus, 'execute');
    await facade.toggleAffirmationLiked(12);
    expect(commandBus.execute).toHaveBeenCalled();
  });
});
