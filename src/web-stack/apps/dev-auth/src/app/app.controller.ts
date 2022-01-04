import {Controller, Get, Query} from '@nestjs/common';
import {AuthService} from "./auth.service";
import {EmailPasswordDto} from "./models/email-password.dto";

@Controller('auth')
export class AppController {
  constructor(private readonly authService: AuthService) {
  }

  @Get('emailPasswordSignIn')
  getData(@Query() dto: EmailPasswordDto) {
    return this.authService.signInWithEmailPassword(dto.email, dto.password);
  }
}
