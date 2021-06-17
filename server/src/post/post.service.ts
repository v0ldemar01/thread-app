import { DeleteResult, FindOneOptions, Repository } from 'typeorm';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Post } from './post.entity';
import { PostDto } from './dto/post.dto';
import { IFilterDto } from './dto/filter.dto';

@Injectable()
export class PostService {
  constructor(
    @InjectRepository(Post)
    private readonly postRepository: Repository<Post>,
  ) {}

  async getPosts(filter: IFilterDto): Promise<Post[]> {
    console.log('filter', filter);
    const { from, count, userId, include, additional } = filter;
    return this.postRepository.find();
  }

  async getPostById(where: FindOneOptions<Post>): Promise<Post> {
    return this.postRepository.findOne(where);
  }

  async create(data: PostDto): Promise<Post> {
    return this.postRepository.save(data);
  }

  async updateById(id: string, data: PostDto): Promise<Post> {
    await this.postRepository.update(id, data);
    return this.getPostById({ where: { id } });
  }

  async deleteById(id: string): Promise<DeleteResult> {
    return this.postRepository.delete(id);
  }
}
