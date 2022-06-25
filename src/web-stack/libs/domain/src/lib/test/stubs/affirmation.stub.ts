import { AffirmationEntity } from '../../entity/affirmation.entity';
import { userStub } from './user.stub';

export const affirmationStub = (): AffirmationEntity => {
  return {
    id: 123,
    uiId: '123',
    title: 'test affirmation',
    active: true,
    createdBy: userStub(),
    createdOn: new Date(Date.now().toLocaleString()),
    likes: [],
    reaffirmations: [],
  };
};
