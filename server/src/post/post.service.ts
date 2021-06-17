import { DeleteResult, FindOneOptions, Repository } from 'typeorm';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Post } from './post.entity';
import { PostDto } from './dto/post.dto';
import { IFilterDto } from './dto/filter.dto';
import { PostReaction } from '../post-reaction/post-reaction.entity';
import { reactionCount } from 'src/common/helpers';
import { extractResource } from 'src/common/helpers/database/extractor.helper';
import { User } from 'src/user/user.entity';
import { CreatePostDto } from './dto/create-post.dto';
@Injectable()
export class PostService {
  constructor(
    @InjectRepository(Post)
    private readonly postRepository: Repository<Post>,
    @InjectRepository(PostReaction)
    private readonly postReactionRepository: Repository<PostReaction>,
  ) {}

  async getPosts(filter: IFilterDto): Promise<PostDto[]> {
    const { from, count, userId, include, additional } = filter;
    const posts = await this.postRepository
      .createQueryBuilder('post')
      .select()
      .addSelect(
        `(SELECT count(*) FROM "comment" WHERE "post"."id" = "comment"."postId")`,
        'commentCount',
      )
      .addSelect(reactionCount('post', true), 'likeCount')
      .addSelect(reactionCount('post', false), 'dislikeCount')
      .innerJoinAndSelect('post.user', 'user');

    if (userId) {
      if (include && JSON.parse(include)) {
        posts.andWhere('post.userId = :userId', { userId });
      } else if (!additional) {
        posts.andWhere('post.userId != :userId', { userId });
      } else if (additional === 'like') {
        posts.andWhere((qb) => {
          const subQuery = qb
            .subQuery()
            .select('post-reaction.postId')
            .from(PostReaction, 'post-reaction')
            .where('post-reaction.userId = :userId', { userId })
            .getQuery();
          return 'post.id IN ' + subQuery;
        });
      }
    }
    const result = await posts.skip(from).take(count).getRawAndEntities();
    return extractResource<Post, PostDto>(result, 'count');
  }

  async getPostById(where: FindOneOptions<Post>): Promise<Post> {
    return this.postRepository.findOne(
      Object.assign({}, where, { relations: ['comments', 'comments.user'] }),
    );
  }

  async create(data: CreatePostDto, user: User): Promise<Post> {
    return this.postRepository.create({ ...data, user });
  }

  async updateById(id: string, data: PostDto): Promise<Post> {
    await this.postRepository.update(id, data);
    return this.getPostById({ where: { id } });
  }

  async deleteById(id: string): Promise<DeleteResult> {
    return this.postRepository.delete(id);
  }
}
