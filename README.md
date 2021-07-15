# Friends API 

This assignment will cover the signup, login endpoints as well as an additional resource users and friends that can be accessed if you are logged in.

To determine whether a request is from a logged in user or not, we'll be using Json Web Tokens (https://jwt.io/). The frontend will be sending requests with the JWT in the Authorization header (Authorization: Bearer <token>). Feel free to use the ruby-jwt gem (or another JWT implementation).

For the database, please use PostgreSQL.


## API Specifications

### Signup and Login

#### POST /signup
Endpoint to create a user in the database. The payload should follow this structure:
```json
{
  "user": {
    "email": "john.doe@mail.com",
    "name": "John Doe",
    "password": "secr3t"
  }
}
```

Note that email is an unique key in the database.

The response body should return a JWT on success that can be used for other endpoints:
```json
{
  "token": "some_jwt_token"
}
```

#### POST /login

Endpoint to log a user in. The payload should have the following fields:
```json
{
  "login": {
    "email": "john.doe@mail.com",
    "password": "secr3t"
  }
}
```

The response body should return a JWT on success that can be used for other endpoints:
```json
{
  "token": "some_jwt_token"
}
```
### User resources

#### GET /users
Endpoint to retrieve a json of all users.

This endpoint requires a valid Authorization header to be passed in with the request.
The response body should look like:
```json
{
  "users": [
    {
      "name": "John Doe",
      "email": "john.doe@mail.com"
    }
  ]
}
```

### Friend resources

#### POST /users/:email/friendship
Endpoint to create a relationship between the logged in user and the user found via the :email param.
Users can only befriend each other once.
If another user adds you as a friend, it will be returned in the GET /users/me/friends response as well.

This endpoint requires a valid Authorization header to be passed in.
The request body should be empty.
The response body should look like:
```json
{
  "friendship": {
    "user": {
      "name": "Logged in user",
      "email": "loggedin@user.com"
    },
    "friend": {
      "name": "Friend Name",
      "email": "friend@email.com"
    }
  }
}
```

#### GET /users/me/friends
Endpoint that returns all of the logged in user's friends, regardless of who initiated the friendship.

This endpoint requires a valid Authorization header to be passed in.
The response body should look like:
```json
{
  "friends": [
    {
      "name": "John Doe",
      "email": "john.doe@mail.com"
    }
  ]
}
```

### Endpoints
- [X] Authentication Signup
- [X] Authentication Login
- [X] Endpoint to list users
- [X] Endpoint to create a new friendship
- [X] Endpoint to list my friends

## Curls Commands

### Sign Up
```bash
curl -X POST http://localhost:3000/signup -H "Content-Type: application/json" -d '{"user": { "name": "Cattani", "password": "secret", "email": "catt@mail.com"} }'

{"token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5fQ.YDT5TsuHjxm_rKN-lubXqCMO1c_cv0gcd3EYQ3O59XE"}%
```

### Login
```
curl -X POST http://localhost:3000/login -H "Content-Type: application/json" -d '{"login": { "password": "secret", "email": "catt@mail.com"} }'

{"token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5fQ.YDT5TsuHjxm_rKN-lubXqCMO1c_cv0gcd3EYQ3O59XE"}%
```

### List Users
```bash
curl --header "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5fQ.YDT5TsuHjxm_rKN-lubXqCMO1c_cv0gcd3EYQ3O59XE" --header "Content-Type: application/json" -X GET http://localhost:3000/users

{"users":[{"name":"Emogene","email":"antone_olson@roob.name"},{"name":"Luther" "email":"wally@carroll.com"}]}%
```

### Creates Friendship
```bash
curl --header "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5fQ.YDT5TsuHjxm_rKN-lubXqCMO1c_cv0gcd3EYQ3O59XE" --header "Content-Type: application/json" -X POST http://localhost:3000/users/beto@mail.com/friendship

{"friendship":{"user":{"name":"Cattani","email":"revoada@mail"},"friend":{"name":"Betao","email":"beto1@mail.com"}}}%
```

### List Friends
```bash
curl --header "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5fQ.YDT5TsuHjxm_rKN-lubXqCMO1c_cv0gcd3EYQ3O59XE" --header "Content-Type: application/json" -X GET http://localhost:3000/users/me/friends

{"friends":[{"name":"Betao","email":"beto@mail.com"},{"name":"Betao","email":"beto1@mail.com"}]}%
```

### Dependencies
- Ruby - ruby 3.0.1
- Rails 6.1.3.2
- Postgresql - 13

### Running the project with the basic setup
$ git clone <repository name>
$ cd project path

```bash
$ bin/setup
```

```bash
$ rails s
```

or 

### Running the project using Docker
```bash
# running docker-compose
$ docker-compose up
```

```bash
# Setup database
$ docker exec -it friends-api_web_1 bin/rails db:setup
```

```bash
# Running rails migrations
$ docker exec -it <friends-api_web_1> bin/rails db:migrate
```
