import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as moment from "moment/moment";

admin.initializeApp(functions.config().firebase);
const firestore = admin.firestore();

export enum ReaffirmationValue { empty, braveOn, loveIt, goodWork }

export enum ReaffirmationStamp { empty, takeOff, medal, thumbsUp }

export enum ReaffirmationFont {
    none,
    birthstone,
    gemunuLibre,
    montserrat
}

export enum LetterCreationSchedule { daily, weekly, monthly, never }

export interface LetterAffirmationReaffirmation {
    id: string;
    createdOn: Date;
    value: ReaffirmationValue;
    font: ReaffirmationFont;
    stamp: ReaffirmationStamp;
}

export interface LetterAffirmation {
    id: string;
    title: string;
    subtitle: string;
    totalReaffirmations: number;
    reaffirmations: LetterAffirmationReaffirmation[];
}

export interface Letter {
    id: string;
    createdOn: Date | string;
    totalAffirmations: number;
    affirmations: LetterAffirmation[];
}

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https
    .onRequest(async (req, resp) => {
      const users = await firestore.collection("users").get();
      const applicableUsers = getLetterApplicableUsers(users.docs
          .map((value) => value.data()));
      for (let i = 0; i < applicableUsers.length; i++) {
        const letterAffirmations = await
        generateLetters(applicableUsers[i].id);
        const newLetter = <Letter>{
          id: makeid(32),
          createdOn: moment(moment.now()).utc().toISOString(),
          totalAffirmations: letterAffirmations.length,
          affirmations: letterAffirmations,
        };
        await firestore.collection("users")
            .doc(applicableUsers[i].id).collection("letters")
            .doc(newLetter.id).set(newLetter);
        await firestore.collection("users")
            .doc(applicableUsers[i].id)
            .set({
              ...applicableUsers[i],
              lettersCount: applicableUsers[i].lettersCount + 1,
              lettersLastGeneratedOn: moment(moment.now()).utc().toISOString(),
            });
      }
      resp.send("Success");
    });

export const getLetterApplicableUsers = (users: any[]) => {
  let applicableUsers: any[] = [];
  users.forEach((user: {
        id: any;
        lettersLastGeneratedOn: string;
        letterSchedule: LetterCreationSchedule;
    }) => {
    if (!user.lettersLastGeneratedOn) {
      applicableUsers = [...applicableUsers, user];
      return;
    }
    const schedule = user.letterSchedule;
    const now = moment(moment.now());
    const lastGeneratedMoment = moment(user.lettersLastGeneratedOn);
    const diffSeconds = now.diff(lastGeneratedMoment, "seconds");
    switch (schedule) {
      case LetterCreationSchedule.daily:
        if (Math.round(moment.duration(diffSeconds).asDays()) >= 1) {
          applicableUsers = [...applicableUsers, user];
        }
        break;
      case LetterCreationSchedule.weekly:
        if (Math.round(moment.duration(diffSeconds).asWeeks()) >= 1) {
          applicableUsers = [...applicableUsers, user];
        }
        break;
      case LetterCreationSchedule.monthly:
        if (Math.round(moment.duration(diffSeconds).asMonths()) >= 1) {
          applicableUsers = [...applicableUsers, user];
        }
        break;
      case LetterCreationSchedule.never:
        break;
    }
  });

  return applicableUsers;
};

export const makeid = (length: number): string => {
  let result = "";
  const characters =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const charactersLength = characters.length;
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() *
            charactersLength));
  }
  return result;
};

export const generateLetters = async (userId: string):
    Promise<LetterAffirmation[]> => {
  const affirmations = await firestore.collection("affirmations")
      .where("createdById", "==", userId)
      .get();
  let letterAffirmations: LetterAffirmation[] = [];
  for (let i = 0; i < affirmations.docs.length; i++) {
    const id = affirmations.docs[i].data().id;
    const reaffirmations = await firestore.collection("affirmations")
        .doc(id).collection("reaffirmations").get().then((snap) => {
          return snap.docs.map((doc) => doc.data());
        });
    letterAffirmations = [...letterAffirmations, <LetterAffirmation>{
      id,
      title: affirmations.docs[i].data().title,
      subtitle: affirmations.docs[i].data().subtitle,
      totalReaffirmations: reaffirmations.length,
      reaffirmations: reaffirmations.map((e) => {
        return <LetterAffirmationReaffirmation>{
          id: e.id,
          createdOn: e.createdOn,
          font: e.font,
          stamp: e.stamp,
          value: e.value,
        };
      }),
    }];
  }
  return letterAffirmations;
};

// export interface User {
//   id: string;
//   name: string;
//   nickName: string;
//   pictureB64Enc: string;
//   email: string;
//   accountCreated: boolean;
//   emailVerified: boolean;
// }
//
// export const checkLetters = functions.pubsub.schedule("every 2 minutes")
//     .onRun(async (context) => {
//       const users = await firestore
//           .collection("users")
//           .get();
//       users.docs.map((doc) => doc.data()).forEach((data) => {
//         console.log(JSON.stringify(data));
//       });
//       return null;
//     });
