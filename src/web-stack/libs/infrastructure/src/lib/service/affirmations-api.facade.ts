import {BaseApiFacade} from "./base-api.facade";
import {
  AffirmationDto,
  AffirmationObjectResponseDto,
  CreateAffirmationCommandDto,
  ToggleAffirmationLikeCommandDto
} from "@web-stack/domain";
import {CreateAffirmationCommand} from "@web-stack/application";
import {
  ToggleAffirmationLikeCommand
} from "../../../../application/src/lib/command/impl/toggle-affirmation-like.command";

export class AffirmationsApiFacade extends BaseApiFacade {
  async createAffirmation(dto: CreateAffirmationCommandDto): Promise<AffirmationDto> {
    return await this.commandBus.execute(new CreateAffirmationCommand({
      ...dto,
      authUser: this.request.user,
    }));
  }

  async toggleAffirmationLiked(id: number): Promise<AffirmationObjectResponseDto> {
    return await this.commandBus.execute(new ToggleAffirmationLikeCommand({
      id,
      byUser: this.request.user,
    }));
  }
}
