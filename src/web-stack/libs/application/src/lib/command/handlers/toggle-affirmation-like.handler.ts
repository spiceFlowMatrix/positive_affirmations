import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';
import {
  AffirmationDto,
  AffirmationEntity,
  AffirmationLikeEntity,
  AffirmationLikeRepository,
  AffirmationObjectResponseDto,
  AffirmationRepository,
  FirebaseUserInfo,
  MissingRequiredParamException,
  ObjectNotFoundException,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';
import { ToggleAffirmationLikeCommand } from '../impl/toggle-affirmation-like.command';

@CommandHandler(ToggleAffirmationLikeCommand)
export class ToggleAffirmationLikeHandler
  implements ICommandHandler<ToggleAffirmationLikeCommand>
{
  constructor(
    private readonly affirmationRepo: AffirmationRepository,
    private readonly affirmationLikeRepo: AffirmationLikeRepository,
    private readonly authUserService: AuthUserService
  ) {}

  async execute(
    command: ToggleAffirmationLikeCommand
  ): Promise<AffirmationObjectResponseDto> {
    const { id, byUser } = command;
    if (!id) {
      throw new MissingRequiredParamException(
        ToggleAffirmationLikeCommand.name,
        'id',
        'number'
      );
    }
    if (!byUser) {
      throw new MissingRequiredParamException(
        ToggleAffirmationLikeCommand.name,
        'byUser',
        FirebaseUserInfo.name
      );
    }

    const by = await this.authUserService.user(byUser);
    const affirmation = await this.affirmationRepo
      .findOneOrFail({
        where: { id },
      })
      .catch(() => {
        throw new ObjectNotFoundException(
          AffirmationEntity.name,
          id,
          ToggleAffirmationLikeCommand.name,
          JSON.stringify(command)
        );
      });

    const like = await this.affirmationLikeRepo.findOne({
      where: { byUser: by, affirmation },
    });

    if (like) {
      await this.affirmationLikeRepo.remove(like);
      return new AffirmationObjectResponseDto({
        affirmationData: new AffirmationDto({ ...affirmation }),
        liked: false,
      });
    } else {
      await this.affirmationLikeRepo.save(
        new AffirmationLikeEntity({
          affirmation,
          byUser: by,
        })
      );
      return new AffirmationObjectResponseDto({
        affirmationData: new AffirmationDto({ ...affirmation }),
        liked: true,
      });
    }
  }
}
