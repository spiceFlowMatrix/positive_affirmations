import {IUser} from "./user";

export interface IAffirmationLike {
  id: number;
  uiId: string;
  byUser: IUser;
  createdOn: Date;
}
