import {CacheModule, Module} from '@nestjs/common';
import {FirebaseAuthStrategy} from "./firebase-auth.strategy";
import {FirebaseAdminService} from "./firebase-admin.service";

@Module({
  imports: [
    CacheModule.register()
  ],
  controllers: [],
  providers: [
    FirebaseAuthStrategy,
    FirebaseAdminService
  ],
  exports: [
    FirebaseAuthStrategy,
    FirebaseAdminService,
  ],
})
export class ServicesModule {
}
