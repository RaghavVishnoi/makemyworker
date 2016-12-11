# MakeMyWorker App

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

## Glossary

Link: A friend of a friend.

## API

Every request to the API must have the following header:

```
Content-Type: application/json
Accept: application/vnd.makemyworker+json; version=1
Authorization: Token token=40c7b73fa6a9f77f174f634148ec602a075dbd91
```

The token is the user's token (not their Facebook token), which is returned from
a successful user creation request.

In the documentation, `"1CAA..."` is used as a placeholder for a (very long)
Facebook token. The API will return the full token.

### POST /api/users

**Does not require an authentication header**

Creates a user.

Required parameters in JSON format:

```json
{
  "user": {
    "facebook_user_token": "CAAUQ..."
  }
}
```

When unsuccessful, returns a 422 status code with JSON like:

```json
{
  "errors": ["User could not be created"]
}
```

When successful, returns a 201 response with JSON exactly like a GET request to
`/api/users/:id`.

