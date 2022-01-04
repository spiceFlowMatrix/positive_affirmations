import {IsDefined, IsOptional, IsString, Length} from "class-validator";

export class CreateAffirmationCommandDto {
  @IsDefined()
  @IsString()
  @Length(3, 80)
  readonly title: string;

  @IsOptional()
  @IsString()
  readonly subtitle?: string;

  constructor(args: {
    title: string;
    subtitle?: string;
  }) {
    Object.assign(this, args);
  }
}
