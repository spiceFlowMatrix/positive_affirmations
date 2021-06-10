import { Entity, Column, ManyToOne, PrimaryColumn, CreateDateColumn } from 'typeorm';
import { AffirmationEntity } from '../../affirmations/entities/affirmation.entity';
import { UserEntity } from './user.entity';
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

enum ReactionType {
    Like,
    Favorite,
    Celebrate,
    Support,
    Insightful,
}

@Entity({ name: 'reaction' })
export class ReactionEntity {
    @PrimaryColumn('bigint', {
      transformer: new ColumnNumericTransformer(),
      generated: 'increment',
    })
    public id: number;

    @ManyToOne((type) => AffirmationEntity, affirmation => affirmation.reactions)
    public affirmation: AffirmationEntity;

    @Column('enum', { nullable: true })
    public reactionType?: ReactionType;

    @ManyToOne((type) => UserEntity, (user) => user.reactions)
    public user: UserEntity;

    @Column('boolean')
    public archived: boolean;

    @CreateDateColumn()
    public createdOn: Date;

    constructor(
        id: number,
        archived = false,
        reactionType?: ReactionType
        ) {
            this.id = id;
            this.reactionType = reactionType;
            this.archived = archived;
    }
}
