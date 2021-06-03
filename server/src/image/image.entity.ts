import { User } from 'src/user/user.entity';
import { Column, Entity, OneToOne } from 'typeorm';
import { AbstractEntity } from '../data/entities/abstract.entity';

@Entity()
export class Image extends AbstractEntity {
  @Column()
  link: string;

  @OneToOne(() => User, (user) => user.image, { onDelete: 'CASCADE' })
  user: User;
}
