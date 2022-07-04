import { Inject, Injectable, Scope } from '@nestjs/common';
import { CommandBus, QueryBus } from '@nestjs/cqrs';
import { REQUEST } from '@nestjs/core';
import { IAuthenticatedFirebaseRequest } from '../interfaces/authenticated-firebase-request';

@Injectable({
  scope: Scope.REQUEST,
})
export abstract class BaseApiFacade {
  constructor(
    protected readonly commandBus: CommandBus,
    protected readonly queryBus: QueryBus,
    @Inject(REQUEST)
    protected readonly request: IAuthenticatedFirebaseRequest
  ) {}
}
