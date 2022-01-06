import {CACHE_MANAGER, Inject, Injectable, UnauthorizedException} from '@nestjs/common';
import {ExtractJwt, Strategy} from 'passport-firebase-jwt';
import {Cache} from 'cache-manager';
import {PassportStrategy} from "@nestjs/passport";
import * as admin from 'firebase-admin';
import moment = require("moment");


@Injectable()
export class FirebaseAuthStrategy extends PassportStrategy(Strategy, 'firebase-auth') {
  private defaultApp: any;

  constructor(
    @Inject(CACHE_MANAGER) private cacheManager: Cache
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken()
    });
    this.defaultApp = admin.apps[0];
  }

  async validate(token: string) {
    const cachedFirebaseUser = await this.cacheManager.get(token);
    if (cachedFirebaseUser) return cachedFirebaseUser;

    const firebaseUser: any = await admin
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
