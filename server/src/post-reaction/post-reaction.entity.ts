import { Column, Entity, ManyToOne, RelationId } from 'typeorm';
import { AbstractEntity } from '../data/entities/abstract.entity';
import { User } from '../user/user.entity';
import { Post } from '../post/post.entity';

@Entity()
export class PostReaction extends AbstractEntity {
  @Column({ default: false })
  isLike: boolean;

  @Column({ default: false })
  isDisLike: boolean;

  @RelationId((postReaction: PostReaction) => postReaction.user)
  @Column()
  readonly userId: string;

  @ManyToOne(() => User, (user) => user.comments, {
    onDelete: 'CASCADE',
  })
  user: User;

  @RelationId((postReaction: PostReaction) => postReaction.post)
  @Column()
  readonly postId: string;

  @ManyToOne(() => Post, (post) => post.postReactions, {
    onDelete: 'CASCADE',
  })
  post: Post;
}
