import {ILetter} from "./letter";
import {IReaffirmation} from "./reaffirmation";
import {IAffirmation} from "./affirmation";
import {IAffirmationLike} from "./affirmation-like";
import firebase from "firebase/compat";
import UserInfo = firebase.UserInfo;

export enum LetterCreationSchedule { daily, weekly, monthly, never }

export interface IUser extends UserInfo {
  dbId: number;
  dbUiId: string;
  letterSchedule: LetterCreationSchedule;
  lettersLastGeneratedOn: Date;
  letters: ILetter[];
  reaffirmations: IReaffirmation[];
  affirmations: IAffirmation[];
  affirmationLikes: IAffirmationLike[];
}
