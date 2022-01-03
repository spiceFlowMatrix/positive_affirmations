import {BaseEntity, Column, CreateDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {IAffirmation} from "@web-stack/api-interfaces";
import {UserEntity} from "./user";
import {AffirmationLikeEntity} from "./affirmation-like";
import {ReaffirmationEntity} from "./reaffirmation";

@Entity('affirmations')
export class AffirmationEntity extends BaseEntity implements IAffirmation {
  @PrimaryGeneratedColumn()
  id: number;
  @PrimaryGeneratedColumn()
  uiId: string;

  @Column({type: 'text', length: 80})
  title: string;

  @Column('text')
  subtitle: string;

  @Column('boolean', {default: true})
  active: boolean;

  @ManyToOne(() => UserEntity, user => user.affirmations)
  createdBy: UserEntity;

  @CreateDateColumn()
  createdOn: Date;

  @OneToMany(() => AffirmationLikeEntity, like => like.affirmation)
  likes: AffirmationLikeEntity[];

  @OneToMany(() => ReaffirmationEntity, reaffirmation => reaffirmation.forAffirmation)
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
    super();
    Object.assign(this, args);
  }
}
