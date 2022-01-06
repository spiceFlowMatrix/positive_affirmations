import {Injectable} from "@nestjs/common";
import * as admin from "firebase-admin";
import {auth} from "firebase-admin";
import UserRecord = auth.UserRecord;

@Injectable()
export class FirebaseAdminService {

  async signUpWithEmailPassword(email: string, password: string, displayName: string): Promise<UserRecord> {
    return await admin.auth().createUser({
      email,
      password,
      displayName,
    });
  }
}
