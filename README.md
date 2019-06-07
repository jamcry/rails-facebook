# Rails Facebook

Rails Facebook is a facebook clone app developed with Ruby on Rails. It is still in progress and It will have most of the basic functionality of the real Facebook.

It is the [final project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project) of the Odin Project's Ruby on Rails course.

## Installation

1. Install neccessary gems with bundle:

```bash
bundle install
```

2. Create databases:

```bash
rails db:migrate
```

3. Run the app:

```bash
rails server
```

If you get database related errors, check Database Configuration section below.

### Database Configuration

This app uses PostgreSQL database. If you are getting NoDatabaseError or a similar error related to database, you should probably create a role in the database for your user.

1. Change to superuser mode as postgres user that is created automatically:

```bash
$ sudo su - postgres
```

2. Start PostgreSQL server:

```
postgres@<device-name>: psql
```

3. Create new role for your user (**it must have the same name as your login name**) and check it:

```
postgres=# CREATE ROLE <username> WITH CREATEDB LOGIN;
CREATE ROLE
postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 <username>| Create DB                                                  | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

## Contributing

This is an open-source project, so pull requests are more than welcome. For major changes, please open an issue first to discuss what you would like to change.
