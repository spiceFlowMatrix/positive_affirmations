import {Module} from '@nestjs/common';
import {CqrsModule} from "@nestjs/cqrs";
import {ApplicationModule} from "@web-stack/application";
import {AffirmationsApiFacade} from "./service/affirmations-api.facade";
import {AffirmationsApiController} from "./controllers/affirmations-api.controller";
import {ServicesModule} from "@web-stack/services";

@Module({
  imports: [
    CqrsModule,
    ApplicationModule,
    ServicesModule,
  ],
  controllers: [AffirmationsApiController],
  providers: [AffirmationsApiFacade],
  exports: [AffirmationsApiFacade],
})
export class InfrastructureModule {
}
