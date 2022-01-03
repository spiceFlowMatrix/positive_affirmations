import {IAffirmationLike} from "@web-stack/api-interfaces";
import {BaseEntity, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn} from "typeorm";
import {UserEntity} from "./user";
import {AffirmationEntity} from "./affirmation";

@Entity('affirmationLikes')
export class AffirmationLikeEntity extends BaseEntity implements IAffirmationLike {
  @PrimaryGeneratedColumn()
  id: number;
  @PrimaryGeneratedColumn()
  uiId: string;

  @ManyToOne(() => AffirmationEntity, affirmation => affirmation.likes)
  affirmation: AffirmationEntity;

  @ManyToOne(() => UserEntity, user => user.affirmationLikes)
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
    super();
    Object.assign(this, args);
  }
}
