import { describe, expect, test } from '@jest/globals';
import User from '../user';

describe('User Tests', () =>{

  test('User first name, last name and age match input', () => {
    let firstName = "bob";
    let lastName = "smith";

    var user = new User(firstName, lastName);
    expect(user.firstName).toBe(firstName);
    expect(user.lastName).toBe(lastName);
  });

});
