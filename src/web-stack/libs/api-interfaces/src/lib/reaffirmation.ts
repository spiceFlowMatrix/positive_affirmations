import {IUser} from "./user";
import {IAffirmation} from "./affirmation";
import {ILetter} from "./letter";

enum ReaffirmationValue { empty, braveOn, loveIt, goodWork }

enum ReaffirmationStamp { empty, takeOff, medal, thumbsUp }

enum ReaffirmationFont { none, birthstone, gemunuLibre, montserrat }

export interface IReaffirmation {
  id: number;
  uiId: string;
  createdOn: Date;
  createdBy: IUser;
  value: ReaffirmationValue;
  font: ReaffirmationFont;
  stamp: ReaffirmationStamp;
  forAffirmation: IAffirmation;
  inLetters: ILetter[];
}
