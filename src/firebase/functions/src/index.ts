import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

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
    createdOn: Date;
    totalAffirmations: number;
    affirmations: LetterAffirmation[];
}

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https
    .onRequest(async (req, resp) => {
      const users = await firestore.collection("users").get();
      for (let i = 0; i < users.docs.length; i++) {
        const letterAffirmations = await
        generateLetters(users.docs[i].data().id);
        const newLetter = <Letter>{
          id: makeid(32),
          createdOn: new Date(Date.now()),
          totalAffirmations: letterAffirmations.length,
          affirmations: letterAffirmations,
        };
        await firestore.collection("users")
            .doc(users.docs[i].data().id).collection("letters")
            .doc(newLetter.id).set(newLetter);
        await firestore.collection("users")
            .doc(users.docs[i].data().id)
            .set({
              ...users.docs[i].data().id,
              lettersCount: users.docs[i].data().lettersCount + 1,
            });
      }
      resp.send("Success");
    });

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

// Get all affirmations by given user
// Get all reaffirmations for all the fetched affirmations
// Create a new letter

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
