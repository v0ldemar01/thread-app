import { IsString, IsUUID } from 'class-validator';

export class CreateCommentDto {
  @IsString()
  body: string;

  @IsUUID()
  postId: string;
}
