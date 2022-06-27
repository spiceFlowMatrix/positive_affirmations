import { FirebaseUserInfo } from '@web-stack/domain';

export const firebaseUserInfoStub = (): FirebaseUserInfo => {
  return {
    displayName: 'test name',
    phoneNumber: '5454545454',
    photoURL: 'http://photo.url.com',
    providerId: 'oauth2',
    uid: 'oauth2/123',
    email: 'test@email.com',
    emailVerified: false,
  };
};
