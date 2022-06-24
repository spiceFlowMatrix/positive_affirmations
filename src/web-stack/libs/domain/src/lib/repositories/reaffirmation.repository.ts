import { Injectable } from '@nestjs/common';
import { EntityRepository, Repository } from 'typeorm';
import { ReaffirmationEntity } from '../entity/reaffirmation.entity';

@EntityRepository(ReaffirmationEntity)
export class ReaffirmationRepository extends Repository<ReaffirmationEntity> {}
