import { Entity, PrimaryGeneratedColumn, Column, OneToOne, OneToMany } from 'typeorm';
import { AffirmationEntity } from './affirmation.entity';
import { LetterEntity } from './letter.entity';
import { PhotoEntity } from './photo.entity';
import { ReactionEntity } from './reaction.entity';
import { ReaffirmationEntity } from './reaffirmation.entity';

/**
 * TODO:
 * - Which fields should be nullable? (i.e. affirmations, reactions, letters)
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

    @Column('boolean')
    public archived: boolean;

    @OneToMany((type) => AffirmationEntity, (affirmation) => affirmation.user)
    public affirmations: AffirmationEntity[];

    @OneToMany((type) => ReactionEntity, (reaction) => reaction.user)
    public reactions: ReactionEntity[];

    @OneToMany((type) => LetterEntity, (letter) => letter.user)
    public letters: LetterEntity[];

    @OneToMany((type) => ReaffirmationEntity, (reaffirmation) => reaffirmation.user)
    public reaffirmations: ReaffirmationEntity[];

    @OneToOne((type) => PhotoEntity, (photo) => photo.user)
    public photo: PhotoEntity;

    constructor(
        id: string,
        name: string,
        description: string,
        affirmations: AffirmationEntity[],
        reaffirmations: ReaffirmationEntity[],
        letters: LetterEntity[],
        reactions: ReactionEntity[],
        photo: PhotoEntity,
        nickname?: string
        ) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.affirmations = affirmations;
            this.reaffirmations = reaffirmations;
            this.letters = letters;
            this.reactions = reactions;
            this.photo = photo;
            this.nickname = nickname;
            this.archived = false;
    }
}