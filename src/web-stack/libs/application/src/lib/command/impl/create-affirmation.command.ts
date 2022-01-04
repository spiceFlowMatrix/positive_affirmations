import firebase from "firebase/compat";
import User = firebase.User;

export class CreateAffirmationCommand {
  readonly title: string;
  readonly subtitle?: string;
  readonly authUser: User

  constructor(args: {
    title: string;
    subtitle?: string;
    authUser: User;
  }) {
    Object.assign(this, args);
  }
}
