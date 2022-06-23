import { Repository } from 'typeorm';
import { LetterEntity } from '../entity/letter';

export class LetterRepository extends Repository<LetterEntity> {}
