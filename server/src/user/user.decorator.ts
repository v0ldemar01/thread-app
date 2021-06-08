import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { FastifyRequest } from 'fastify';
import { User } from './user.entity';

interface FastifyRequestAuth extends FastifyRequest {
  user?: User;
}

export const AuthUser = createParamDecorator(
  (data: keyof User, ctx: ExecutionContext) => {
    const user = ctx.switchToHttp().getRequest<FastifyRequestAuth>()
      .user as User;
    return data ? user && user[data] : user;
  },
);
