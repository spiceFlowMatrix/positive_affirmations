/**
 * This is not a production server yet!
 * This is only a minimal backend to get started.
 */

import {Logger, ValidationPipe} from '@nestjs/common';
import {NestFactory} from '@nestjs/core';
import {ConfigService} from '@nestjs/config';
import {AppModule} from './app/app.module';
import {DocumentBuilder, SwaggerModule} from "@nestjs/swagger";
import {HttpErrorInterceptor, LoggerInterceptor} from "@web-stack/services";
import * as admin from "firebase-admin";
import {ServiceAccount} from "firebase-admin";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Initialize firebase admin app
  const configService: ConfigService = app.get(ConfigService);
  const adminConfig = configService.get<string>('FIREBASE_CONFIG');
  if (!adminConfig) {
    throw new Error('FIREBASE_CONFIG not available. Please ensure the variable is supplied in the `.env` file.');
  }
  const firebase_params = JSON.parse(adminConfig);
  admin.initializeApp({
    credential: admin.credential.cert(firebase_params),
    databaseURL: 'https://positive-affirmations-313800-default-rtdb.europe-west1.firebasedatabase.app',
  });

  app.useGlobalPipes(new ValidationPipe({transform: true}));
  app.useGlobalInterceptors(new HttpErrorInterceptor(), new LoggerInterceptor());

  const globalPrefix = 'api/v1';
  app.setGlobalPrefix(globalPrefix);

  const config = new DocumentBuilder()
    .setTitle('Positive Affirmations')
    .setDescription('Positive Affirmations REST API')
    .setVersion('1.0.0')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup(globalPrefix, app, document);

  app.enableCors({
    origin: true,
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS'
  });
  const port = process.env.PORT || 3333;
  await app.listen(port, () => {
    Logger.log('Listening at http://localhost:' + port + '/' + globalPrefix);
  });
}

bootstrap();
