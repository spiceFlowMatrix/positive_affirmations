import {CreateAffirmationHandler} from "./handlers/create-affirmation.handler";
import {ToggleAffirmationLikeHandler} from "./handlers/toggle-affirmation-like.handler";
import {SignUpHandler} from "./handlers/sign-up.handler";

export const CommandHandlers = [
  CreateAffirmationHandler,
  ToggleAffirmationLikeHandler,
  SignUpHandler,
];
