# TODO

### Rails Api

**Phase 1**

- [x] Build Association [See](#build-association) below
- [x] Add `rails --api` only application to expose required apis with full
    `CRUD` functionality

**Phase 2**

- [ ] Add Signin/Signup APIs
- [ ] User Signup feature should not complete untill they provide their required
    profile information.

### React application

**Phase 1**

- [ ] Add choosen like autocomplete for `country` fields
- [ ] Add `tag` feature for experiences field `array` type.
- [ ] Update Action should bring One form to update everything
- [ ] Delete should happen from index page
- [ ] Search by student name in index page
- [ ] Pagination feature

**Phase 2**

- [ ] Add Signup featuer with Multi step form (Future task)
- [ ] if User skip steps may be 2/3 and complete 1, then next sign in should
    force them to complete their profile information.



## Build Association

| Student              |
| ---                  |
| id (Int)             |
| first_name (string)  |
| last_name (string)   |
| country (string)     |
| experiences (string) |

| Address          |
| ---              |
| id (int)         |
| kind (string)    |
| name (string)    |
| student_id (int) |

| Contact          |
| ---              |
| email (string)   |
| phone (string)   |
| student_id (int) |

```ruby
class Student < ActiveRecord::Base
  has_many :addresses
  has_many :contacts
end

class Address < ActiveRecord::Base
  belongs_to :student
end

class Contact < ActiveRecord::Base
  belongs_to :student
end
```

