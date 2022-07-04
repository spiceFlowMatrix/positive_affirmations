import { CommandBus, QueryBus } from '@nestjs/cqrs';
import { Test } from '@nestjs/testing';
import { AffirmationsApiFacade } from './affirmations-api.facade';
import { REQUEST } from '@nestjs/core';
import {
  CreateAffirmationCommandDto,
  GetAffirmationListQueryDto,
  MissingRequiredParamException,
} from '@web-stack/domain';
import {
  CreateAffirmationCommand,
  GetAffirmationListQuery,
  ToggleAffirmationLikeCommand,
} from '@web-stack/application';

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
    user: _userStub,
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

  describe('getAffirmationList', () => {
    it('throws error if "dto" is missing', async () => {
      await expect(facade.getAffirmationList(undefined)).rejects.toThrow(
        new MissingRequiredParamException(
          `${AffirmationsApiFacade.name}.getAffirmationList`,
          'dto',
          `${GetAffirmationListQueryDto.name}`
        )
      );
    });

    it('correctly executes "GetAffirmationListQuery"', async () => {
      jest.spyOn(queryBus, 'execute');
      await facade.getAffirmationList({ skip: 0, take: 10 });
      expect(queryBus.execute).toHaveBeenCalledWith(
        new GetAffirmationListQuery({
          skip: 0,
          take: 10,
          authUser: _userStub,
        })
      );
    });
  });

  describe('createAffirmation', () => {
    it('throws error if "dto" is missing', async () => {
      await expect(facade.createAffirmation(undefined)).rejects.toThrow(
        new MissingRequiredParamException(
          `${AffirmationsApiFacade.name}.createAffirmation`,
          'dto',
          `${CreateAffirmationCommandDto.name}`
        )
      );
    });

    it('correctly executes "CreateAffirmationCommand"', async () => {
      jest.spyOn(commandBus, 'execute');
      await facade.createAffirmation({
        title: 'test title',
        subtitle: 'test subtitle',
      });
      expect(commandBus.execute).toHaveBeenCalledWith(
        new CreateAffirmationCommand({
          title: 'test title',
          subtitle: 'test subtitle',
          authUser: _userStub,
        })
      );
    });
  });

  describe('toggleAffirmationLiked', () => {
    it('throws error if "id" is missing', async () => {
      await expect(facade.toggleAffirmationLiked(undefined)).rejects.toThrow(
        new MissingRequiredParamException(
          `${AffirmationsApiFacade.name}.toggleAffirmationLike`,
          'id',
          'number'
        )
      );
    });

    it('correctly executes "ToggleAffirmationLikeCommand"', async () => {
      jest.spyOn(commandBus, 'execute');
      await facade.toggleAffirmationLiked(123);
      expect(commandBus.execute).toHaveBeenCalledWith(
        new ToggleAffirmationLikeCommand({ id: 123, byUser: _userStub })
      );
    });
  });
});
