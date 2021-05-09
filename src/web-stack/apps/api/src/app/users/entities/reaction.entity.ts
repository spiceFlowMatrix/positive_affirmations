import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { AffirmationEntity } from './affirmation.entity';
import { UserEntity } from './user.entity';

enum ReactionType {
    Like,
    Favorite,
    Celebrate,
    Support,
    Insightful,
}

@Entity({ name: 'reaction' })
export class ReactionEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    @ManyToOne((type) => AffirmationEntity, affirmation => affirmation.reactions)
    public affirmation: AffirmationEntity;
    
    @Column('enum', { nullable: true })
    public reactionType?: ReactionType;

    @ManyToOne((type) => UserEntity, (user) => user.reactions)
     public user: UserEntity;

    constructor(
        id: string,
        reactionType?: ReactionType
        ) {
            this.id = id;   
            this.reactionType = reactionType;
    }
}