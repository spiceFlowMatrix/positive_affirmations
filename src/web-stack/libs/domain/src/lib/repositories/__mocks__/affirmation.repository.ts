import { affirmationStub } from '../../test/stubs/affirmation.entity.stub';

export const AffirmationRepository = jest.fn().mockReturnValue({
  find: jest.fn().mockReturnValue([affirmationStub()]),
});
