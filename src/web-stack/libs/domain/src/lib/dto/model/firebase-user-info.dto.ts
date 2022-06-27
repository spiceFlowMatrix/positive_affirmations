import { IFirebaseUserInfo } from '@web-stack/api-interfaces';

export class FirebaseUserInfo implements IFirebaseUserInfo {
  uid: string;
  displayName: string | null;
  email: string | null;
  emailVerified: boolean;
  phoneNumber: string | null;
  photoURL: string | null;
  providerId?: string | null;

  constructor(args: {
    uid: string;
    displayName: string | null;
    email: string | null;
    emailVerified: boolean;
    phoneNumber: string | null;
    photoURL: string | null;
    providerId?: string | null;
  }) {
    Object.assign(this, args);
  }
}
