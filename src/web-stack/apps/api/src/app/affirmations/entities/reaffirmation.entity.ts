import { Entity, ManyToOne, Column, PrimaryColumn, CreateDateColumn } from 'typeorm';
import { AffirmationEntity } from './affirmation.entity';
import { UserEntity } from '../../users/entities/user.entity';
import {NoteEntity} from "../../master/entities/note.entity";
import {FontEntity} from "../../master/entities/font.entity";
import {StampEntity} from "../../master/entities/stamp.entity";
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

/**
 * TODO
 * - Verify Note, Font and Stamp relationships
 * - Constructor
 */

@Entity({ name: 'reaffirmation' })
export class ReaffirmationEntity {
    @PrimaryColumn('bigint', {
      transformer: new ColumnNumericTransformer(),
      generated: 'increment',
    })
    public id: number;

    @ManyToOne((type) => AffirmationEntity, affirmation => affirmation.reaffirmations)
    public affirmation: AffirmationEntity;

    @ManyToOne((type) => NoteEntity, note => note.reaffirmations, { nullable: true })
    public note?: NoteEntity;

    @ManyToOne((type) => NoteEntity, font => font.reaffirmations, { nullable: true })
    public font?: FontEntity;

    @ManyToOne((type) => NoteEntity, stamp => stamp.reaffirmations, { nullable: true })
    public stamp?: StampEntity;

    @ManyToOne((type) => UserEntity, (user) => user.affirmations)
     public user: UserEntity;

    @Column('boolean')
    public archived: boolean;

    @CreateDateColumn()
    public createdOn: Date;

     constructor(
         id: number,
         archived = false,
     ) {
         this.id = id;
         this.archived = archived;
     }
}
