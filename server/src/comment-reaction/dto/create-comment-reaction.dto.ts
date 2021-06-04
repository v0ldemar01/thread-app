export interface ICreateCommentReactionDto {
  isLike?: boolean;
  isDisLike?: boolean;
  userId: string;
  commentId: string;
}
