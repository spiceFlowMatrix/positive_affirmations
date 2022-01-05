import {AffirmationObjectResponseDto} from "@web-stack/domain";

export class GetAffirmationListQueryResponseDto {
  readonly totalResults: number;
  readonly results: AffirmationObjectResponseDto[];

  constructor(args: {
    totalResults: number;
    results: AffirmationObjectResponseDto[];
  }) {
    Object.assign(this, args);
  }
}
