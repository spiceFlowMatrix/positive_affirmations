import { AffirmationLikeEntity } from '../../entity/affirmation-like.entity';
import { affirmationStub } from './affirmation.entity.stub';
import { userStub } from './user.entity.stub';

export const affirmationLikeStub = (): AffirmationLikeEntity => {
  return new AffirmationLikeEntity({
    affirmation: affirmationStub(),
    byUser: userStub(),
    createdOn: new Date(Date.now().toLocaleString()),
    id: 123,
    uiId: 'ui-123',
  });
};
