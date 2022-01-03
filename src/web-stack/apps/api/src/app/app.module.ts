import {Module} from '@nestjs/common';
import {InfrastructureModule} from "@web-stack/infrastructure";
import {TypeOrmModule} from "@nestjs/typeorm";
import {SnakeNamingStrategy} from "typeorm-naming-strategies";


@Module({
  imports: [
    InfrastructureModule,
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST || '127.0.0.1',
      port: +process.env.DB_PORT || 5432,
      username: process.env.DB_USER || 'postgres',
      password: process.env.DB_PASSWORD || 'mypassword',
      database: process.env.DB_NAME || 'postgres',
      // entities: ['src/**/*.entity{.ts,.js}'],
      autoLoadEntities: true,
      synchronize: true,
      useUTC: true,
      namingStrategy: new SnakeNamingStrategy()
    })
  ],
  controllers: [],
  providers: [],
})
export class AppModule {
}
