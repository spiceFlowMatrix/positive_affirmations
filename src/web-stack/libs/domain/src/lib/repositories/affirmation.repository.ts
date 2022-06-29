import {
  EntityManager,
  EntityRepository,
  QueryRunner,
  Repository,
  SelectQueryBuilder,
} from 'typeorm';
import { AffirmationEntity } from '../entity/affirmation.entity';
import { UserEntity } from '../entity/user.entity';

@EntityRepository(AffirmationEntity)
export class AffirmationRepository extends Repository<AffirmationEntity> {}
