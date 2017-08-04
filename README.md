# SMS React

Simple SMS (Student Information System) with multi-step form, tags input field,
autocomplete fields, etc, to learn react better.

Backend is powered by rails api `rails new app --api` and Front end is
powered by `create-react-app` CLI. We are keeping both rails api and react
application together. You can find react application inside `client` directory.

## Setting up development servers

```sh
# bundle Gemfile
bundle
# migrate database
rails db:create db:migrate
# install npm packages
cd client/ && yarn
# start both servers together
bin/rails start:development
```

> NOTE: we are using proxy to api server for `create-react-app` in package.json
> file. And Procfile.dev is configured to run development.
> Heroku manages production version automatically.

## How this project was setup

### Generate new rails application, and commit all initial changes to git repository

```
rails new app --api -d postgresql -T
cd app
git init
git commit -m "initial commit"
```

### Add required gems to your Gemfile

Make sure `active_model_serializers`, `rack-cors` and `foreman` present in your Gemfile

```ruby
# Gemfile
...

gem 'rack-cors'
gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  ....
  gem 'foreman'
end
```
### Setup rspec as testing framework, you can skip this if you want

Please follow steps to configure rspec [HERE](https://gist.github.com/przbadu/9d8dc4d4a011d7c5869ed15b4900aebe)
### configure API endpoint for client application

Generate Posts Scaffold as an example endpoint, migrate database and run rails
server to test it.

```ruby
rails g scaffold Post title:string body:text
rails db:migrate
```

Add some seed data to test api endpoint

```ruby
# db/seeds.rb
Post.create([
{title: 'post 1', body: 'my first post'},
{title: 'post 2', body: 'my last post'},
])
```

Now, seed database:

```ruby
rails db:seed
# we will commit all changes here
git add .
git commit -m "Backend part done with working api endpint exposed to
http://localhost:3001/posts"
rails s -p 3001
```

Now navigate to [localhost:3001/posts](http://localhost:3001/posts) and you
should see list of posts in `json` format.

```json
[{"id":1,"title":"post 1","body":"my first post"},{"id":2,"title":"post 2","body":"my last post"}]
```


You can also use `postman` or other
api client to test all RESTfull routes.

```ruby
GET /posts.json  # Get list of posts
GET /posts/:id.json # Get post for given id
POST /posts.json  # Create posts
PATCH /posts/:id.json # Update post for id
PUT /posts/:id.json # update post for id
DELETE /posts/:id.json # Delete post for given id
```

Now that our api is ready to integrate with client side application.


## Setup `React` application

Because we want to deploy both rails api and frontend react application in same
git repository and also we will deploy both of them in same heroku server, for
that reason, we will create new react application inside `client/` directory.

Also note that we are using [create-react-app](https://github.com/facebookincubator/create-react-app) to setup our react application. It is also recommended that you install [yarn](https://yarnpkg.com/en/) dependency management tools (alternative to npm)

From root of your rails api project run below command, also make sure you don't
have any unstaged changes, so that you can compare new files that are generated
by `create-react-app`

```sh
npm install -g create-react-app
create-react-app client
cd client && yarn
# Lets commit our changes here
git add .
git commit -m "generate react application using create-react-app cli"
```

All of our `Posts` related components will go inside
`client/src/Posts/components/Posts.jsx`. Similarly in future if we use Comment
feature, we can keep them inside `client/src/Comments/components/Comments.jsx`.
Also with this project structure, we can keep test for `Posts` inside `client/src/Posts/tests/Posts.test.js`. And similarly, if in future we use redux we can add redux related directories as well, `client/src/Posts/actions/`, `client/src/Posts/reducers/` etc.

Example Posts.jsx looks like:

```js
import React, { Component } from 'react';
import axios from 'axios';
import './Posts.css';

class Posts extends Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: []
    };
  }

  componentWillMount() {
    axios.get('http://localhost:3001/posts')
      .then((posts) => {
        this.setState({ posts: posts.data });
      });
  }

  render() {
    const { posts } = this.state;

    return (
      <div className="table-responsive">
        <table className="table table-bordered table-striped">
          <thead>
            <tr>
              <td>Title</td>
              <td>Description</td>
            </tr>
          </thead>
          <tbody>
            {
              posts.map((post) => {
                return (
                  <tr id={post.id}>
                    <td>{post.title}</td>
                    <td>{post.description}</td>
                  </tr>
                )
              })
            }
          </tbody>
        </table>
      </div>
    );
  }
}

export default Posts;
```


You might have noticed, we are using
[axios](https://github.com/mzabriskie/axios) library for fetching api. So we
need to install it.

```sh
yarn add axios
# OR
npm install --save-dev axios
```

## Configure bootstrap and bootswatch in `create-react-app`

let's improve our design by using `bootstrap` and `bootswatch`.

```sh
yarn add bootstrap@3 bootswatch jquery
```

Finally, let's import these libraries and use our `Posts` component in
`index.js` file.

```js
# client/src/index.js

....

// import styles
import 'bootstrap/dist/css/bootstrap.css';
import 'bootswatch/slate/bootstrap.css';

// jquery for bootstrap
import 'jquery/src/jquery';
import 'bootstrap/dist/js/bootstrap.js';

// Components
import Posts from './Posts/components/Posts';

ReactDOM.render(<Posts />, document.getElementById('root'));
....

```

That's it, if everything goes right, it should now work with `slate` bootswatch
theme.

## Development setup

Add `Procfile.dev` in the root of our project.

```sh
# Procfile.dev
web: cd client && PORT=3000 BROWSER=none npm start
api: PORT=3001 && bundle exec rails s
```

Now we can run `foreman start -f Procfile.dev` and it will run our rails server,
react development server and open our app in browser with Hotreloading enabled.

> Check rake task for more information

## Heroku Deployment

To run our frontend react app in rails server, we need to build it and put it in
rails public/ directory. To do that we will create a `package.json` file in root
of our project directory and add postinstall script there.

```json
{
  "name": "hospital frontdesk",
  "engines": {
    "node": "7.10.0"
  },
  "scripts": {
    "build": "cd client && npm install && npm run build && cd ..",
    "deploy": "cp -a client/build/. public/",
    "postinstall": "npm run build && npm run deploy && echo 'Client built!'"
  }
}
```

Now we need to add heroku's nodejs and ruby build pack to deploy these apps.

```sh
heroku buildpacks:add heroku/nodejs --index 1
heroku buildpacks:add heroku/ruby --index 2
```

Finally add a `Procfile` in the root of the project directory to tell heroku to
run rails app:

```sh
# Procfile
web: bundle exec rails s
```

Set `NPM_CONFIG_PRODUCTION=false` in heroku config variables:

```sh
heroku config:set NPM_CONFIG_PRODUCTION=false
```

now commit everything and push to heroku:

```sh
git add .
git commit "app ready to deploy"
heroku login
heroku create
git push heroku master
heroku run rails db:migrate
heroku run rails db:seed
```
And congratulations!!, you just made your react, rails application live. ;-)
