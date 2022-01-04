import {CacheModule, Module} from '@nestjs/common';
import {FirebaseAuthStrategy} from "./firebase-auth.strategy";

@Module({
  imports: [
    CacheModule.register()
  ],
  controllers: [],
  providers: [FirebaseAuthStrategy],
  exports: [FirebaseAuthStrategy],
})
export class ServicesModule {
}
