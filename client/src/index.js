import React from 'react';
import ReactDOM from 'react-dom';

// assets
import 'bootstrap/dist/css/bootstrap.css';
import 'bootswatch/paper/bootstrap.css';
import 'font-awesome/css/font-awesome.css';

import registerServiceWorker from './registerServiceWorker';
import Routes from './routes';

ReactDOM.render(<Routes />, document.getElementById('root'));
registerServiceWorker();
