import {Controller, Get, Query} from '@nestjs/common';
import {AuthService} from "./auth.service";
import {EmailPasswordDto} from "./models/email-password.dto";
import {UserCredentialDto} from "./models/user-credential.dto";

@Controller('auth')
export class AppController {
  constructor(private readonly authService: AuthService) {
  }

  @Get('emailPasswordSignIn')
  async getData(@Query() dto: EmailPasswordDto): Promise<UserCredentialDto> {
    const credential = await this.authService.signInWithEmailPassword(dto.email, dto.password);
    return new UserCredentialDto({
      credential
    });
  }
}
