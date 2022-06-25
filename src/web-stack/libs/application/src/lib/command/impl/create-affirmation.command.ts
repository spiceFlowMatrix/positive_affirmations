import { IFirebaseUserInfo } from '@web-stack/api-interfaces';

export class CreateAffirmationCommand {
  readonly title: string;
  readonly subtitle?: string;
  readonly authUser: IFirebaseUserInfo;

  constructor(args: {
    title: string;
    subtitle?: string;
    authUser: IFirebaseUserInfo;
  }) {
    Object.assign(this, args);
  }
}
