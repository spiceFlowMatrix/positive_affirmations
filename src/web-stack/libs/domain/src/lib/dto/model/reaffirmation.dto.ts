import {IReaffirmation, ReaffirmationFont, ReaffirmationStamp, ReaffirmationValue} from "@web-stack/api-interfaces";
import {UserDto} from "./user.dto";
import {AffirmationDto} from "./affirmation.dto";
import {LetterDto} from "./letter.dto";

export class ReaffirmationDto implements IReaffirmation {
  id: number;
  uiId: string;
  font: ReaffirmationFont;
  stamp: ReaffirmationStamp;
  value: ReaffirmationValue;
  createdBy: UserDto;
  createdOn: Date;
  forAffirmation: AffirmationDto;
  inLetters: LetterDto[];

  constructor(args: {
    id: number;
    uiId: string;
    font: ReaffirmationFont;
    stamp: ReaffirmationStamp;
    value: ReaffirmationValue;
    createdBy: UserDto;
    createdOn: Date;
    forAffirmation: AffirmationDto;
    inLetters: LetterDto[];
  }) {
    Object.assign(this, args);
  }
}
