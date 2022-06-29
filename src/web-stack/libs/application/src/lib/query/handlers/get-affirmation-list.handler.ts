import { IQueryHandler, QueryHandler } from '@nestjs/cqrs';
import { GetAffirmationListQuery } from '../impl/get-affirmation-list.query';
import {
  AffirmationDto,
  AffirmationObjectResponseDto,
  AffirmationRepository,
  FirebaseUserInfo,
  GetAffirmationListQueryResponseDto,
  MissingRequiredParamException,
} from '@web-stack/domain';
import { AuthUserService } from '../../services/auth-user.service';

@QueryHandler(GetAffirmationListQuery)
export class GetAffirmationListHandler
  implements IQueryHandler<GetAffirmationListQuery>
{
  constructor(
    private readonly affirmationRepo: AffirmationRepository,
    private readonly authUserService: AuthUserService
  ) {}

  async execute(
    query: GetAffirmationListQuery
  ): Promise<GetAffirmationListQueryResponseDto> {
    const { skip, take, authUser } = query;
    if (skip === undefined || skip === null) {
      throw new MissingRequiredParamException(
        GetAffirmationListQuery.name,
        'skip',
        'number'
      );
    }
    if (take === undefined || take === null) {
      throw new MissingRequiredParamException(
        GetAffirmationListQuery.name,
        'take',
        'number'
      );
    }
    if (!authUser) {
      throw new MissingRequiredParamException(
        GetAffirmationListQuery.name,
        'authUser',
        FirebaseUserInfo.name
      );
    }
    const user = await this.authUserService.user(authUser);
    const [results, total] = await this.affirmationRepo.findAndCount({
      relations: ['createdBy'],
      skip,
      take,
    });

    if (results.length > 0) {
      const likedAffirmations = await this.affirmationRepo
        .createQueryBuilder('affirmation')
        .leftJoinAndSelect('affirmation.likes', 'like')
        .leftJoinAndSelect('like.byUser', 'likedBy')
        .where('affirmation.id IN (:...affirmationIds)', {
          affirmationIds: results.map((e) => e.id),
        })
        .andWhere('likedBy.dbId = :byUserId', { byUserId: user.dbId })
        .orderBy('affirmation.createdOn', 'DESC')
        .getMany();
      return new GetAffirmationListQueryResponseDto({
        totalResults: total,
        results: results.map((result) => {
          return new AffirmationObjectResponseDto({
            affirmationData: new AffirmationDto({ ...result }),
            liked:
              likedAffirmations.filter((e) => e.id == result.id).length > 0,
          });
        }),
      });
    } else {
      return new GetAffirmationListQueryResponseDto({
        totalResults: 0,
        results: [],
      });
    }
  }
}
