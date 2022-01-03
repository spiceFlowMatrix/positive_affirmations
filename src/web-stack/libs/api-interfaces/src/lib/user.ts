import {ILetter} from "./letter";
import {IReaffirmation} from "./reaffirmation";
import {IAffirmation} from "./affirmation";

enum LetterCreationSchedule { daily, weekly, monthly, never }

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
  affirmation: IAffirmation[];
}
