import {IAffirmationLike} from "./affirmation-like";
import {IReaffirmation} from "./reaffirmation";
import {IUser} from "./user";

export interface IAffirmation {
  id: number;
  uiId: string;
  title: string;
  subtitle?: string;
  createdBy: IUser;
  createdOn: Date;
  active: boolean;
  likes: IAffirmationLike[];
  reaffirmations: IReaffirmation[];
}
