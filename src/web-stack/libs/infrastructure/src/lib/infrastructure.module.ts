import {Module} from '@nestjs/common';
import {CqrsModule} from "@nestjs/cqrs";
import {ApplicationModule} from "@web-stack/application";

@Module({
  imports: [CqrsModule, ApplicationModule],
  controllers: [],
  providers: [],
  exports: [],
})
export class InfrastructureModule {
}
