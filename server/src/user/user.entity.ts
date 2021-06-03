import {
  Column,
  Entity,
  JoinColumn,
  OneToMany,
  OneToOne,
  RelationId,
} from 'typeorm';
import { AbstractEntity } from '../data/entities/abstract.entity';
import { Image } from '../image/image.entity';
import { Post } from '../post/post.entity';
import { Comment } from '../comment/comment.entity';
import { PostReaction } from '../post-reaction/post-reaction.entity';
import { CommentReaction } from '../comment-reaction/comment-reaction.entity';

@Entity()
export class User extends AbstractEntity {
  @Column()
  firstName: string;

  @Column({ nullable: true })
  lastName: string;

  @Column()
  phone: string;

  @Column()
  password: string;

  @Column({ default: true })
  isActive: boolean;

  @RelationId((user: User) => user.image)
  @Column()
  readonly imageId: string;

  @OneToOne(() => Image, { onDelete: 'CASCADE' })
  @JoinColumn()
  public image: Image;

  @OneToMany(() => Post, (post) => post.user, {
    cascade: true,
  })
  posts: Post[];

  @OneToMany(() => Comment, (comment) => comment.user, {
    cascade: true,
  })
  comments: Comment[];

  @OneToMany(() => PostReaction, (postReaction) => postReaction.user, {
    cascade: true,
  })
  postReactions: PostReaction[];

  @OneToMany(() => CommentReaction, (commentReaction) => commentReaction.user, {
    cascade: true,
  })
  commentReactions: CommentReaction[];
}
