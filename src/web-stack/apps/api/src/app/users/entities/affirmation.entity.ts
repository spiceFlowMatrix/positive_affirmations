import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
import { UserEntity } from './user.entity'

@Entity({ name: 'affirmation' })
export class AffirmationEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    // Reference for column types to database compatibility:
    // https://github.com/typeorm/typeorm/blob/master/src/driver/types/ColumnTypes.ts
    @Column('text')
    public title: string;

    @Column('text', {nullable: true})
    public note: string;

    @Column('int')
    public likes: number;

    // TODO how to do this?
    // @Column({name: 'created_by', type: 'user'})
    // public createdBy: string;
    
    /**
     * TODO These are computed values and not just numbers. Link to reaffirations
     */
    @Column('int')
    public reaffirmations: number;

    /**
     * TODO Not entirely sure about this. Verify!
     */
    @Column({name: 'picture_filename', type: 'text', nullable: true})
    public profilePicturePath: string;
}