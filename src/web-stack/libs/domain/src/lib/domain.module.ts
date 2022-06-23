import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ENTITIES } from './entity';
import { REPOSITORIES } from './repositories';

@Module({
  controllers: [],
  imports: [TypeOrmModule.forFeature(ENTITIES)],
  providers: [...REPOSITORIES],
  exports: [...REPOSITORIES, TypeOrmModule.forFeature(ENTITIES)],
})
export class DomainModule {}
