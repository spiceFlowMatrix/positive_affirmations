import { Entity, PrimaryGeneratedColumn, Column, OneToOne } from 'typeorm';
import { UserEntity } from './user.entity';

/**
 * TODO
 * - Constructor: What should go in there?
 * - Will the schema require anything else for bucket configuration?
 */
@Entity({ name: 'photo' })
export class PhotoEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    // Reference for column types to database compatibility:
    // https://github.com/typeorm/typeorm/blob/master/src/driver/types/ColumnTypes.ts
    @Column('text', { nullable: true })
    public filename?: string;

    // For accessbility reasons
    // https://usability.yale.edu/web-accessibility/articles/images
    @Column('text', { nullable: true })
    public alt?: string;

    @OneToOne((type) => UserEntity, (user) => user.photo)
    public user: UserEntity;
    
    constructor(filename?: string, alt?: string) {
        this.filename = filename;
        this.alt = alt;
    }
}