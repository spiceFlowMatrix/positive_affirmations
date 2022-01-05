import {BaseApiFacade} from "./base-api.facade";
import {
  AffirmationDto,
  AffirmationObjectResponseDto,
  CreateAffirmationCommandDto,
  GetAffirmationListQueryDto,
  GetAffirmationListQueryResponseDto,
} from "@web-stack/domain";
import {CreateAffirmationCommand, GetAffirmationListQuery, ToggleAffirmationLikeCommand} from "@web-stack/application";

export class AffirmationsApiFacade extends BaseApiFacade {
  async getAffirmationList(dto: GetAffirmationListQueryDto): Promise<GetAffirmationListQueryResponseDto> {
    return await this.queryBus.execute(new GetAffirmationListQuery({
      skip: dto.skip,
      take: dto.take,
      authUser: this.request.user,
    }));
  }

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
