import { Column, Entity, ManyToOne, OneToMany, RelationId } from 'typeorm';
import { AbstractEntity } from '../data/entities/abstract.entity';
import { User } from '../user/user.entity';
import { CommentReaction } from '../comment-reaction/comment-reaction.entity';

@Entity()
export class Comment extends AbstractEntity {
  @Column()
  body: string;

  @RelationId((comment: Comment) => comment.user)
  @Column()
  readonly userId: string;

  @ManyToOne(() => User, (user) => user.comments, {
    onDelete: 'CASCADE',
  })
  user: User;

  @OneToMany(
    () => CommentReaction,
    (commentReaction) => commentReaction.comment,
    {
      cascade: true,
    },
  )
  commentReactions: CommentReaction[];
}
