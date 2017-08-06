import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { LinkContainer } from 'react-router-bootstrap';

import TagLabel from '../common/TagLabel';
import Loading from '../common/Loading';

class StudentRow extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isLoading: true
    }
  }

  componentWillMount() {
    this.props.getStudentsList().then(
      () => {
        this.setState({ isLoading: false })
      },
      (errors) => { console.log("error: " + errors.response) }
    )
  }

  render() {
    const LoadingSection = (
      <tr>
        <td colSpan={4}>
          <Loading />
        </td>
      </tr>
    )

    return (
      <tbody>
        {
          this.state.isLoading ?
            LoadingSection :
            this.props.students.map(student =>
              <tr key={student.id}>
                <td>{`${student.first_name} ${student.last_name}`}</td>
                <td>{student.country}</td>
                <td>
                  {
                    student.experiences &&
                      student.experiences.split(',').map((tag, i) => {
                        return <TagLabel key={i} tag={tag} />
                      })
                  }
                </td>
                <td>
                  <LinkContainer to={`/students/${student.id}/edit`}>
                    <a> <i className="fa fa-pencil"></i> </a>
                  </LinkContainer>

                  <a><i className="fa fa-trash"></i></a>
                </td>
              </tr>
            )
        }
      </tbody>
    );
  }
}

StudentRow.defaultProps = {};

StudentRow.propTypes = {
  students: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      first_name: PropTypes.string.isRequired,
      last_name: PropTypes.string.isRequired,
      country: PropTypes.string.isRequired,
      experiences: PropTypes.string.isRequired,
    }).isRequired
  ).isRequired,
};

export default StudentRow;
