import { DeleteResult, FindOneOptions, Repository } from 'typeorm';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CommentReaction } from './comment-reaction.entity';
import { IReactionCommentStringDto } from './dto/reaction-comment-string.dto';
import { ICommentReactionDto } from './dto/comment-reaction.dto';
import { ICreateCommentReactionDto } from './dto/create-comment-reaction.dto';

@Injectable()
export class CommentReactionService {
  constructor(
    @InjectRepository(CommentReaction)
    private readonly commentReactionRepository: Repository<CommentReaction>,
  ) {}

  async getReactionUsersByCommentId(
    id: string,
    { isLike }: IReactionCommentStringDto,
  ): Promise<CommentReaction[]> {
    const reactionFilter = isLike ? { isLike } : { isDislike: !isLike };
    return this.commentReactionRepository.find({
      where: {
        postId: id,
        ...reactionFilter,
      },
    });
  }

  async getReactionUser(
    where: FindOneOptions<CommentReaction>,
  ): Promise<CommentReaction[]> {
    return this.commentReactionRepository.find(where);
  }

  async deleteById(id: string): Promise<DeleteResult> {
    return this.commentReactionRepository.delete(id);
  }

  async getPostReaction(userId: string, postId: string) {
    return this.commentReactionRepository.findOne({
      where: { userId, postId },
    });
  }

  async createReaction({
    commentId,
    isLike,
    isDisLike,
    userId,
  }: ICreateCommentReactionDto): Promise<any> {
    const switchPostReaction = async (react: ICommentReactionDto) => {
      if ((isLike && react.isDisLike) || (isDisLike && react.isLike)) {
        await this.deleteById(react.id as string);
        await this.commentReactionRepository.create({
          userId,
          commentId,
          isLike,
          isDisLike,
        } as ICreateCommentReactionDto);
      }
    };
    const updateOrDelete = (react: ICommentReactionDto) =>
      (isLike && react.isLike) || (isDisLike && react.isDisLike)
        ? this.deleteById(react.id as string)
        : switchPostReaction(react);
    const reaction = await this.getPostReaction(
      userId as string,
      commentId as string,
    );
    reaction
      ? await updateOrDelete(reaction)
      : await this.commentReactionRepository.create({
          userId,
          commentId,
          isLike,
          isDisLike,
        } as ICreateCommentReactionDto);
    return {};
  }
}
