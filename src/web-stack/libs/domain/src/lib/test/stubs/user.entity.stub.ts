import { LetterCreationSchedule } from '@web-stack/api-interfaces';
import { UserEntity } from '../../entity/user.entity';

export const userStub = (): UserEntity => {
  return new UserEntity({
    dbId: 123,
    dbUiId: '123',
    displayName: 'test name',
    phoneNumber: '5454545454',
    photoURL: 'http://photo.url.com',
    providerId: 'oauth2',
    uid: 'oauth2/123',
    email: 'test@email.com',
    emailVerified: false,
    letterSchedule: LetterCreationSchedule.never,
    reaffirmations: [],
    letters: [],
    affirmations: [],
    affirmationLikes: [],
  });
};
