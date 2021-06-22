## Assignment Summary

The focus of this assignment is to see how you would build an API for a web application using Ruby on Rails.

This assignment will cover the signup, login endpoints as well as an additional resource users and friends that can be accessed if you are logged in.

To determine whether a request is from a logged in user or not, we'll be using Json Web Tokens (https://jwt.io/). The frontend will be sending requests with the JWT in the Authorization header (Authorization: Bearer <token>). Feel free to use the ruby-jwt gem (or another JWT implementation).

For the database, please use PostgreSQL.

Also feel free to use whatever open source packages you're comfortable with, but be sure to implement the database models and relations logic yourself.

## API Specifications

### Signup and Login

#### POST /signup
Endpoint to create a user in the database. The payload should follow this structure:
```json
{
  "user": {
    "email": "test@axiomzen.co",
    "name": "Alex Zimmerman",
    "password": "axiomzen"
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
    "email": "test@axiomzen.co",
    "password": "axiomzen"
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
      "name": "Alex Zimmerman",
      "email": "test@axiomzen.co"
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
      "name": "Alex Zimmerman",
      "email": "test@axiomzen.co"
    }
  ]
}
```
