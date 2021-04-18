import { Module } from '@nestjs/common';
import { AffirmationsController } from './affirmations.controller';

@Module({
  controllers: [AffirmationsController]
})
export class AffirmationsModule {}
