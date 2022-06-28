import { FirebaseUserInfo } from '@web-stack/domain';

export class ToggleAffirmationLikeCommand {
  readonly id: number;
  readonly byUser: FirebaseUserInfo;

  constructor(args: { id: number; byUser: FirebaseUserInfo }) {
    Object.assign(this, args);
  }
}
