import { genSaltSync, hashSync } from 'bcryptjs';

export const users = [
  {
    firstName: 'Volodymyr',
    lastName: 'Minchenko',
    phone: '+380507698499',
    password: hashSync('1411564580', genSaltSync(10)),
  },
  {
    firstName: 'John',
    lastName: 'Smith',
    phone: '+380975678523',
    password: hashSync('1411564580', genSaltSync(10)),
  },
  {
    firstName: 'Alex',
    lastName: 'Ivanov',
    phone: '+380666531570',
    password: hashSync('1411564580', genSaltSync(10)),
  },
  {
    firstName: 'Alex',
    lastName: 'First',
    phone: '+380735744412',
    password: hashSync('1411564580', genSaltSync(10)),
  },
];
