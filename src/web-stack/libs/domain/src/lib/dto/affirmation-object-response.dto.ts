import {AffirmationDto} from "@web-stack/domain";

export class AffirmationObjectResponseDto {
  readonly affirmationData: AffirmationDto;
  readonly liked: boolean;

  constructor(args: {
    affirmationData: AffirmationDto;
    liked: boolean;
  }) {
    Object.assign(this, args);
  }
}
