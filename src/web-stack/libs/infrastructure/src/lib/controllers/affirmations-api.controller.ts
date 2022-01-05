import {ApiBearerAuth, ApiTags} from "@nestjs/swagger";
import {Body, Controller, Get, Param, ParseIntPipe, Post, Put, Query, UseGuards} from "@nestjs/common";
import {AffirmationsApiFacade} from "../service/affirmations-api.facade";
import {
  AffirmationDto,
  AffirmationObjectResponseDto,
  CreateAffirmationCommandDto,
  GetAffirmationListQueryDto,
  GetAffirmationListQueryResponseDto
} from "@web-stack/domain";
import {FirebaseAuthGuard} from "@web-stack/services";

@ApiTags('affirmations')
@Controller('affirmations')
@ApiBearerAuth()
@UseGuards(FirebaseAuthGuard)
export class AffirmationsApiController {
  constructor(private facade: AffirmationsApiFacade) {
  }

  @Get()
  async getAffirmationList(@Query() dto: GetAffirmationListQueryDto): Promise<GetAffirmationListQueryResponseDto> {
    return await this.facade.getAffirmationList(dto);
  }

  @Post()
  async createAffirmation(@Body() dto: CreateAffirmationCommandDto): Promise<AffirmationDto> {
    return await this.facade.createAffirmation(dto);
  }

  @Put(':id')
  async toggleAffirmationLike(
    @Param('id', new ParseIntPipe()) id: number,
  ): Promise<AffirmationObjectResponseDto> {
    return await this.facade.toggleAffirmationLiked(id);
  }
}
