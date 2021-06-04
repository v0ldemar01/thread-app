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
import { CommentReactionService } from './comment-reaction.service';
import { ICreateCommentReactionDto } from './dto/create-comment-reaction.dto';
import { IReactionCommentStringDto } from './dto/reaction-comment-string.dto';

@Controller('comment-reaction')
export class CommentReactionController {
  constructor(
    private readonly commentReactionService: CommentReactionService,
  ) {}

  @UseGuards(JwtAuthGuard)
  @Get('/info/:id')
  async getReactionUsersByCommentId(
    @Param() id: string,
    @Query() reactionString: IReactionCommentStringDto,
  ) {
    return this.commentReactionService.getReactionUsersByCommentId(
      id,
      reactionString,
    );
  }

  @UseGuards(JwtAuthGuard)
  @Get('/react/:id')
  async getReactionUser(@Param() id: string) {
    return this.commentReactionService.getReactionUser({
      where: { userId: id },
    });
  }

  @UseGuards(JwtAuthGuard)
  @Post('/')
  async createReaction(@Body() newReaction: ICreateCommentReactionDto) {
    return this.commentReactionService.createReaction(newReaction);
  }
}
