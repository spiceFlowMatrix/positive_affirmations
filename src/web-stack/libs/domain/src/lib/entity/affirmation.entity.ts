import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { IAffirmation } from '@web-stack/api-interfaces';
import { UserEntity } from './user.entity';
import { AffirmationLikeEntity } from './affirmation-like.entity';
import { ReaffirmationEntity } from './reaffirmation.entity';

@Entity('affirmations')
export class AffirmationEntity implements IAffirmation {
  @PrimaryGeneratedColumn()
  id: number;
  @PrimaryGeneratedColumn('uuid')
  uiId: string;

  @Column({ type: 'varchar', length: 80 })
  title: string;

  @Column('text', { nullable: true })
  subtitle?: string;

  @Column('boolean', { default: true })
  active: boolean;

  @ManyToOne(() => UserEntity, (user) => user.affirmations)
  createdBy: UserEntity;

  @CreateDateColumn()
  createdOn: Date;

  @OneToMany(() => AffirmationLikeEntity, (like) => like.affirmation)
  likes: AffirmationLikeEntity[];

  @OneToMany(
    () => ReaffirmationEntity,
    (reaffirmation) => reaffirmation.forAffirmation
  )
  reaffirmations: ReaffirmationEntity[];

  constructor(args: {
    id?: number;
    uiId?: string;
    title?: string;
    subtitle?: string;
    active?: boolean;
    createdBy?: UserEntity;
    createdOn?: Date;
    likes?: AffirmationLikeEntity[];
    reaffirmations?: ReaffirmationEntity[];
  }) {
    Object.assign(this, args);
  }
}
