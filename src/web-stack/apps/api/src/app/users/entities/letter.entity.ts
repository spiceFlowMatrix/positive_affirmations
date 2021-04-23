import { Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { UserEntity } from './user.entity';

/**
 * TODO
 * - Constructor 
 */
@Entity({ name: 'letter' })
export class LetterEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    @ManyToOne((type) => UserEntity, (user) => user.letters)
    public user: UserEntity;
}