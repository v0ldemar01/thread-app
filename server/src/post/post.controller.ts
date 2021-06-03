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
import { POST_NOT_FOUND_ERROR } from './constants/post.constants';
import { PostDto } from './dto/post.dto';
import { PostService } from './post.service';

@Controller('post')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @UseGuards(JwtAuthGuard)
  @Get('/')
  async getPosts() {
    return this.postService.getPosts();
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getPostById(@Param() id: string) {
    const product = await this.postService.getPostById({ where: { id } });
    if (!product) {
      throw new NotFoundException(POST_NOT_FOUND_ERROR);
    }
    return product;
  }

  @UseGuards(JwtAuthGuard)
  @Post('/')
  async create(@Body() newPost: PostDto) {
    return this.postService.create(newPost);
  }

  @UseGuards(JwtAuthGuard)
  @Put(':id')
  async updateById(@Param() id: string, @Body() newPost: PostDto) {
    const updatedProduct = await this.postService.updateById(id, newPost);
    if (!updatedProduct) {
      throw new NotFoundException(POST_NOT_FOUND_ERROR);
    }
    return updatedProduct;
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async deleteById(@Param() id: string) {
    const deletedProduct = await this.postService.deleteById(id);
    if (!deletedProduct) {
      throw new NotFoundException(POST_NOT_FOUND_ERROR);
    }
  }
}
