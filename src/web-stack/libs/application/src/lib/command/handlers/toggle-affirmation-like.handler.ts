import {CommandHandler, ICommandHandler} from "@nestjs/cqrs";
import {InjectRepository} from "@nestjs/typeorm";
import {
  AffirmationDto,
  AffirmationEntity,
  AffirmationLikeEntity,
  AffirmationObjectResponseDto,
  ObjectNotFoundException,
} from "@web-stack/domain";
import {Repository} from "typeorm";
import {AuthUserService} from "../../services/auth-user.service";
import {ToggleAffirmationLikeCommand} from "../impl/toggle-affirmation-like.command";

@CommandHandler(ToggleAffirmationLikeCommand)
export class ToggleAffirmationLikeHandler implements ICommandHandler<ToggleAffirmationLikeCommand> {
  constructor(
    @InjectRepository(AffirmationEntity)
    private readonly affirmationRepo: Repository<AffirmationEntity>,
    @InjectRepository(AffirmationLikeEntity)
    private readonly affirmationLikeRepo: Repository<AffirmationLikeEntity>,
    private readonly authUserService: AuthUserService,
  ) {
  }

  async execute(command: ToggleAffirmationLikeCommand): Promise<AffirmationObjectResponseDto> {
    const {id, byUser} = command;
    const by = await this.authUserService.user(byUser);
    const affirmation = await this.affirmationRepo
      .findOneOrFail({
        where: {id}
      })
      .catch(() => {
        throw new ObjectNotFoundException(
          AffirmationEntity.name,
          id,
          ToggleAffirmationLikeCommand.name,
          JSON.stringify(command)
        )
      });

    const like = await this.affirmationLikeRepo
      .findOne({where: {byUser: by, affirmation}});

    if (like) {
      await like.remove();
      return new AffirmationObjectResponseDto({
        affirmationData: new AffirmationDto({...affirmation}),
        liked: false,
      });
    } else {
      await this.affirmationLikeRepo.save(new AffirmationLikeEntity({
        affirmation,
        byUser: by,
      }));
      return new AffirmationObjectResponseDto({
        affirmationData: new AffirmationDto({...affirmation}),
        liked: true,
      });
    }
  }
}
