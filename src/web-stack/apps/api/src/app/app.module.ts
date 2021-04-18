import { Module } from '@nestjs/common';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AffirmationsModule } from './affirmations/affirmations.module';

@Module({
  imports: [AffirmationsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
