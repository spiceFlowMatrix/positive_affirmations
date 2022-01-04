import firebase from "firebase/compat";
import User = firebase.User;


export interface IAuthenticatedFirebaseRequest extends Request {
  user: User;
}
