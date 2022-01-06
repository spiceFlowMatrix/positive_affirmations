import {CACHE_MANAGER, Inject, Injectable, UnauthorizedException} from '@nestjs/common';
import {ExtractJwt, Strategy} from 'passport-firebase-jwt';
import {ConfigService} from "@nestjs/config";
import {Cache} from 'cache-manager';
import * as firebase from 'firebase-admin';
import {PassportStrategy} from "@nestjs/passport";
import moment = require("moment");


@Injectable()
export class FirebaseAuthStrategy extends PassportStrategy(Strategy, 'firebase-auth') {
  private defaultApp: any;

  constructor(
    private configService: ConfigService,
    @Inject(CACHE_MANAGER) private cacheManager: Cache
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken()
    });
    const config = this.configService.get<string>('FIREBASE_CONFIG');
    if (!config) {
      throw new Error('FIREBASE_CONFIG not available. Please ensure the variable is supplied in the `.env` file.');
    }
    const firebase_params = JSON.parse(config);

    this.defaultApp = firebase.initializeApp({
      credential: firebase.credential.cert(firebase_params),
      databaseURL: 'https://positive-affirmations-313800-default-rtdb.europe-west1.firebasedatabase.app',
    });
  }

  async validate(token: string) {
    const cachedFirebaseUser = await this.cacheManager.get(token);
    if (cachedFirebaseUser) return cachedFirebaseUser;

    const firebaseUser: any = await this.defaultApp
      .auth()
      .verifyIdToken(token, true)
      .catch((err) => {
        console.log(err);
        throw new UnauthorizedException(err.Message);
      });

    if (!firebaseUser) {
      throw new UnauthorizedException();
    }

    /**
     * input parameter for `Date` or `moment` constructor is in milliseconds for unix timestamps.
     * input * 1000 will instantiate correct Date or moment value.
     * See here for reference: https://stackoverflow.com/a/45370395/5472560
     */
    const exp = moment(+firebaseUser['exp'] * 1000);
    const now = moment.now();
    const ttl = exp.diff(now, 'seconds');

    await this.cacheManager.set(token, firebaseUser, {ttl});

    return firebaseUser;
  }
}
