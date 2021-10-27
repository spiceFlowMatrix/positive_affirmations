import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);
// const firestore = admin.firestore();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

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
