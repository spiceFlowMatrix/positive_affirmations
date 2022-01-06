import {Module} from '@nestjs/common';

import {AppController} from './app.controller';
import {AuthService} from "./auth.service";
import {environment} from "../environments/environment";

@Module({
  imports: [],
  controllers: [AppController],
  providers: [
    {
      provide: AuthService,
      useValue: new AuthService(environment.firebaseConfig, 'http://127.0.0.1:9099')
    }
  ],
})
export class AppModule {
}
