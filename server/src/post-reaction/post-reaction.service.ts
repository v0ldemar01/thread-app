import { DeleteResult, FindOneOptions, Repository } from 'typeorm';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { PostReaction } from './post-reaction.entity';
import { IReactionPostStringDto } from './dto/reaction-post-string.dto';
import { ICreatePostReactionDto } from './dto/create-post-reaction.dto';
import { IPostReactionDto } from './dto/post-reaction.dto';

@Injectable()
export class PostReactionService {
  constructor(
    @InjectRepository(PostReaction)
    private readonly postReactionRepository: Repository<PostReaction>,
  ) {}

  async getReactionUsersByPostId(
    id: string,
    { isLike }: IReactionPostStringDto,
  ): Promise<PostReaction[]> {
    const reactionFilter = isLike ? { isLike } : { isDislike: !isLike };
    return this.postReactionRepository.find({
      where: {
        postId: id,
        ...reactionFilter,
      },
    });
  }

  async getReactionUser(
    where: FindOneOptions<PostReaction>,
  ): Promise<PostReaction[]> {
    return this.postReactionRepository.find(where);
  }

  async deleteById(id: string): Promise<DeleteResult> {
    return this.postReactionRepository.delete(id);
  }

  async getPostReaction(userId: string, postId: string) {
    return this.postReactionRepository.findOne({
      where: { userId, postId },
    });
  }

  async createReaction({
    postId,
    isLike,
    isDisLike,
    userId,
  }: ICreatePostReactionDto): Promise<any> {
    const switchPostReaction = async (react: IPostReactionDto) => {
      if ((isLike && react.isDisLike) || (isDisLike && react.isLike)) {
        await this.deleteById(react.id as string);
        await this.postReactionRepository.create({
          userId,
          postId,
          isLike,
          isDisLike,
        } as ICreatePostReactionDto);
      }
    };
    const updateOrDelete = (react: IPostReactionDto) =>
      (isLike && react.isLike) || (isDisLike && react.isDisLike)
        ? this.deleteById(react.id as string)
        : switchPostReaction(react);
    const reaction = await this.getPostReaction(
      userId as string,
      postId as string,
    );
    reaction
      ? await updateOrDelete(reaction)
      : await this.postReactionRepository.create({
          userId,
          postId,
          isLike,
          isDisLike,
        } as ICreatePostReactionDto);
    return {};
  }
}
