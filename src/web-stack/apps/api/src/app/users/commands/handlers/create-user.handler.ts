import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';
import { CreateUserCommand } from '../impl/create-user.command';
import { CreateUserCommandResponseData } from '../../models/user.model';
import { InjectRepository } from '@nestjs/typeorm';
import { UserEntity } from '../../entities/user.entity';
import { Repository } from 'typeorm';
import { InternalServerErrorException } from '@nestjs/common';

@CommandHandler(CreateUserCommand)
export class CreateUserHandler implements ICommandHandler<CreateUserCommand> {
  constructor(
    @InjectRepository(UserEntity)
    private userRepository: Repository<UserEntity>
  ) {
  }

  async execute(command: CreateUserCommand): Promise<CreateUserCommandResponseData> {
    const { name, password } = command;

    const newUser: UserEntity = <UserEntity>{
      name: name
    };

    const savedUser = await this.userRepository.save(newUser).catch((err) => {
      throw new InternalServerErrorException(
        `CreateUserCommand(${command}) failed with error(${err})`
      );
    });

    return <CreateUserCommandResponseData>{
      id: savedUser.id,
      name: savedUser.name
    };
  }
}
