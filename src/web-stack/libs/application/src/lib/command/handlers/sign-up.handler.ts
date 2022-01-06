import {CommandHandler, ICommandHandler} from "@nestjs/cqrs";
import {SignUpCommand} from "../impl/sign-up.command";
import {InjectRepository} from "@nestjs/typeorm";
import {UserEntity} from "@web-stack/domain";
import {Repository} from "typeorm";
import {FirebaseAdminService} from "@web-stack/services";

@CommandHandler(SignUpCommand)
export class SignUpHandler implements ICommandHandler<SignUpCommand> {
  constructor(
    @InjectRepository(UserEntity)
    protected readonly userRepo: Repository<UserEntity>,
    protected readonly firebaseAdminService: FirebaseAdminService,
  ) {
  }

  async execute(command: SignUpCommand): Promise<void> {
    const {email, password, displayName, nickName} = command;
    const userRecord = await this.firebaseAdminService.signUpWithEmailPassword(email, password, displayName);
    await this.userRepo.save(new UserEntity({
      displayName: userRecord.displayName,
      email: userRecord.email,
      emailVerified: userRecord.emailVerified,
      phoneNumber: userRecord.phoneNumber,
      photoURL: userRecord.photoURL,
      uid: userRecord.uid,
      nickName: nickName,
    }));
  }
}
