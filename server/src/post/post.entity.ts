import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  OneToOne,
  RelationId,
} from 'typeorm';
import { AbstractEntity } from '../data/entities/abstract.entity';
import { User } from '../user/user.entity';
import { Image } from '../image/image.entity';
import { Comment } from '../comment/comment.entity';
import { PostReaction } from '../post-reaction/post-reaction.entity';

@Entity()
export class Post extends AbstractEntity {
  @Column()
  body: string;

  @RelationId((post: Post) => post.image)
  @Column({ nullable: true })
  readonly imageId: string;

  @OneToOne(() => Image, { onDelete: 'CASCADE' })
  @JoinColumn()
  public image: Image;

  @RelationId((post: Post) => post.user)
  @Column()
  readonly userId: string;

  @ManyToOne(() => User, (user) => user.posts, {
    onDelete: 'CASCADE',
  })
  user: User;

  @OneToMany(() => Comment, (comment) => comment.post, {
    cascade: true,
  })
  comments: Comment[];

  @OneToMany(() => PostReaction, (postReaction) => postReaction.post, {
    cascade: true,
  })
  postReactions: PostReaction[];
}
