import axios from 'axios';

export function getStudentLists() {
  return axios.get('/students');
}
