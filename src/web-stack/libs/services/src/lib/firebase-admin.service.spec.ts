import { Test } from '@nestjs/testing';
import * as admin from 'firebase-admin';
import { FirebaseAdminService } from './firebase-admin.service';

jest.mock('firebase-admin', () => {
  const auth = jest.fn(() => ({
    createUser: jest.fn().mockReturnThis(),
  }));

  return {
    auth,
  };
});

// Solution for mocking firebase-admin adapted from:
// https://stackoverflow.com/a/61420509/5472560
describe('database connector', () => {
  let service: FirebaseAdminService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [FirebaseAdminService],
    }).compile();

    service = moduleRef.get<FirebaseAdminService>(FirebaseAdminService);

    jest.clearAllMocks();
  });

  it('test', async () => {
    await service.signUpWithEmailPassword(
      'test@email.com',
      '1234567As',
      'Test full name'
    );
  });

  // it('should connect to Firebase when given valid credentials', () => {
  //   const key =
  //     'ewogICJkdW1teSI6ICJUaGlzIGlzIGp1c3QgYSBkdW1teSBKU09OIG9iamVjdCIKfQo='; // dummy key

  //   admin.initializeApp({
  //     credential: admin.credential.cert(key),
  //   });

  //   expect(admin.initializeApp).toHaveBeenCalledTimes(1);
  //   // expect(admin.credential.cert).toHaveBeenCalledTimes(1)
  //   // expect(admin.firestore).toHaveBeenCalledTimes(1)
  // });
});
