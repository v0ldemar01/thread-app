import {
  BadRequestException,
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Post,
  UseGuards,
} from '@nestjs/common';
import { LocalAuthGuard } from './guards/local.quard';
import { AuthService } from './auth.service';
import { ALREADY_REGISTERED_ERROR } from './constants/auth.constants';
import { RegisterDto } from './dto/register.dto';
import { AuthUser } from '../user/user.decorator';
import { User } from '../user/user.entity';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  @HttpCode(HttpStatus.CREATED)
  async register(@Body() newUser: RegisterDto) {
    const oldUser = await this.authService.findUserByPhone(newUser.phone);
    if (oldUser) {
      throw new BadRequestException(ALREADY_REGISTERED_ERROR);
    }
    return this.authService.createUser(newUser);
  }

  @Post('login')
  @UseGuards(LocalAuthGuard)
  @HttpCode(HttpStatus.OK)
  async login(@AuthUser() user: User) {
    return this.authService.login(user);
  }
}
