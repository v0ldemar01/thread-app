import { Post } from '../../post/post.entity';
import { User } from '../../user/user.entity';
import { posts } from '../seed-data/posts.seed';

export class PostsSeeder {
  public static async execute() {
    const users = await User.find();
    for (const post of posts) {
      await Object.assign(new Post(), post, {
        user: users[Math.floor(Math.random() * users.length)],
      }).save();
    }
  }
}
