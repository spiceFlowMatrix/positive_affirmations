export class CreateAffirmationCommand {
  readonly title: string;
  readonly subtitle?: string;

  constructor(args: {
    title: string;
    subtitle?: string;
  }) {
    Object.assign(this, args);
  }
}
