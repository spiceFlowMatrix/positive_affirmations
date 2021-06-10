import { Entity, OneToMany, Column, PrimaryColumn, CreateDateColumn } from 'typeorm';
import {ReaffirmationEntity} from "../../affirmations/entities/reaffirmation.entity";
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

/**
 * TODO
 * - Constructor
 */

@Entity({ name: 'note' })
export class NoteEntity {
  @PrimaryColumn('bigint', {
    transformer: new ColumnNumericTransformer(),
    generated: 'increment',
  })
  public id: number;

  @Column('text')
  public note: string;

  @Column('boolean')
  public selected: boolean;

  @OneToMany((type) => ReaffirmationEntity, reaffirmation => reaffirmation.note)
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
