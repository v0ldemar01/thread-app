export interface ICreatePostReactionDto {
  isLike?: boolean;
  isDisLike?: boolean;
  userId: string;
  postId: string;
}
