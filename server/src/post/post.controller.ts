import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  Query,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt.guard';
import { AuthUser } from '../user/user.decorator';
import { User } from '../user/user.entity';
import { IFilterDto } from './dto/filter.dto';
import { PostDto } from './dto/post.dto';
import { PostService } from './post.service';
import { POST_NOT_FOUND_ERROR } from './constants/post.constants';
import { CreatePostDto } from './dto/create-post.dto';

@Controller('posts')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @UseGuards(JwtAuthGuard)
  @Get('/')
  async getPosts(@Query() filter: IFilterDto) {
    return this.postService.getPosts(filter);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getPostById(@Param('id') id: string) {
    const product = await this.postService.getPostById({ where: { id } });
    if (!product) {
      throw new NotFoundException(POST_NOT_FOUND_ERROR);
    }
    return product;
  }

  @UseGuards(JwtAuthGuard)
  @Post('/')
  async create(@Body() newPost: CreatePostDto, @AuthUser() user: User) {
    return this.postService.create(newPost, user);
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
