import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { entities } from './entities';
import { UsersController } from './users.controller';
import { CommandHandlers } from './commands/handlers';
import { CqrsModule } from '@nestjs/cqrs';

@Module({
  imports: [
    CqrsModule,
    TypeOrmModule.forFeature([...entities])
  ],
  controllers: [UsersController],
  providers: [
    ...CommandHandlers
  ]
})
export class UsersModule {
}


