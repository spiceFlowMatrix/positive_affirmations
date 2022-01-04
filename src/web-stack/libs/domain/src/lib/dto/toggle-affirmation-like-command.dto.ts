import {IsDefined, IsInt} from "class-validator";

export class ToggleAffirmationLikeCommandDto {
  @IsInt()
  @IsDefined()
  readonly id: number;

  constructor(args: {
    id: number;
  }) {
    Object.assign(this, args);
  }
}
