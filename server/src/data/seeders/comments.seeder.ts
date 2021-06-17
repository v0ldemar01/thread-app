import { Comment } from '../../comment/comment.entity';
import { User } from '../../user/user.entity';
import { Post } from '../../post/post.entity';
import { comments } from '../seed-data/comments.seed';

export class CommentsSeeder {
  public static async execute() {
    const users = await User.find();
    const posts = await Post.find();
    for (const comment of comments) {
      await Object.assign(new Comment(), comment, {
        user: users[Math.floor(Math.random() * users.length)],
        post: posts[Math.floor(Math.random() * posts.length)],
      }).save();
    }
  }
}
