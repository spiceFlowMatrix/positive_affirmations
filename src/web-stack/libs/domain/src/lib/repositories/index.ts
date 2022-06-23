import { AffirmationLikeRepository } from './affirmation-like.repository';
import { AffirmationRepository } from './affirmation.repository';
import { LetterRepository } from './letter.repository';
import { ReaffirmationRepository } from './reaffirmation.repository';
import { UserRepository } from './user.repository';

export const REPOSITORIES = [
  AffirmationLikeRepository,
  AffirmationRepository,
  LetterRepository,
  ReaffirmationRepository,
  UserRepository,
];
