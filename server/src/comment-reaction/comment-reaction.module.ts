import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CommentReactionService } from './comment-reaction.service';
import { CommentReactionController } from './comment-reaction.controller';
import { CommentReaction } from './comment-reaction.entity';
import { User } from '../user/user.entity';
@Module({
  imports: [TypeOrmModule.forFeature([CommentReaction, User])],
  providers: [CommentReactionService],
  controllers: [CommentReactionController],
})
export class CommentReactionModule {}
