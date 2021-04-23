import { Entity, PrimaryGeneratedColumn, Column, OneToOne, OneToMany } from 'typeorm';
import { AffirmationEntity } from './affirmation.entity';
import { LetterEntity } from './letter.entity';
import { LikeEntity } from './like.entity';
import { PhotoEntity } from './photo.entity';
import { ReaffirmationEntity } from './reaffirmation.entity';

/**
 * TODO
 * - Constructor: What should go in there?
 */
@Entity({ name: 'user' })
export class UserEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    // Reference for column types to database compatibility:
    // https://github.com/typeorm/typeorm/blob/master/src/driver/types/ColumnTypes.ts
    @Column('text')
    public name: string;

    @Column('text', { nullable: true })
    public nickname?: string;

    @Column('text')
    public description: string;

    @OneToMany((type) => AffirmationEntity, (affirmation) => affirmation.user)
    public affirmations: AffirmationEntity[];

    @OneToMany((type) => LikeEntity, (like) => like.user)
    public likes: LikeEntity[];

    @OneToMany((type) => LetterEntity, (letter) => letter.user)
    public letters: AffirmationEntity[];

    @OneToMany((type) => ReaffirmationEntity, (reaffirmation) => reaffirmation.user)
    public reaffirmations: ReaffirmationEntity[];

    @OneToOne((type) => PhotoEntity, (photo) => photo.user)
    public photo: PhotoEntity;

}