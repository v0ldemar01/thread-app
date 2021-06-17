import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PostReaction } from 'src/post-reaction/post-reaction.entity';
import { PostController } from './post.controller';
import { Post } from './post.entity';
import { PostService } from './post.service';
@Module({
  imports: [TypeOrmModule.forFeature([Post, PostReaction])],
  controllers: [PostController],
  providers: [PostService],
})
export class PostModule {}
