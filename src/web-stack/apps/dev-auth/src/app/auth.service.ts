import {Injectable} from "@nestjs/common";
import {FirebaseApp, initializeApp} from "firebase/app";
import {Auth, getAuth, signInWithEmailAndPassword, UserCredential} from "firebase/auth";

export interface IFirebaseConfig {
  apiKey: string,
  authDomain: string,
  databaseURL: string,
  projectId: string,
  storageBucket: string,
  messagingSenderId: string,
  appId: string,
  measurementId: string
}

@Injectable()
export class AuthService {
  private readonly app: FirebaseApp;
  private readonly auth: Auth;

  constructor(firebaseConfig: IFirebaseConfig) {
    this.app = initializeApp(firebaseConfig);
    this.auth = getAuth(this.app);
  }

  async signInWithEmailPassword(email: string, password: string): Promise<UserCredential> {
    return await signInWithEmailAndPassword(this.auth, email, password);
  }
}
