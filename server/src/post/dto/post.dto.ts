import { IsNumber } from 'class-validator';
import { Post } from '../post.entity';
export class PostDto extends Post {
  @IsNumber()
  commentCount: number;

  @IsNumber()
  likeCount: number;

  @IsNumber()
  dislikeCount: number;
}
