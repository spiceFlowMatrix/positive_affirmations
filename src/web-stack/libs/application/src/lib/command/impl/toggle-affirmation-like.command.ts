import firebase from "firebase/compat";
import User = firebase.User;

export class ToggleAffirmationLikeCommand {
  readonly id: number;
  readonly byUser: User;

  constructor(args: {
    id: number;
    byUser: User;
  }) {
    Object.assign(this, args);
  }
}
