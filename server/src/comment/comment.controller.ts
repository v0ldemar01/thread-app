import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/guards/jwt.guard';
import { CommentService } from './comment.service';
import { CommentDto } from './dto/comment.dto';
import { COMMENT_NOT_FOUND_ERROR } from './constants/comment.constants';

@Controller('comment')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @UseGuards(JwtAuthGuard)
  @Get('/')
  async getComments() {
    return this.commentService.getComments();
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getCommentById(@Param() id: string) {
    const product = await this.commentService.getCommentById({ where: { id } });
    if (!product) {
      throw new NotFoundException(COMMENT_NOT_FOUND_ERROR);
    }
    return product;
  }

  @UseGuards(JwtAuthGuard)
  @Post('/')
  async create(@Body() newComment: CommentDto) {
    return this.commentService.create(newComment);
  }

  @UseGuards(JwtAuthGuard)
  @Put(':id')
  async updateById(@Param() id: string, @Body() newComment: CommentDto) {
    const updatedProduct = await this.commentService.updateById(id, newComment);
    if (!updatedProduct) {
      throw new NotFoundException(COMMENT_NOT_FOUND_ERROR);
    }
    return updatedProduct;
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async deleteById(@Param() id: string) {
    const deletedProduct = await this.commentService.deleteById(id);
    if (!deletedProduct) {
      throw new NotFoundException(COMMENT_NOT_FOUND_ERROR);
    }
  }
}
