import { FirebaseUserInfo } from '@web-stack/domain';

export class CreateAffirmationCommand {
  readonly title: string;
  readonly subtitle?: string;
  readonly authUser: FirebaseUserInfo;

  constructor(args: {
    title: string;
    subtitle?: string;
    authUser: FirebaseUserInfo;
  }) {
    Object.assign(this, args);
  }
}
