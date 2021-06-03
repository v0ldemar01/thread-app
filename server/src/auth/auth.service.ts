import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { genSalt, hash, compare } from 'bcryptjs';
import { UserService } from 'src/user/user.service';
import { User } from 'src/user/user.entity';
import {
  USER_NOT_FOUND_ERROR,
  WRONG_PASSWORD_ERROR,
} from './constants/auth.constants';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  async createUser(newUser: RegisterDto) {
    const salt = await genSalt(10);
    return this.userService.create({
      ...newUser,
      password: await hash(newUser.password, salt),
    });
  }

  async findUserByPhone(phone: string) {
    return this.userService.findOne({ where: { phone } });
  }

  async validateUser(phone: string, password: string): Promise<User> {
    const user = await this.findUserByPhone(phone);
    if (!user) {
      throw new UnauthorizedException(USER_NOT_FOUND_ERROR);
    }
    const isCorrectPassword = await compare(password, user.password);
    if (!isCorrectPassword) {
      throw new UnauthorizedException(WRONG_PASSWORD_ERROR);
    }
    return user;
  }

  async login(phone: string) {
    const payload = { phone };
    return {
      token: await this.jwtService.signAsync(payload),
      user: await this.findUserByPhone(phone),
    };
  }
}
