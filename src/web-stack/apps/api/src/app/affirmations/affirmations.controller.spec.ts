import { Test, TestingModule } from '@nestjs/testing';
import { AffirmationsController } from './affirmations.controller';

describe('AffirmationsController', () => {
  let controller: AffirmationsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AffirmationsController],
    }).compile();

    controller = module.get<AffirmationsController>(AffirmationsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
