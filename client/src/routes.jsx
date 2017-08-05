import React from 'react';

import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom';

// components
import Students from './components/students/Students';
import Student from './components/students/Student';
import AddStudent from './components/students/AddStudent';
import EditStudent from './components/students/EditStudent';
import NavigationBar from './components/common/NavigationBar';
import NotFound from './components/common/NotFound';

export default function Routes() {
  const supportsHistory = 'pushState' in window.history;

  return (
    <Router forceRefresh={!supportsHistory}>
      <div>
        <NavigationBar />

        <div className="container">
          <Switch>
            {/* Root route */}
            <Route exact path="/" component={Students} />

            {/* Students */}
            <Route exact path="/students" component={Students} />
            <Route path="/students/new" component={AddStudent} />
            <Route exact path="/students/:id/edit" component={EditStudent} />
            <Route exact path="/students/:id" component={Student} />

            {/* 404 Not Found */}
            <Route component={NotFound} />
          </Switch>
        </div>
      </div>
    </Router>
  )
}
