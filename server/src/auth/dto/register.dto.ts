import { IsString, IsPhoneNumber } from 'class-validator';

export class RegisterDto {
  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsPhoneNumber('UA')
  phone: string;

  @IsString()
  password: string;
}
