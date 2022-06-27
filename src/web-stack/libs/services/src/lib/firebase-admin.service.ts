import { Injectable } from '@nestjs/common';
import { FirebaseUserInfo } from '@web-stack/domain';
import * as admin from 'firebase-admin';

@Injectable()
export class FirebaseAdminService {
  async signUpWithEmailPassword(
    email: string,
    password: string,
    displayName: string
  ): Promise<FirebaseUserInfo> {
    return await admin
      .auth()
      .createUser({
        email,
        password,
        displayName,
      })
      .then((user) => {
        return new FirebaseUserInfo({
          displayName: user.displayName,
          email: user.email,
          emailVerified: user.emailVerified,
          phoneNumber: user.phoneNumber,
          photoURL: user.photoURL,
          uid: user.uid,
        });
      });
  }
}
