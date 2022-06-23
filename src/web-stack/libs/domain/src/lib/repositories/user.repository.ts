import { Repository } from 'typeorm';
import { UserEntity } from '../entity/user';

export class UserRepository extends Repository<UserEntity> {}
