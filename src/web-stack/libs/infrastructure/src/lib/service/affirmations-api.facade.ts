import {BaseApiFacade} from "./base-api.facade";
import {AffirmationDto, CreateAffirmationCommandDto} from "@web-stack/domain";
import {CreateAffirmationCommand} from "@web-stack/application";

export class AffirmationsApiFacade extends BaseApiFacade {
  async createAffirmation(dto: CreateAffirmationCommandDto): Promise<AffirmationDto> {
    return await this.commandBus.execute(new CreateAffirmationCommand({
      ...dto,
      authUser: this.request.user,
    }));
  }
}
