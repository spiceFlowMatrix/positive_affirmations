import {CommandHandler, ICommandHandler} from "@nestjs/cqrs";
import {CreateAffirmationCommand} from "../impl/create-affirmation.command";
import {InjectRepository} from "@nestjs/typeorm";
import {AffirmationEntity} from "@web-stack/domain";
import {Repository} from "typeorm";
import {AuthUserService} from "../../services/auth-user.service";

@CommandHandler(CreateAffirmationCommand)
export class CreateAffirmationHandler implements ICommandHandler<CreateAffirmationCommand> {
  constructor(
    @InjectRepository(AffirmationEntity)
    private readonly affirmationEntity: Repository<AffirmationEntity>,
    private readonly authUserService: AuthUserService,
  ) {
  }

  async execute(command: CreateAffirmationCommand): Promise<any> {
    return Promise.resolve(undefined);
  }
}
