import {ILetter} from "./letter";
import {IReaffirmation} from "./reaffirmation";
import {IAffirmation} from "./affirmation";
import {IAffirmationLike} from "./affirmation-like";
import firebase from "firebase/compat";
import UserInfo = firebase.UserInfo;

export enum LetterCreationSchedule { daily, weekly, monthly, never }

export interface IUser {
  uid: string;
  displayName: string | null;
  email: string | null;
  phoneNumber: string | null;
  photoURL: string | null;
  providerId: string;
  dbId: number;
  dbUiId: string;
  emailVerified: boolean;
  nickName?: string;
  letterSchedule: LetterCreationSchedule;
  lettersLastGeneratedOn?: Date;
  letters: ILetter[];
  reaffirmations: IReaffirmation[];
  affirmations: IAffirmation[];
  affirmationLikes: IAffirmationLike[];
}
