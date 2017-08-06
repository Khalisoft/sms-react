# Container Vs Component

Please read more about these topics in this nice
[article](https://medium.com/@dan_abramov/smart-and-dumb-components-7ca2f9a7c7d0).

## Component (a.k.a presentational components)

* Concerned with how things look
* May contain both presentational and container components inside, and usually
    have some DOM markup and styles of their own.
* Often allow containment via `this.props.children`.
* Have no dependencies on the rest of the app, such as Flux actions or stores.
* Don't specify how the data is loaded or mutated.
* Receive data and callbacks exclusively via props.
* Rarely have their own state (Why they do, it's UI state rather than data).
* Are written as `functional components` unless they need state, lifecycle
    hooks, or performance optimizations.

## Container (a.k.a smart components)

* Are concerned with how things work.
* May contain both presentational and container comoponents inside but usually
    don't have any DOM markup of their own except for some wrapping divs, and
    never have any styles.
* Provide the data and behavior to presentational or other container components.
* Call Flux actions and provide these as callbacks to the presentational
    components.
* Are often stateful, as they tend to serve as data sources.
* Are usually geneated using `high order components` such as connect() from
    React Redux, `createContainer()` from Rely, or `Container.create()` from
    Flux Utils, rather than written by hand.

## When to introduce containers:

As the article suggest, just start with your `components` first. Eventually
you'll realize that you are passing too many props down the intermediate
components. When you notice that some components don't use the props they
receive but merely forward them down and you have to rewire all those
intermediate components any time the children need more data, it's a good time
to introduce some container components. This way you can get the data and the
behavior props to the leaf components without burdening the unreleated
components in the middle of the tree.

# Connecting React to an external API using Redux (React + Redux)

[Reference](http://www.thegreatcodeadventure.com/react-redux-tutorial-part-iii-async-redux/)

![async redux flow](./public/async-redux-flow.png?raw=true "redux flow")

1. Store will dispatch an action that makes a request to external api
2. The action that makes this API request will wait to get a response from the
   API server and it will dispatch a new action that contains payload of
   requested data.
3. The store catches the action and forwards it to the reducer. The reducer will
create a new, updated copy of state, with all the data payload.
4. Changes to state get emitted to any component that are connected to the
   store. This will trigger those component to first update their properties
   using the fresh updated copy of state created by the reducer, and then
   re-render with that new data.

## Store Configuration

```js
import { createStore, applyMiddleware } from 'redux';
import rootReducer from './rootReducer';
import thunk from 'redux-thunk';

const store = createStore(
  rootReducer,
  applyMiddleware(thunk);
)
```

Our invocation of the `createStore` function does two things:

* Connect our store to the `rootReducer`, which we'll define soon. Our root reducer will wrap up our individual reducers. It's a good practice to build a few different reducers to handle different sets of actions. For example, since we have cat data and hobby data, we'll build a cat reducer and a hobby reducer. While we could gave one giant reducer that handles all of our actions, we'll choose to be a bit more organized about it.
* Utilize the Thunk middleware, which will allow us to construct our action creators in a very special way that we'll discuss soon.

## Passing the Store with Redux Provider

Redux Provider is actually a component that Redux gives us access to. We'll wrap our `<Router>` component from our application's entry point, `src/index.js`, in a `<Provider>` component, and pass in an instance of our store.

```js
// src/routes.js

import { createStore, applyMiddleware, compose } from 'redux';
import rootReducer from './rootReducer';
import thunk from 'redux-thunk';

import {
  BrowserRouter as Router,
  Route,
  Switch,
} from 'react-router-dom';


import App from './components/App';

// enabled devtools extension
const store = createStore(
  rootReducer,
  compose(
    applyMiddleware(thunk),
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
  ),
);

export default function Routes() {
  const supportsHistory = 'pushState' in window.history;

  return (
    <Provider store={store}>
      <Router forceRefresh={!supportsHistory}>
        <Switch>
          <Route exact path="/" component={App} />
        </Switch>
      </Router>
    </Provider>
  )
}
  ```

## Actions And Action Creators

we'll build out two action creators to start with. One that makes our API call and uses thunk to dispatch the other action, which will send our API payload to the reducer, via the store.

## The loadCats Action Creator

```js
// src/actions/catActions.js

import axios from 'axios'
import types from './types'

export function loadCats() {
  return dispatch => {
    return axios.get('/api/cats').then(cats => {
      dispatch(loadCatSuccess(cats));
    }).catch(error => {
      throw(error); // or dispatch action for failure
    })
  }
}

export function loadCatSuccess(cats) {
  return { type: types.LOAD_CAT_SUCCESS, cats };
}
```

```js
// src/actions/types.js

export const LOAD_CAT_SUCCESS = 'LOAD_CAT_SUCCESS';
```
Now we can dispatch `loadCats()` action

```js
// src/index.js
...

import { loadCats } from './actions/catActions';

store.dispatch(loadCats());

...
```


## Defining the Reducers

We will combine all reducers in our rootReducer

### The rootReducer
```js
// src/rootReducer.js

import { combineReducers } from 'redux';
import cats from './catReducer';

const rootReducer = combineReducers({
  cats
});

export default rootReducer;
```

### The Cat Reducer

```js
// src/reducers/catReducer.js

import types from '../actions/types'
import initialState from './initialState'

export default funciton catReducer(state = [], action={}) {
  switch(action.type) {
    case types.LOAD_CAT_SUCCESS:
      return action.cats
    default:
      return state;
  }
}
```

## Putting it all together

![async-cats](./public/async-cats.png?raw=true)

* The store dispatches the loadCats action which sends an API request.
* When that action receives a successful response from the API, dispatch the loadCatsSuccess action to the store.
* The store forwards that action to the reducers
* The cat reducer knows how to handle that action. It responds by creating new copy of state that includes all the cats.
* This new state becomes available to any component subscribed to the store.
