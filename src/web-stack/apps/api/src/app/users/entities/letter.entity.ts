import { Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { UserEntity } from './user.entity';
@Entity({ name: 'letter' })
export class LetterEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    @ManyToOne((type) => UserEntity, (user) => user.letters)
    public user: UserEntity;

    constructor(
        id: string
    ) {
        this.id = id;
    }
}