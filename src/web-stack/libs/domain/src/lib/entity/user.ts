import {BaseEntity, Column, Entity, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {IUser, LetterCreationSchedule} from "@web-stack/api-interfaces";
import {AffirmationEntity} from "./affirmation";
import {LetterEntity} from "./letter";
import {ReaffirmationEntity} from "./reaffirmation";
import {AffirmationLikeEntity} from "./affirmation-like";

@Entity('users')
export class UserEntity extends BaseEntity implements IUser {
  @PrimaryGeneratedColumn()
  id: number;
  @PrimaryGeneratedColumn()
  uiId: string;

  @Column('text')
  name: string;

  @Column('text')
  nickName: string;

  @Column('text')
  email: string;

  @Column('boolean', {nullable: false})
  emailVerified: boolean;

  @Column({
    type: 'enum',
    enum: LetterCreationSchedule,
    default: LetterCreationSchedule.never,
    nullable: false,
  })
  letterSchedule: LetterCreationSchedule;

  @Column('date', {nullable: true})
  lettersLastGeneratedOn: Date;

  @OneToMany(() => ReaffirmationEntity, reaffirmation => reaffirmation.createdBy)
  reaffirmations: ReaffirmationEntity[];

  @OneToMany(() => LetterEntity, letter => letter.createdBy)
  letters: LetterEntity[];

  @OneToMany(() => AffirmationEntity, affirmation => affirmation.createdBy)
  affirmations: AffirmationEntity[];

  @OneToMany(() => AffirmationLikeEntity, like => like.byUser)
  affirmationLikes: AffirmationLikeEntity[];

  constructor(args: {
    id?: number;
    uiId?: string;
    name?: string;
    nickName?: string;
    email?: string;
    emailVerified?: boolean;
    letterSchedule?: LetterCreationSchedule;
    lettersLastGeneratedOn?: Date;
    reaffirmations?: ReaffirmationEntity[];
    letters?: LetterEntity[];
    affirmations?: AffirmationEntity[];
    affirmationLikes?: AffirmationLikeEntity[];
  }) {
    super();
    Object.assign(this, args);
  }
}
