import { Entity, Column, OneToMany, ManyToOne, PrimaryColumn, CreateDateColumn } from 'typeorm';
import { UserEntity } from '../../users/entities/user.entity';
import { ReaffirmationEntity } from './reaffirmation.entity';
import { ReactionEntity } from '../../users/entities/reaction.entity';
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

@Entity({ name: 'affirmation' })
export class AffirmationEntity {
    @PrimaryColumn('bigint', {
      transformer: new ColumnNumericTransformer(),
      generated: 'increment',
    })
    public id: number;

    @Column('text')
    public title: string;

    @Column('text', {nullable: true})
    public note?: string;

    @CreateDateColumn()
    public createdOn: Date;

    @OneToMany((type) => ReactionEntity, (reaction) => reaction.affirmation)
    public reactions: ReactionEntity[];

     @OneToMany((type) => ReaffirmationEntity, (reaffirmation) => reaffirmation.affirmation)
     public reaffirmations: ReaffirmationEntity[];

     @ManyToOne((type) => UserEntity, (user) => user.affirmations)
     public user: UserEntity;

    @Column('boolean')
    public archived: boolean;

     constructor(
         id: number,
         title: string,
         archived = false,
         reactions: ReactionEntity[],
         reaffirmations: ReaffirmationEntity[],
         note?: string
         ) {
            this.id = id;
            this.title = title;
            this.note = note;
            this.archived = archived;
            this.reactions = reactions;
            this.reaffirmations = reaffirmations;
     }

}
