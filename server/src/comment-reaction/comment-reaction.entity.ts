import { Column, Entity, ManyToOne, RelationId } from 'typeorm';
import { AbstractEntity } from '../data/entities/abstract.entity';
import { User } from '../user/user.entity';
import { Comment } from '../comment/comment.entity';

@Entity()
export class CommentReaction extends AbstractEntity {
  @Column({ default: false })
  isLike: boolean;

  @Column({ default: false })
  isDisLike: boolean;

  @RelationId((commentReaction: CommentReaction) => commentReaction.user)
  @Column()
  readonly userId: string;

  @ManyToOne(() => User, (user) => user.comments, {
    onDelete: 'CASCADE',
  })
  user: User;

  @RelationId((commentReaction: CommentReaction) => commentReaction.comment)
  @Column()
  readonly commentId: string;

  @ManyToOne(() => Comment, (comment) => comment.commentReactions, {
    onDelete: 'CASCADE',
  })
  comment: Comment;
}
