import axios from 'axios';

import { LOAD_STUDENTS_SUCCESS, LOAD_STUDENTS_FAIL } from './types';


function loadStudentSuccess(students) {
  return {
    type: LOAD_STUDENTS_SUCCESS,
    students,
  };
}

function loadStudentFail(error) {
  return {
    type: LOAD_STUDENTS_FAIL,
    error,
  };
}

export function getStudentsList() {
  return dispatch => {
    return axios.get('/students').then(
      (response) => {
        dispatch(
          loadStudentSuccess(response.data)
        );
      },
      (error) => {
        dispatch(
          loadStudentFail(error)
        );
      }
    )
  };
}

