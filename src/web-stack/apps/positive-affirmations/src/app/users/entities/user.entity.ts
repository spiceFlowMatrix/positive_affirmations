import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'user' })
export class UserEntity {
    @PrimaryGeneratedColumn('uuid')
    public id: string;

    // Reference for column types to database compatibility:
    // https://github.com/typeorm/typeorm/blob/master/src/driver/types/ColumnTypes.ts
    @Column('text')
    public name: string;

    @Column('text')
    public nickname: string;

    @Column('text')
    public description: string;

    @Column('int')
    public affirmations: number;

    @Column('int')
    public letters: number;

    @Column('int')
    public reaffirmations: number;

    /**
     * TODO Not entirely sure about this. Verify!
     */
    @Column({name: 'picture_filename', type: 'text', nullable: true})
    public profilePicturePath: string;
}