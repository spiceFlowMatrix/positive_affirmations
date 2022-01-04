import {UserCredential} from "firebase/auth";

export class UserCredentialDto {
  credential: UserCredential;

  constructor(args: {credential: UserCredential}) {
    Object.assign(this, args);
  }
}
