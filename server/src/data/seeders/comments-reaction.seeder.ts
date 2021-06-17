import { Comment } from '../../comment/comment.entity';
import { User } from '../../user/user.entity';
import { CommentReaction } from '../../comment-reaction/comment-reaction.entity';

export class CommentsReactionSeeder {
  public static async execute() {
    const users = await User.find();
    const comments = await Comment.find();
    for (const comment of comments) {
      for (let i = 0; i < Math.floor(Math.random() * users.length); i++) {
        const reaction = Math.random() < 0.5;
        const commentReaction = {
          isLike: reaction,
          isDisLike: !reaction,
        };
        await Object.assign(new CommentReaction(), commentReaction, {
          comment,
          user: users[i],
        }).save();
      }
    }
  }
}
