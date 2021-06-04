import { ICreateCommentReactionDto } from './create-comment-reaction.dto';

export interface ICommentReactionDto extends ICreateCommentReactionDto {
  id: string;
}
