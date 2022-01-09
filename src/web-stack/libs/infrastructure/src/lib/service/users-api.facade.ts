import {BaseApiFacade} from "./base-api.facade";
import {SignUpCommandDto, UserDto} from "@web-stack/domain";
import {SignUpCommand} from "@web-stack/application";

export class UsersApiFacade extends BaseApiFacade {
  async signUpUser(dto: SignUpCommandDto): Promise<UserDto> {
    return await this.commandBus.execute(new SignUpCommand({
      ...dto
    }));
  }
}
