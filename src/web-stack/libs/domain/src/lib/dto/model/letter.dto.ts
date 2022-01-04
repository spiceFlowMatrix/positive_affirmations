import {ILetter} from "@web-stack/api-interfaces";
import {UserDto} from "./user.dto";
import {ReaffirmationDto} from "./reaffirmation.dto";

export class LetterDto implements ILetter {
  id: number;
  uiId: string;
  createdBy: UserDto;
  createdOn: Date;
  opened: boolean;
  openedOn: Date;
  reaffirmations: ReaffirmationDto[];

  constructor(args: {
    id: number;
    uiId: string;
    createdBy: UserDto;
    createdOn: Date;
    opened: boolean;
    openedOn: Date;
    reaffirmations: ReaffirmationDto[];
  }) {
    Object.assign(this, args);
  }
}
