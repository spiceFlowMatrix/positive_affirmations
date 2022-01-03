import {Module} from '@nestjs/common';
import {TypeOrmModule} from "@nestjs/typeorm";
import {ENTITIES} from "./entity";

@Module({
  controllers: [],
  imports: [TypeOrmModule.forFeature(ENTITIES)],
  providers: [],
  exports: [TypeOrmModule.forFeature(ENTITIES)],
})
export class DomainModule {
}
