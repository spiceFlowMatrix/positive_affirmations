import { Entity, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { AffirmationEntity } from './affirmation.entity';
import { UserEntity } from './user.entity';

/**
 * TODO
 * - Separate Notes, fonts, stamps to separate entities
 * - Time created 
 * - Move interfaces to it's own directory
 */

// PLACEHOLDERS
interface INote {
    note: string;
    selected: boolean;
}

// PLACEHOLDERS
interface IFont {
    fontType: string;
}

// PLACEHOLDERS
interface IStamp {
    stamp: string;
}

@Entity({ name: 'reaffirmation' })
export class ReaffirmationEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    @ManyToOne((type) => AffirmationEntity, affirmation => affirmation.reaffirmations)
    public affirmation: AffirmationEntity;
    
    @ManyToOne((type) => UserEntity, (user) => user.affirmations)
     public user: UserEntity;

     constructor(
         id: string
     ) {
         this.id = id;
     }
}