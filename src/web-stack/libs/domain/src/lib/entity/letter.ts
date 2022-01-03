import {ILetter} from "@web-stack/api-interfaces";
import {BaseEntity, Column, CreateDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {UserEntity} from "./user";
import {ReaffirmationEntity} from "./reaffirmation";

@Entity('letters')
export class LetterEntity extends BaseEntity implements ILetter {
  @PrimaryGeneratedColumn()
  id: number;
  @PrimaryGeneratedColumn('uuid')
  uiId: string;

  @Column('boolean', {nullable: false})
  opened: boolean;

  @Column('timestamp')
  openedOn: Date;

  @OneToMany(() => ReaffirmationEntity, reaffirmation => reaffirmation.inLetters)
  reaffirmations: ReaffirmationEntity[];

  @ManyToOne(() => UserEntity, user => user.letters)
  createdBy: UserEntity;

  @CreateDateColumn()
  createdOn: Date;

  constructor(args: {
    id?: number;
    uiId?: string;
    opened?: boolean;
    reaffirmations?: ReaffirmationEntity[];
    openedOn?: Date;
    createdBy?: UserEntity;
    createdOn?: Date;
  }) {
    super();
    Object.assign(this, args);
  }
}
