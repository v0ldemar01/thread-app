import { User } from '../../user/user.entity';
import { users } from '../seed-data/users.seed';

export class UsersSeeder {
  public static async execute() {
    for (const user of users) {
      await Object.assign(new User(), user).save();
    }
  }
}
