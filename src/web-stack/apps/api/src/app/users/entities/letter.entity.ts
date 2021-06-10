import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryColumn } from 'typeorm';
import { UserEntity } from './user.entity';
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

@Entity({ name: 'letter' })
export class LetterEntity {
    @PrimaryColumn('bigint', {
      transformer: new ColumnNumericTransformer(),
      generated: 'increment',
    })
    public id: number;

    @ManyToOne((type) => UserEntity, (user) => user.letters)
    public user: UserEntity;

    @Column('boolean')
    public archived: boolean;

    @CreateDateColumn()
    public createdOn: Date;

    constructor(
        id: number,
        archived = false,
    ) {
        this.id = id;
        this.archived = archived;
    }
}
