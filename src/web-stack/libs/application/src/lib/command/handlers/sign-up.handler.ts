import {CommandHandler, ICommandHandler} from "@nestjs/cqrs";
import {SignUpCommand} from "../impl/sign-up.command";
import {InjectRepository} from "@nestjs/typeorm";
import {UserEntity} from "@web-stack/domain";
import {Repository} from "typeorm";

@CommandHandler(SignUpCommand)
export class SignUpHandler implements ICommandHandler<SignUpCommand> {
  constructor(
    @InjectRepository(UserEntity)
    protected readonly userRepo: Repository<UserEntity>
  ) {
  }

  async execute(command: SignUpCommand): Promise<void> {
    return Promise.resolve(undefined);
  }
}
