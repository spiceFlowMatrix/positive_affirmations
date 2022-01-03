import {IUser} from "./user";
import {IReaffirmation} from "./reaffirmation";

export interface ILetter {
  id: number;
  uiId: string;
  reaffirmations: IReaffirmation[];
  createdBy: IUser;
  createdOn: Date;
  opened: boolean;
  openedOn: Date;
}
