import {IsInt} from "class-validator";
import {Transform} from "class-transformer";

export class GetAffirmationListQueryDto {
  @IsInt()
  @Transform(fn => parseInt(fn.value, 10), {toClassOnly: true})
  readonly skip: number = 0;
  @IsInt()
  @Transform(fn => parseInt(fn.value, 10), {toClassOnly: true})
  readonly take: number = 10;

  constructor(args: {
    skip?: number,
    take?: number
  }) {
    Object.assign(this, args);
  }
}
