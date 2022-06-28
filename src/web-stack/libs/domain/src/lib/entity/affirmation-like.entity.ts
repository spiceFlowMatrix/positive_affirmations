import { IAffirmationLike } from '@web-stack/api-interfaces';
import {
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { UserEntity } from './user.entity';
import { AffirmationEntity } from './affirmation.entity';

@Entity('affirmation_likes')
export class AffirmationLikeEntity implements IAffirmationLike {
  @PrimaryGeneratedColumn()
  id: number;
  @PrimaryGeneratedColumn('uuid')
  uiId: string;

  @ManyToOne(() => AffirmationEntity, (affirmation) => affirmation.likes)
  affirmation: AffirmationEntity;

  @ManyToOne(() => UserEntity, (user) => user.affirmationLikes)
  byUser: UserEntity;

  @CreateDateColumn()
  createdOn: Date;

  constructor(args: {
    id?: number;
    uiId?: string;
    affirmation?: AffirmationEntity;
    byUser?: UserEntity;
    createdOn?: Date;
  }) {
    Object.assign(this, args);
  }
}
