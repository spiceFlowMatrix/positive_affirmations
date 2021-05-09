import { Entity, PrimaryGeneratedColumn, Column, OneToMany, ManyToOne } from 'typeorm';
import { UserEntity } from './user.entity';
import { ReaffirmationEntity } from './reaffirmation.entity';
import { ReactionEntity } from './reaction.entity';

/**
 * TODO
 * - Time created (how to generate and store this?)
 * - Which fields should be nullable?
 */
@Entity({ name: 'affirmation' })
export class AffirmationEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    @Column('text')
    public title: string;

    @Column('text', {nullable: true})
    public note?: string;

    @Column('date')
    public date: Date;

    @OneToMany((type) => ReactionEntity, (reaction) => reaction.affirmation)
    public reactions: ReactionEntity[];
    
     @OneToMany((type) => ReaffirmationEntity, (reaffirmation) => reaffirmation.affirmation)
     public reaffirmations: ReaffirmationEntity[];

     @ManyToOne((type) => UserEntity, (user) => user.affirmations)
     public user: UserEntity;

     constructor(
         id: string,
         title: string,
         note?: string
         ) {
            this.id = id;
            this.title = title;
            this.note = note;
     }

}