import {BaseEntity, Column, Entity, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {IUser, LetterCreationSchedule} from "@web-stack/api-interfaces";
import {AffirmationEntity} from "./affirmation";
import {LetterEntity} from "./letter";
import {ReaffirmationEntity} from "./reaffirmation";
import {AffirmationLikeEntity} from "./affirmation-like";

@Entity('users')
export class UserEntity extends BaseEntity implements IUser {
  @PrimaryGeneratedColumn()
  dbId: number;
  @PrimaryGeneratedColumn('uuid')
  dbUiId: string;

  @Column('text')
  displayName: string | null;
  @Column('text')
  phoneNumber: string | null;
  @Column('text')
  photoURL: string | null;
  @Column('text')
  providerId: string;
  @Column('text')
  uid: string;

  @Column('text')
  email: string;

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
    displayName?: string;
    phoneNumber?: string;
    photoURL?: string;
    providerId?: string;
    uid?: string;
    email?: string;
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
