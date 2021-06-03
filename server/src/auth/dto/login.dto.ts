import { IsString, IsPhoneNumber } from 'class-validator';

export class LoginDto {
  @IsPhoneNumber('UA')
  phone: string;

  @IsString()
  password: string;
}
