import { Module } from '@nestjs/common';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AffirmationsModule } from './affirmations/affirmations.module';
import { MasterModule } from './master/master.module';
import { UsersModule } from './users/users.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SnakeNamingStrategy } from 'typeorm-naming-strategies';

@Module({
  imports: [AffirmationsModule, MasterModule, UsersModule, TypeOrmModule.forRoot({
    type: 'postgres',
    host: process.env.DB_HOST || '127.0.0.1',
    port: +process.env.DB_PORT || 5432,
    username: process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD || 'mypassword',
    database: process.env.DB_NAME || 'positiveaffirmations',
    // entities: ['src/**/*.entity{.ts,.js}'],
    autoLoadEntities: true,
    synchronize: true,
    namingStrategy: new SnakeNamingStrategy()
  })],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
