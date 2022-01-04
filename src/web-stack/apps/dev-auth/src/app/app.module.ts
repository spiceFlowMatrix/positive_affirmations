import {Module} from '@nestjs/common';

import {AppController} from './app.controller';
import {AppService} from './app.service';
import {AuthService} from "./auth.service";
import {environment} from "../environments/environment";

@Module({
  imports: [],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: AuthService,
      useValue: new AuthService(environment.firebaseConfig)
    }
  ],
})
export class AppModule {
}
