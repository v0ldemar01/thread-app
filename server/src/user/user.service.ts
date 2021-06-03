import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindOneOptions, Repository } from 'typeorm';
import { RegisterDto } from 'src/auth/dto/register.dto';
import { User } from './user.entity';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async create(data: RegisterDto): Promise<User> {
    return this.userRepository.save(data);
  }

  async findOne(where: FindOneOptions<User>): Promise<User> {
    return this.userRepository.findOne(where);
  }
}
