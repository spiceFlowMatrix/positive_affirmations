import {IUser} from "./user";
import {IAffirmation} from "./affirmation";
import {ILetter} from "./letter";

export enum ReaffirmationValue { empty, braveOn, loveIt, goodWork }

export enum ReaffirmationStamp { empty, takeOff, medal, thumbsUp }

export enum ReaffirmationFont { none, birthstone, gemunuLibre, montserrat }

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
