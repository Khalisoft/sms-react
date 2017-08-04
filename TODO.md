# TODO

- [ ] Build Association [See](#build-association)
- [x] Add choosen like autocomplete for `country` fields
- [x] Add `tag` feature for experiences field `array` type.
- [x] Student, Address, Contact should be multi-step form
- [x] if User skip steps may be 2/3 and complete 1, then visiting show page should bring them back to last step they left
- [x] Update Action should bring One form to update everything
- [x] Delete should happen from index page
- [x] Search by student name in index page
- [x] Pagination feature



## Build Association

| Student             |
| ---                 |
| id (Int)            |
| name (string)       |
| country (string)    |
| experiences (array) |

| Address             |
| ---                 |
| id (int)            |
| name (string)       |
| student_id (string) |

| Contact    |
| ---        |
| email      |
| phone      |
| student_id |
