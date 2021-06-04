import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CommentReactionService } from './comment-reaction.service';
import { CommentReactionController } from './comment-reaction.controller';
import { CommentReaction } from './comment-reaction.entity';
@Module({
  imports: [TypeOrmModule.forFeature([CommentReaction])],
  providers: [CommentReactionService],
  controllers: [CommentReactionController],
})
export class CommentReactionModule {}
