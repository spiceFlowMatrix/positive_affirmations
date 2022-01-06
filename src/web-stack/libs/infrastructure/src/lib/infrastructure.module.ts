import {MiddlewareConsumer, Module, NestModule, RequestMethod} from '@nestjs/common';
import {CqrsModule} from "@nestjs/cqrs";
import {ApplicationModule} from "@web-stack/application";
import {AffirmationsApiFacade} from "./service/affirmations-api.facade";
import {AffirmationsApiController} from "./controllers/affirmations-api.controller";
import {ServicesModule} from "@web-stack/services";
import {LoggerMiddleware} from "./service/logger.middleware";

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
export class InfrastructureModule implements NestModule {
  configure(consumer: MiddlewareConsumer): any {
    consumer.apply(LoggerMiddleware)
      .forRoutes({
        path: '*',
        method: RequestMethod.ALL
      });
  }
}
