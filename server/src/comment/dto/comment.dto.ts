import { IsNumber } from 'class-validator';
import { Comment } from '../comment.entity';
export class CommentDto extends Comment {
  @IsNumber()
  likeCount: number;

  @IsNumber()
  dislikeCount: number;
}
