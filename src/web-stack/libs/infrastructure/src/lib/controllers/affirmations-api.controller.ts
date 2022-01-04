import {ApiTags} from "@nestjs/swagger";
import {Body, Controller, Param, ParseIntPipe, Post, Put} from "@nestjs/common";
import {AffirmationsApiFacade} from "../service/affirmations-api.facade";
import {AffirmationDto, AffirmationObjectResponseDto, CreateAffirmationCommandDto} from "@web-stack/domain";

@ApiTags('affirmations')
@Controller('affirmations')
export class AffirmationsApiController {
  constructor(private facade: AffirmationsApiFacade) {
  }

  @Post()
  async createAffirmation(@Body() dto: CreateAffirmationCommandDto): Promise<AffirmationDto> {
    return await this.facade.createAffirmation(dto);
  }

  @Put()
  async toggleAffirmationLike(
    @Param('id', new ParseIntPipe()) id: number,
  ): Promise<AffirmationObjectResponseDto> {
    return await this.facade.toggleAffirmationLiked(id);
  }
}
