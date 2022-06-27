import { reaffirmationStub } from '../../test/stubs/reaffirmation.entity.stub';

export const ReaffirmationRepository = jest.fn().mockReturnValue({
  find: jest.fn().mockResolvedValue([reaffirmationStub()]),
});
