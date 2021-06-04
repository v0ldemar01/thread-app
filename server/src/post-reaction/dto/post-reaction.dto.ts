import { ICreatePostReactionDto } from './create-post-reaction.dto';

export interface IPostReactionDto extends ICreatePostReactionDto {
  id: string;
}
