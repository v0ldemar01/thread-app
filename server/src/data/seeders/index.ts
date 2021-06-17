import { createConnection } from 'typeorm';
import { CommentsReactionSeeder } from './comments-reaction.seeder';
import { CommentsSeeder } from './comments.seeder';
import { PostsReactionSeeder } from './posts-reaction.seeder';
import { PostsSeeder } from './posts.seeder';
import { UsersSeeder } from './users.seeder';

(async () => {
  try {
    await createConnection();
    await UsersSeeder.execute();
    await PostsSeeder.execute();
    await CommentsSeeder.execute();
    await CommentsReactionSeeder.execute();
    await PostsReactionSeeder.execute();
  } catch (err) {
    console.log(err);
  }
})();
