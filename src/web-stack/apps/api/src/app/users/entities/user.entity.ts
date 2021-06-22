import { Entity, Column, OneToOne, OneToMany, PrimaryColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { AffirmationEntity } from '../../affirmations/entities/affirmation.entity';
import { LetterEntity } from './letter.entity';
import { PhotoEntity } from './photo.entity';
import { ReactionEntity } from './reaction.entity';
import { ReaffirmationEntity } from '../../affirmations/entities/reaffirmation.entity';
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

/**
 * TODO
 * - Consider removing the modifiedOn field if not required.
 */
@Entity({ name: 'users' })
export class UserEntity {
    @PrimaryColumn('bigint', {
      transformer: new ColumnNumericTransformer(),
      generated: 'increment',
    })
    public id: number;

    // Reference for column types to database compatibility:
    // https://github.com/typeorm/typeorm/blob/master/src/driver/types/ColumnTypes.ts
    @Column('text')
    public name: string;

    @Column('text', { nullable: true })
    public nickname?: string;

    @Column('text', { nullable: true })
    public description?: string;

    @Column('boolean', {default: false})
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

    @CreateDateColumn()
    public createdOn: Date;

    @UpdateDateColumn()
    public modifedOn: Date;

    // constructor(
    //     id: number,
    //     name: string,
    //     description: string,
    //     affirmations: AffirmationEntity[],
    //     reaffirmations: ReaffirmationEntity[],
    //     letters: LetterEntity[],
    //     reactions: ReactionEntity[],
    //     photo: PhotoEntity,
    //     archived = false,
    //     nickname?: string
    //     ) {
    //         this.id = id;
    //         this.name = name;
    //         this.description = description;
    //         this.affirmations = affirmations;
    //         this.reaffirmations = reaffirmations;
    //         this.letters = letters;
    //         this.reactions = reactions;
    //         this.photo = photo;
    //         this.nickname = nickname;
    //         this.archived = archived;
    // }
}
