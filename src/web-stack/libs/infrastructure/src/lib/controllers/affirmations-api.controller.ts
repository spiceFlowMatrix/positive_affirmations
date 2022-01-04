import {ApiTags} from "@nestjs/swagger";
import {Body, Controller, Post} from "@nestjs/common";
import {AffirmationsApiFacade} from "../service/affirmations-api.facade";
import {AffirmationDto, CreateAffirmationCommandDto} from "@web-stack/domain";

@ApiTags('affirmations')
@Controller('affirmations')
export class AffirmationsApiController {
  constructor(private facade: AffirmationsApiFacade) {
  }

  @Post()
  async createAffirmation(@Body() dto: CreateAffirmationCommandDto): Promise<AffirmationDto> {
    return await this.facade.createAffirmation(dto);
  }
}
