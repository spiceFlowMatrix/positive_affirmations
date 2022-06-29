import { AffirmationEntity } from '../../entity/affirmation.entity';
import { affirmationStub } from '../stubs';
import { MockModel } from './mock.model';

export class AffirmationModel extends MockModel<AffirmationEntity> {
  protected entityStub = affirmationStub();
}
