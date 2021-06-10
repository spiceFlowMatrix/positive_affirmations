import { Entity, OneToMany, Column, PrimaryColumn, CreateDateColumn } from 'typeorm';
import {ReaffirmationEntity} from "../../affirmations/entities/reaffirmation.entity";
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

/**
 * TODO
 * - Constructor
 */

@Entity({ name: 'stamp' })
export class StampEntity {
  @PrimaryColumn('bigint', {
    transformer: new ColumnNumericTransformer(),
    generated: 'increment',
  })
  public id: number;

  @OneToMany((type) => ReaffirmationEntity, reaffirmation => reaffirmation.stamp)
  public reaffirmations: ReaffirmationEntity[];

  @Column('boolean')
  public archived: boolean;

  @CreateDateColumn()
  public createdOn: Date;

  constructor(
    id: number,
    reaffirmations: ReaffirmationEntity[],
    archived = false,
  ) {
    this.id = id;
    this.reaffirmations = reaffirmations;
    this.archived = archived;
  }
}
