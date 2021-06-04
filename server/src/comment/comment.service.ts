import { DeleteResult, FindOneOptions, Repository } from 'typeorm';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Comment } from './comment.entity';
import { CommentDto } from './dto/comment.dto';

@Injectable()
export class CommentService {
  constructor(
    @InjectRepository(Comment)
    private readonly commentRepository: Repository<Comment>,
  ) {}

  async getComments(): Promise<Comment[]> {
    return this.commentRepository.find();
  }

  async getCommentById(where: FindOneOptions<Comment>): Promise<Comment> {
    return this.commentRepository.findOne(where);
  }

  async create(data: CommentDto): Promise<Comment> {
    return this.commentRepository.save(data);
  }

  async updateById(id: string, data: CommentDto): Promise<Comment> {
    await this.commentRepository.update(id, data);
    return this.getCommentById({ where: { id } });
  }

  async deleteById(id: string): Promise<DeleteResult> {
    return this.commentRepository.delete(id);
  }
}
