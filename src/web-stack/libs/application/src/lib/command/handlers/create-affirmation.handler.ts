import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';
import { CreateAffirmationCommand } from '../impl/create-affirmation.command';
import { InjectRepository } from '@nestjs/typeorm';
import {
  AffirmationDto,
  AffirmationEntity,
  AffirmationRepository,
  PersistenceErrorException,
} from '@web-stack/domain';
import { Repository } from 'typeorm';
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
    const createdBy = await this.authUserService.user(authUser);
    const newAffirmation = new AffirmationEntity({
      title,
      subtitle,
      createdBy,
    });

    return await this.affirmationRepository
      .save(newAffirmation)
      .then((result) => {
        return new AffirmationDto({
          ...result,
        });
      })
      .catch((err) => {
        throw new PersistenceErrorException(
          AffirmationEntity.name,
          JSON.stringify(err),
          CreateAffirmationCommand.name,
          JSON.stringify(command)
        );
      });
  }
}
