import { FirebaseUserInfo } from '@web-stack/domain';

export class GetAffirmationListQuery {
  readonly skip: number;
  readonly take: number;
  readonly authUser: FirebaseUserInfo;

  constructor(args: {
    skip: number;
    take: number;
    authUser: FirebaseUserInfo;
  }) {
    Object.assign(this, args);
  }
}
