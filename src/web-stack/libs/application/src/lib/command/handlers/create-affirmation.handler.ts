import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';
import { CreateAffirmationCommand } from '../impl/create-affirmation.command';
import {
  AffirmationDto,
  AffirmationEntity,
  AffirmationRepository,
  MissingRequiredParamException,
  PersistenceErrorException,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';

@CommandHandler(CreateAffirmationCommand)
export class CreateAffirmationHandler
  implements ICommandHandler<CreateAffirmationCommand>
{
  constructor(
    private readonly affirmationRepository: AffirmationRepository,
    private readonly authUserService: AuthUserService
  ) {}

  async execute(command: CreateAffirmationCommand): Promise<AffirmationDto> {
    const { title, subtitle, authUser } = command;
    if (!title)
      throw new MissingRequiredParamException(
        CreateAffirmationCommand.name,
        'title',
        'string'
      );
    const createdBy = await this.authUserService.user(authUser);
    const newAffirmation = new AffirmationEntity({
      title,
      subtitle,
      createdBy,
    });

    const result = await this.affirmationRepository
      .save(newAffirmation)
      .catch((err) => {
        throw new PersistenceErrorException(
          AffirmationEntity.name,
          JSON.stringify(err),
          CreateAffirmationCommand.name,
          JSON.stringify(command)
        );
      });

    return new AffirmationDto({
      ...result,
    });
  }
}
