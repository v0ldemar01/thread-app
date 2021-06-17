import { Post } from '../../post/post.entity';
import { User } from '../../user/user.entity';
import { PostReaction } from '../../post-reaction/post-reaction.entity';

export class PostsReactionSeeder {
  public static async execute() {
    const users = await User.find();
    const posts = await Post.find();
    for (const post of posts) {
      for (let i = 0; i < Math.floor(Math.random() * users.length); i++) {
        const reaction = Math.random() < 0.5;
        const postReaction = {
          isLike: reaction,
          isDisLike: !reaction,
        };
        await Object.assign(new PostReaction(), postReaction, {
          post,
          user: users[i],
        }).save();
      }
    }
  }
}
