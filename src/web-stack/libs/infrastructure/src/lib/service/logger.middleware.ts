import {Injectable, Logger, NestMiddleware} from '@nestjs/common';

// Reference for getting request duration in logs: https://ipirozhenko.com/blog/measuring-requests-duration-nodejs-express/

const getDurationInMilliseconds = (start) => {
  const NS_PER_SEC = 1e9;
  const NS_TO_MS = 1e6;
  const diff = process.hrtime(start);

  return (diff[0] * NS_PER_SEC + diff[1]) / NS_TO_MS;
};

@Injectable()
export class LoggerMiddleware implements NestMiddleware {

  use(req: any, res: any, next: () => void): any {
    const logger = new Logger(`${LoggerMiddleware.name} ${req.originalUrl}`);
    logger.log(`[STARTED]`);
    const start = process.hrtime();

    res.on('finish', () => {
      const durationInMilliseconds = getDurationInMilliseconds(start);
      logger.log(`[FINISHED] ${durationInMilliseconds.toLocaleString()} ms`);
    });

    res.on('close', () => {
      const durationInMilliseconds = getDurationInMilliseconds(start);
      if (durationInMilliseconds > 500) {
        logger.warn(`[CLOSED] Long running request: ${durationInMilliseconds.toLocaleString()} ms`);
        return;
      }
      logger.log(`[CLOSED] ${durationInMilliseconds.toLocaleString()} ms`);
    });

    next();
  }
}
