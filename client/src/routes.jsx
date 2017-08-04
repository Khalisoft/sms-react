import React from 'react';

import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom';

// components
import App from './components/App';
import Students from './components/students/Students';
import Student from './components/students/Student';
import AddStudent from './components/students/AddStudent';
import EditStudent from './components/students/EditStudent';

export default function Routes() {
  const supportsHistory = 'pushState' in window.history;

  return (
    <Router forceRefresh={!supportsHistory}>
      <div>
        {/* <Navbar /> */}

        <div className="container">
          <Switch>
            <Route exact path="/" component={App} />

            <Route exact path="/students" component={Students} />
            <Route path="/students/new" component={AddStudent} />
            <Route path="/students/:id/edit" component={EditStudent} />
            <Route path="/students/:id" component={Student} />
          </Switch>
        </div>
      </div>
    </Router>
  )
}
