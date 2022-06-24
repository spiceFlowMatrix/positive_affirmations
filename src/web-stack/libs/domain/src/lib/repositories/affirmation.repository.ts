import { Repository } from 'typeorm';
import { AffirmationEntity } from '../entity/affirmation.entity';

export class AffirmationRepository extends Repository<AffirmationEntity> {}
