import {BaseEntity, Column, CreateDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {IReaffirmation, ReaffirmationFont, ReaffirmationStamp, ReaffirmationValue} from "@web-stack/api-interfaces";
import {UserEntity} from "./user";
import {AffirmationEntity} from "./affirmation";
import {LetterEntity} from "./letter";

@Entity('reaffirmations')
export class ReaffirmationEntity extends BaseEntity implements IReaffirmation {
  @PrimaryGeneratedColumn()
  id: number;
  @PrimaryGeneratedColumn()
  uiId: string;

  @Column({
    type: 'enum',
    enum: ReaffirmationFont,
    default: ReaffirmationFont.none,
    nullable: false,
  })
  font: ReaffirmationFont;

  @Column({
    type: 'enum',
    enum: ReaffirmationStamp,
    default: ReaffirmationStamp.empty,
    nullable: false,
  })
  stamp: ReaffirmationStamp;

  @Column({
    type: 'enum',
    enum: ReaffirmationValue,
    default: ReaffirmationValue.empty,
    nullable: false,
  })
  value: ReaffirmationValue;

  @ManyToOne(() => UserEntity, user => user.reaffirmations)
  createdBy: UserEntity;

  @CreateDateColumn()
  createdOn: Date;

  @ManyToOne(() => AffirmationEntity, affirmation => affirmation.reaffirmations)
  forAffirmation: AffirmationEntity;

  @OneToMany(() => LetterEntity, letter => letter.reaffirmations)
  inLetters: LetterEntity[];

  constructor(args: {
    id?: number;
    uiId?: string;
    font?: ReaffirmationFont;
    stamp?: ReaffirmationStamp;
    value?: ReaffirmationValue;
    createdBy?: UserEntity;
    createdOn?: Date;
    forAffirmation?: AffirmationEntity;
    inLetters?: LetterEntity[];
  }) {
    super();
    Object.assign(this, args);
  }
}
