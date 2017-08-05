import React, { Component } from 'react';
import { LinkContainer } from 'react-router-bootstrap';

// utils
import { getStudentLists } from '../../utils/students';
// components
import StudentRow from './StudentRow';
import Loading from '../common/Loading';

class Students extends Component {
  constructor(props) {
    super(props);
    this.state = {
      students: [],
      isLoading: true,
    };

    this.handleDelete = this.handleDelete.bind(this);
  }

  componentDidMount() {
    getStudentLists().then(
      (response) => {
        this.setState({ students: response.data, isLoading: false });
      },
    );
  }

  handleDelete(e) {
    e.preventDefault();

    console.log('onDelete');
  }

  render() {
    const { students, isLoading } = this.state;

    return (
      <div className="students-wrapper">
        <h3>Students List</h3>
        <table className="table table-striped">
          <thead>
            <tr>
              <td colSpan="3">Search field</td>
              <td>
                <LinkContainer to="/students/new">
                  <a>Add Student</a>
                </LinkContainer>
              </td>
            </tr>
            <tr>
              <th>Full Name</th>
              <th>Country</th>
              <th>Experiences</th>
              <th>Action</th>
            </tr>
          </thead>

          <tbody>
            {
              isLoading ?
                <tr>
                  <td colSpan={4}>
                    <Loading />
                  </td>
                </tr> :
                students.map((student) =>
                  <StudentRow
                    key={student.id}
                    student={student}
                    handleDelete={this.handleDelete}
                  />
                )
            }
          </tbody>
        </table>
      </div>
    );
  }
}

export default Students;
