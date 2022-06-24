import { Test } from '@nestjs/testing';
import { ReaffirmationRepository } from '../repositories/reaffirmation.repository';
import { ReaffirmationModel } from './support/reaffirmation.model';
import { getRepositoryToken } from '@nestjs/typeorm';
import { ReaffirmationEntity } from '../entity/reaffirmation.entity';
import { FilterQuery, FindOneOptions } from 'typeorm';
import { reaffirmationStub } from './stubs/reaffirmation.stub';

jest.mock('../repositories/reaffirmation.repository');

describe('ReaffirmationRepository', () => {
  let repository: ReaffirmationRepository;

  describe('find operations', () => {

    beforeEach(async () => {
      const moduleRef = await Test.createTestingModule({
        providers: [
          ReaffirmationRepository,
        ],
      }).compile();

      repository = moduleRef.get<ReaffirmationRepository>(
        ReaffirmationRepository
      );

      jest.clearAllMocks();
    });

    describe('findOne', () => {
      describe('when findOne is called', () => {
        let reaffirmation: ReaffirmationEntity;

        // beforeEach(async () => {
        // });

        test('should exist', async () => {
          expect(repository).toBeDefined();
          const list = await repository.find();
          expect(list.length).toBe(3);
        });

        // test('then it should call the userModel', async () => {
        //   jest.spyOn(model, 'findOne');
        //   reaffirmation = await repository.findOne(reaffirmationStub().id);
        //   expect(model.findOne).toHaveBeenCalledWith(reaffirmationStub().id);
        // });

        // test('then it should return a user', async () => {
        //   jest.spyOn(model, 'findOne');
        //   reaffirmation = await repository.findOne(reaffirmationStub().id);
        //   expect(reaffirmation).toEqual(reaffirmationStub());
        // });
      });
    });
  });
});
