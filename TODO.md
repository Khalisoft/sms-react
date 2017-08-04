# TODO

- [ ] Build Association [See](#build-association)
- [ ] Add choosen like autocomplete for `country` fields
- [ ] Add `tag` feature for experiences field `array` type.
- [ ] Student, Address, Contact should be multi-step form
- [ ] if User skip steps may be 2/3 and complete 1, then visiting show page should bring them back to last step they left
- [ ] Update Action should bring One form to update everything
- [ ] Delete should happen from index page
- [ ] Search by student name in index page
- [ ] Pagination feature



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

