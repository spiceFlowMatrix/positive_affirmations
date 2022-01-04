import {IAffirmationLike} from "@web-stack/api-interfaces";
import {UserDto} from "./user.dto";

export class AffirmationLikeDto implements IAffirmationLike {
  id: number;
  uiId: string;
  byUser: UserDto;
  createdOn: Date;

  constructor(args: {
    id: number;
    uiId: string;
    byUser: UserDto;
    createdOn: Date;
  }) {
    Object.assign(this, args);
  }
}
