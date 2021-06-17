import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/guards/jwt.guard';
import { ICreatePostReactionDto } from './dto/create-post-reaction.dto';
import { IReactionPostStringDto } from './dto/reaction-post-string.dto';
import { PostReactionService } from './post-reaction.service';
@Controller('post-reaction')
export class PostReactionController {
  constructor(private readonly postReactionService: PostReactionService) {}

  @UseGuards(JwtAuthGuard)
  @Get('/info/:id')
  async getReactionUsersByPostId(
    @Param() id: string,
    @Query() reactionString: IReactionPostStringDto,
  ) {
    return this.postReactionService.getReactionUsersByPostId(
      id,
      reactionString,
    );
  }

  @UseGuards(JwtAuthGuard)
  @Get('/react/:id')
  async getReactionUser(@Param() id: string) {
    return this.postReactionService.getReactionUser({ where: { userId: id } });
  }

  @UseGuards(JwtAuthGuard)
  @Post('/')
  async createReaction(@Body() newReaction: ICreatePostReactionDto) {
    return this.postReactionService.createReaction(newReaction);
  }
}
