import { CommandBus, QueryBus } from '@nestjs/cqrs';
import { Test } from '@nestjs/testing';
import { SignUpCommand } from '@web-stack/application';
import {
  MissingRequiredParamException,
  SignUpCommandDto,
} from '@web-stack/domain';
import { UsersApiFacade } from './users-api.facade';

describe('UsersApiFacade', () => {
  let facade: UsersApiFacade;
  const mockQueryBus = {
    execute: jest.fn(),
  };
  const mockCommandBus = {
    execute: jest.fn().mockResolvedValue({}),
  };
  let queryBus: QueryBus;
  let commandBus: CommandBus;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        UsersApiFacade,
        { provide: QueryBus, useFactory: () => mockQueryBus },
        { provide: CommandBus, useFactory: () => mockCommandBus },
      ],
    }).compile();

    facade = await moduleRef.resolve<UsersApiFacade>(UsersApiFacade);
    queryBus = await moduleRef.resolve<QueryBus>(QueryBus);
    commandBus = await moduleRef.resolve<CommandBus>(CommandBus);

    jest.clearAllMocks();
  });

  it('throws error if "dto" is missing', async () => {
    await expect(facade.signUpUser(undefined)).rejects.toThrow(
      new MissingRequiredParamException(
        `${UsersApiFacade.name}.getAffirmationList`,
        'dto',
        `${SignUpCommandDto.name}`
      )
    );
  });

  it('correctly executes "SignUpCommand"', async () => {
    jest.spyOn(commandBus, 'execute');
    const dto = new SignUpCommandDto({
      displayName: 'test display name',
      nickName: 'testNickName',
      email: 'test@email.com',
      password: '1234567As',
    });
    await facade.signUpUser(dto);
    expect(commandBus.execute).toHaveBeenCalledWith(
      new SignUpCommand({
        displayName: 'test display name',
        nickName: 'testNickName',
        email: 'test@email.com',
        password: '1234567As',
      })
    );
  });
});
