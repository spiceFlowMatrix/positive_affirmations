export class SignUpCommand {
  readonly email: string;
  readonly password: string;
  readonly nickName?: string;

  constructor(args: {
    email: string;
    password: string;
    nickName?: string;
  }) {
    Object.assign(this, args);
  }
}
