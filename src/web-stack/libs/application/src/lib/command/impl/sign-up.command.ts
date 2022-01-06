export class SignUpCommand {
  readonly email: string;
  readonly password: string;
  readonly displayName: string;
  readonly nickName?: string;

  constructor(args: {
    email: string;
    password: string;
    displayName: string;
    nickName?: string;
  }) {
    Object.assign(this, args);
  }
}
