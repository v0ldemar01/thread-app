import { DeleteResult, FindOneOptions, Repository } from 'typeorm';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '../user/user.entity';
import { Post } from '../post/post.entity';
import { Comment } from './comment.entity';
import { CreateCommentDto } from './dto/create-comment.dto';
import { CommentDto } from './dto/comment.dto';
import { IFilterDto } from './dto/filter.dto';
import { reactionCount } from 'src/common/helpers';
import { extractResource } from 'src/common/helpers/database/extractor.helper';
@Injectable()
export class CommentService {
  constructor(
    @InjectRepository(Comment)
    private readonly commentRepository: Repository<Comment>,
    @InjectRepository(Post)
    private readonly postRepository: Repository<Post>,
  ) {}

  async getComments(filter: IFilterDto): Promise<CommentDto[]> {
    const { from, count, postId } = filter;
    const result = await this.commentRepository
      .createQueryBuilder('comment')
      .select()
      .addSelect(reactionCount('comment', true), 'likeCount')
      .addSelect(reactionCount('comment', false), 'dislikeCount')
      .innerJoinAndSelect('comment.user', 'user')
      .where('comment.postId = :postId', { postId })
      .skip(from)
      .take(count)
      .getRawAndEntities();
    return extractResource<Comment, CommentDto>(result, 'count');
  }

  async getCommentById(where: FindOneOptions<Comment>): Promise<Comment> {
    return this.commentRepository.findOne(
      Object.assign({}, where, { relations: ['user'] }),
    );
  }

  async create(data: CreateCommentDto, user: User): Promise<Comment> {
    const post = await this.postRepository.findOne(data.postId);
    return this.commentRepository.save({ ...data, user, post });
  }

  async updateById(id: string, data: CommentDto): Promise<Comment> {
    await this.commentRepository.update(id, data);
    return this.getCommentById({ where: { id } });
  }

  async deleteById(id: string): Promise<DeleteResult> {
    return this.commentRepository.delete(id);
  }
}
