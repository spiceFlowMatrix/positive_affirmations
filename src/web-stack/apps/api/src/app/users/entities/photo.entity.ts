import { Entity, Column, OneToOne, PrimaryColumn, CreateDateColumn } from 'typeorm';
import { UserEntity } from './user.entity';
import { ColumnNumericTransformer } from '@web-stack/typeorm-column-transformers';

/**
 * TODO
 * - What else will the schema require for bucket configuration?
 * - Update constructor after bucket config schema is done
 */
@Entity({ name: 'photo' })
export class PhotoEntity {
    @PrimaryColumn('bigint', {
      transformer: new ColumnNumericTransformer(),
      generated: 'increment',
    })
    public id: number;

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

    @Column('boolean')
    public archived: boolean;

    @CreateDateColumn()
    public createdOn: Date;

    // Bucket configuration

    @Column('text')
    public bucketFileID: string;

    @Column('text')
    public bucketName: string;

    @Column('text')
    public filePath: string;

    @Column('boolean')
    public uploaded: boolean;

  constructor(
        id: number,
        archived = false,
        filename?: string,
        alt?: string
        ) {
        this.id = id;
        this.filename = filename;
        this.alt = alt;
        this.archived = archived;
    }
}
