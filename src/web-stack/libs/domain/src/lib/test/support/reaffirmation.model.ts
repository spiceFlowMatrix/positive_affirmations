import { ReaffirmationEntity } from '../../entity/reaffirmation.entity';
import { MockModel } from './mock.model';
import { reaffirmationStub } from '../stubs/reaffirmation.entity.stub';

export class ReaffirmationModel extends MockModel<ReaffirmationEntity> {
  protected entityStub = reaffirmationStub();
}
