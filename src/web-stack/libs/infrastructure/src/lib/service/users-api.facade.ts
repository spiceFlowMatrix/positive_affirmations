import { BaseApiFacade } from './base-api.facade';
import {
  MissingRequiredParamException,
  SignUpCommandDto,
  UserDto,
} from '@web-stack/domain';
import { SignUpCommand } from '@web-stack/application';

export class UsersApiFacade extends BaseApiFacade {
  async signUpUser(dto: SignUpCommandDto): Promise<UserDto> {
    if (!dto) {
      throw new MissingRequiredParamException(
        `${UsersApiFacade.name}.getAffirmationList`,
        'dto',
        `${SignUpCommandDto.name}`
      );
    }
    return await this.commandBus.execute(
      new SignUpCommand({
        ...dto,
      })
    );
  }
}
