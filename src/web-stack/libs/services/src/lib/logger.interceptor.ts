import { CallHandler, ExecutionContext, Injectable, Logger, NestInterceptor } from '@nestjs/common';
import { catchError, Observable, tap, throwError } from 'rxjs';
// Reference for getting request duration in logs: https://ipirozhenko.com/blog/measuring-requests-duration-nodejs-express/

const getDurationInMilliseconds = (start) => {
  const NS_PER_SEC = 1e9;
  const NS_TO_MS = 1e6;
  const diff = process.hrtime(start);

  return (diff[0] * NS_PER_SEC + diff[1]) / NS_TO_MS;
};

// Reference for solution to logging full request and response payload: https://stackoverflow.com/q/55093055/5472560
@Injectable()
export class LoggerInterceptor implements NestInterceptor {
  private readonly logger = new Logger(LoggerInterceptor.name);

  intercept(
    context: ExecutionContext,
    next: CallHandler<any>
  ): Observable<any> | Promise<Observable<any>> {
    const start = process.hrtime();
    const {
      originalUrl,
      method,
      params,
      query,
      body,
      user
    } = context.switchToHttp().getRequest();

    const requestPayload = {
      originalUrl: originalUrl,
      method: method,
      params: params,
      query: query,
      body: body,
      user: user
    };

    return next.handle().pipe(
      tap(data => {
        const durationInMilliseconds = getDurationInMilliseconds(start);
        const { statusCode } = context.switchToHttp().getResponse();
        const responsePayload = {
          statusCode: statusCode,
          data: data
        };
        const logPayload = {
          request: requestPayload,
          response: responsePayload,
          delay: `${durationInMilliseconds.toLocaleString()} ms`
        };
        this.logger.log(`${JSON.stringify(logPayload)}`);
      }),
      catchError(error => {
        const durationInMilliseconds = getDurationInMilliseconds(start);
        const responsePayload = {
          request: requestPayload,
          error: error,
          delay: `${durationInMilliseconds.toLocaleString()} ms`
        };
        this.logger.error(`${JSON.stringify(responsePayload)}`);
        return throwError(error);
      })
    );
  }
}
