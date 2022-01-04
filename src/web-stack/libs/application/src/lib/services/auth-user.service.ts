import {Injectable} from '@nestjs/common';
import {InjectRepository} from '@nestjs/typeorm';
import {Repository} from 'typeorm';
import {PersistenceErrorException, UserEntity} from "@web-stack/domain";
import firebase from "firebase/compat";
import User = firebase.User;

// export interface IAuthenticatedFirebaseRequest extends Request {
//   user: User;
// }

/* Reference for reading the request using request-scoped provider
   https://stackoverflow.com/a/54981245/5472560
 */

/* NOTE: Since CQRS handlers are statically scoped, handlers will not register if
   we try to add request-scoped service dependencies to them.
   See here for reference: https://github.com/nestjs/cqrs/issues/60#issuecomment-483288297
   TODO: Investigate thread for solution to access scoped services in CQRS handlers.
* */
@Injectable({
  // scope: Scope.REQUEST
})
export class AuthUserService {
  constructor(
    // @Inject(REQUEST)
    // private readonly request: IAuthenticatedFirebaseRequest,
    @InjectRepository(UserEntity)
    private userRepository: Repository<UserEntity>) {
  }

  async user(authUser: User) {
    let userEntity = await this.userRepository
      .findOne({
        where: {uid: authUser.uid}
      });


    if (!userEntity) {
      const newUserEntity = new UserEntity({
        displayName: authUser.displayName,
        email: authUser.email,
        uid: authUser.uid
      });

      userEntity = await this.userRepository
        .save(newUserEntity)
        .catch(err => {
          throw new PersistenceErrorException(
            UserEntity.name,
            JSON.stringify(err),
            `${AuthUserService.name}.user(authUser)`,
            JSON.stringify(authUser),
          );
        });
    }
    return userEntity;
  }

}
