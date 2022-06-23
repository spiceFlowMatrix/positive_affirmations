import { Repository } from 'typeorm';
import { AffirmationEntity } from '../entity/affirmation';

export class AffirmationRepository extends Repository<AffirmationEntity> {}
