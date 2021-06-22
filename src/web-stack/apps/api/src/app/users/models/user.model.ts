import { AggregateRoot } from '@nestjs/cqrs';

export class CreateUserCommandResponseData extends AggregateRoot {
  constructor(
    public readonly id: number,
    public readonly name: string,
    public readonly description: string
  ) {
    super();
  }
}
