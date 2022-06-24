import { Repository } from 'typeorm';
import { LetterEntity } from '../entity/letter.entity';

export class LetterRepository extends Repository<LetterEntity> {}
