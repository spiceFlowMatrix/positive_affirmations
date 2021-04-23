import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { AffirmationEntity } from './affirmation.entity';
import { UserEntity } from './user.entity';

/**
 * TODO
 * - Constructor: What should go in there?
 */
enum LikeType {
    Like,
    Favorite,
    Celebrate,
    Support,
    Insightful,
}

@Entity({ name: 'like' })
export class LikeEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    @ManyToOne((type) => AffirmationEntity, affirmation => affirmation.likes)
    public affirmation: AffirmationEntity;
    
    @Column('enum', { nullable: true })
    public likeType?: LikeType;

    @ManyToOne((type) => UserEntity, (user) => user.likes)
     public user: UserEntity;

    constructor(likeType?: LikeType) {
        this.likeType = likeType;
    }
}