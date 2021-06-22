import { Body, Controller, HttpCode, Post } from '@nestjs/common';
import { CommandBus, QueryBus } from '@nestjs/cqrs';
import { CreateUserCommand } from './commands/impl/create-user.command';
import { CreateUserCommandResponseData } from './models/user.model';

@Controller('users')
export class UsersController {
  constructor(
    private commandBus: CommandBus,
    private queryBusy: QueryBus
  ) {
  }

  @Post()
  @HttpCode(200)
  async createUser(@Body() command: CreateUserCommand): Promise<CreateUserCommandResponseData> {
    return this.commandBus.execute(new CreateUserCommand(command.name, command.password));
  }
}
