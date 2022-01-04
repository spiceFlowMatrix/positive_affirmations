import {
  CallHandler,
  ExecutionContext,
  Injectable,
  InternalServerErrorException,
  NestInterceptor,
  NotFoundException
} from '@nestjs/common';
import {catchError, Observable} from 'rxjs';
import {ObjectNotFoundException, PersistenceErrorException} from "@web-stack/domain";

@Injectable()
export class HttpErrorInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler<any>): Observable<any> | Promise<Observable<any>> {
    return next.handle()
      .pipe(
        catchError(error => {
          if (error instanceof ObjectNotFoundException) {
            throw new NotFoundException(error.message);
          } else if (error instanceof PersistenceErrorException) {
            throw new InternalServerErrorException(error.message);
          } else {
            throw error;
          }
        })
      );
  }
}
