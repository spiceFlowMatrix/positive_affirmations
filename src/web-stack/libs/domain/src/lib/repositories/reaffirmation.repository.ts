import { Repository } from 'typeorm';
import { ReaffirmationEntity } from '../entity/reaffirmation';

export class ReaffirmationRepository extends Repository<ReaffirmationEntity> {}
