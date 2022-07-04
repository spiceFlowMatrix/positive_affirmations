import { BaseApiFacade } from './base-api.facade';
import {
  AffirmationDto,
  AffirmationObjectResponseDto,
  CreateAffirmationCommandDto,
  GetAffirmationListQueryDto,
  GetAffirmationListQueryResponseDto,
  MissingRequiredParamException,
} from '@web-stack/domain';
import {
  CreateAffirmationCommand,
  GetAffirmationListQuery,
  ToggleAffirmationLikeCommand,
} from '@web-stack/application';

export class AffirmationsApiFacade extends BaseApiFacade {
  async getAffirmationList(
    dto: GetAffirmationListQueryDto
  ): Promise<GetAffirmationListQueryResponseDto> {
    if (!dto) {
      throw new MissingRequiredParamException(
        `${AffirmationsApiFacade.name}.getAffirmationList`,
        'dto',
        `${GetAffirmationListQueryDto.name}`
      );
    }
    return await this.queryBus.execute(
      new GetAffirmationListQuery({
        skip: dto.skip,
        take: dto.take,
        authUser: this.request.user,
      })
    );
  }

  async createAffirmation(
    dto: CreateAffirmationCommandDto
  ): Promise<AffirmationDto> {
    if (!dto) {
      throw new MissingRequiredParamException(
        `${AffirmationsApiFacade.name}.createAffirmation`,
        'dto',
        `${CreateAffirmationCommandDto.name}`
      );
    }
    return await this.commandBus.execute(
      new CreateAffirmationCommand({
        ...dto,
        authUser: this.request.user,
      })
    );
  }

  async toggleAffirmationLiked(
    id: number
  ): Promise<AffirmationObjectResponseDto> {
    if (id === undefined || id === null) {
      throw new MissingRequiredParamException(
        `${AffirmationsApiFacade.name}.toggleAffirmationLike`,
        'id',
        'number'
      );
    }
    return await this.commandBus.execute(
      new ToggleAffirmationLikeCommand({
        id,
        byUser: this.request.user,
      })
    );
  }
}
