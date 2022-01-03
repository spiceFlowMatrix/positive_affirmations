import {ILetter} from "./letter";
import {IReaffirmation} from "./reaffirmation";
import {IAffirmation} from "./affirmation";
import {IAffirmationLike} from "./affirmation-like";

export enum LetterCreationSchedule { daily, weekly, monthly, never }

export interface IUser {
  id: number;
  uiId: string;
  name: string;
  nickName: string;
  email: string;
  emailVerified: boolean;
  letterSchedule: LetterCreationSchedule;
  lettersLastGeneratedOn: Date;
  letters: ILetter[];
  reaffirmations: IReaffirmation[];
  affirmations: IAffirmation[];
  affirmationLikes: IAffirmationLike[];
}
