import { Test } from '@nestjs/testing';
import { CreateRequest } from 'firebase-admin/lib/auth/auth-config';
import { FirebaseAdminService } from './firebase-admin.service';

const mockAuth = {
  createUser: jest.fn().mockResolvedValue({}),
};

jest.mock('firebase-admin', () => {
  return {
    auth: jest.fn(() => mockAuth),
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
    jest.spyOn(mockAuth, 'createUser');
    const createRequest: CreateRequest = {
      displayName: 'Test full name',
      password: '1234567As',
      email: 'test@email.com',
    };
    await service.signUpWithEmailPassword(
      createRequest.email,
      createRequest.password,
      createRequest.displayName
    );
    expect(mockAuth.createUser).toHaveBeenCalledWith(createRequest);
  });
});
