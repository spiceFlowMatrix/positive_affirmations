import {IUser, LetterCreationSchedule} from "@web-stack/api-interfaces";
import {AffirmationLikeDto} from "./affirmation-like.dto";
import {AffirmationDto} from "./affirmation.dto";
import {LetterDto} from "./letter.dto";
import {ReaffirmationDto} from "./reaffirmation.dto";

export class UserDto implements IUser {
  dbId: number;
  dbUiId: string;
  uid: string;
  displayName: string | null;
  email: string | null;
  phoneNumber: string | null;
  photoURL: string | null;
  providerId: string;
  affirmationLikes: AffirmationLikeDto[];
  affirmations: AffirmationDto[];
  letterSchedule: LetterCreationSchedule;
  letters: LetterDto[];
  lettersLastGeneratedOn: Date;
  reaffirmations: ReaffirmationDto[];

  constructor(args: {
    dbId: number;
    dbUiId: string;
    uid: string;
    displayName: string | null;
    email: string | null;
    phoneNumber: string | null;
    photoURL: string | null;
    providerId: string;
    affirmationLikes: AffirmationLikeDto[];
    affirmations: AffirmationDto[];
    letterSchedule: LetterCreationSchedule;
    letters: LetterDto[];
    lettersLastGeneratedOn: Date;
    reaffirmations: ReaffirmationDto[];
  }) {
    Object.assign(this, args);
  }
}
