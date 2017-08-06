import {
  LOAD_STUDENTS_SUCCESS,
  LOAD_STUDENTS_FAIL,
} from '../actions/types';
import initialState from './initialState';

export default function studentReducer(
  state = initialState.students,
  action = {},
) {
  switch (action.type) {
    case LOAD_STUDENTS_SUCCESS:
      return action.students;
    case LOAD_STUDENTS_FAIL:
      return action.errors;
    default:
      return state;
  }
}
