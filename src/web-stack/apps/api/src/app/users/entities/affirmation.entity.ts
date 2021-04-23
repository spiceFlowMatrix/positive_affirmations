import { Entity, PrimaryGeneratedColumn, Column, OneToMany, ManyToOne } from 'typeorm';
import { UserEntity } from './user.entity';
import { LikeEntity } from './like.entity';
import { ReaffirmationEntity } from './reaffirmation.entity';

/**
 * TODO
 * - Time created (how to generate and store this?)
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

    @OneToMany((type) => LikeEntity, (like) => like.affirmation)
    public likes: LikeEntity[];
    
     @OneToMany((type) => ReaffirmationEntity, (reaffirmation) => reaffirmation.affirmation)
     public reaffirmations: ReaffirmationEntity[];

     @ManyToOne((type) => UserEntity, (user) => user.affirmations)
     public user: UserEntity;

     constructor(title: string, note?: string) {
         this.title = title;
         this.note = note;
     }

}