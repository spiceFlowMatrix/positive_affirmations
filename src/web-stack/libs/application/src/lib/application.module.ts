import {Module} from '@nestjs/common';
import {CqrsModule} from "@nestjs/cqrs";
import {DomainModule} from "@web-stack/domain";
import {QueryHandlers} from "./query";
import {CommandHandlers} from "./command";
import {EventHandlers} from "./event";
import {Sagas} from "./saga";
import {AuthUserService} from "./services/auth-user.service";

@Module({
  imports: [CqrsModule, DomainModule],
  controllers: [],
  providers: [
    AuthUserService,
    ...QueryHandlers,
    ...CommandHandlers,
    ...EventHandlers,
    ...Sagas,
  ],
  exports: [],
})
export class ApplicationModule {
}
