import React from 'react';
import PropTypes from 'prop-types';
import { LinkContainer } from 'react-router-bootstrap';

import TagLabel from '../common/TagLabel';

function StudentRow({ student, handleDelete }) {
  const { first_name, last_name } = student;
  const fullName = `${first_name} ${last_name}`;

  return (
    <tr>
      <td>{fullName}</td>
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

        <a onClick={handleDelete}><i className="fa fa-trash"></i></a>
      </td>
    </tr>
  );
}

StudentRow.defaultProps = {};

StudentRow.propTypes = {
  student: PropTypes.shape({
    first_name: PropTypes.string,
    last_name: PropTypes.string,
    country: PropTypes.string,
    experiences: PropTypes.string,
  }),
  handleDelete: PropTypes.func.isRequired,
};

export default StudentRow;
