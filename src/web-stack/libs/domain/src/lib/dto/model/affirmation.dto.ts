import {IAffirmation} from "@web-stack/api-interfaces";
import {UserDto} from "./user.dto";
import {AffirmationLikeDto} from "./affirmation-like.dto";
import {ReaffirmationDto} from "./reaffirmation.dto";

export class AffirmationDto implements IAffirmation {
  id: number;
  uiId: string;
  title: string;
  subtitle?: string;
  active: boolean;
  createdBy: UserDto;
  createdOn: Date;
  likes: AffirmationLikeDto[];
  reaffirmations: ReaffirmationDto[];

  constructor(args: {
    id: number;
    uiId: string;
    title: string;
    subtitle?: string;
    active: boolean;
    createdBy: UserDto;
    createdOn: Date;
    likes: AffirmationLikeDto[];
    reaffirmations: ReaffirmationDto[];
  }) {
    Object.assign(this, args);
  }
}
