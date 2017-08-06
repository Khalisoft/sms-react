import React from 'react';
import PropTypes from 'prop-types';
import { LinkContainer } from 'react-router-bootstrap';
import { connect } from 'react-redux';

import { getStudentsList } from '../../actions/studentAction';

// components
import StudentList from './StudentList';

function Students({ students, getStudentsList }) {
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

        <StudentList students={students} getStudentsList={getStudentsList} />
      </table>
    </div>
  );
}

Students.propTypes = {
  students: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      first_name: PropTypes.string.isRequired,
      last_name: PropTypes.string.isRequired,
      country: PropTypes.string.isRequired,
      experiences: PropTypes.string.isRequired,
    }).isRequired,
  ).isRequired,
  getStudentsList: PropTypes.func.isRequired,
};

function mapStateToProps(state) {
  return {
    students: state.students,
  };
}

export default connect(mapStateToProps, { getStudentsList })(Students);
