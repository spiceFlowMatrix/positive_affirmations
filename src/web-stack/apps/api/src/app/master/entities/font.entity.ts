import { Entity, OneToMany, Column, PrimaryColumn, CreateDateColumn } from 'typeorm';
import {ReaffirmationEntity} from "../../affirmations/entities/reaffirmation.entity";
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

/**
 * TODO
 * - Constructor
 */

@Entity({ name: 'font' })
export class FontEntity {
  @PrimaryColumn('bigint', {
    transformer: new ColumnNumericTransformer(),
    generated: 'increment',
  })
  public id: number;

  @Column('text')
  public fontType: string;

  @OneToMany((type) => ReaffirmationEntity, reaffirmation => reaffirmation.font)
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
