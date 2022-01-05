import firebase from "firebase/compat";
import User = firebase.User;

export class GetAffirmationListQuery {
  readonly skip: number;
  readonly take: number;
  readonly authUser: User;

  constructor(args: {
    skip: number,
    take: number,
    authUser: User,
  }) {
    Object.assign(this, args);
  }
}
