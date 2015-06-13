# active_model_secure_token

Provides an easy way to generate uniques random tokens for any ActiveModel. **SecureRandom::base58** is used to generate the 24-character unique tokens, so collisions are highly unlikely.

**Note** If you're worried about possible collissions, there's a way to generate a race condition in the database in the same way that [validates_uniqueness_of](http://api.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html) can. You're encouraged to add an unique index in the database to deal

## Installation

Add this line to your application's Gemfile:

    gem 'active_model_secure_token'

And then run:

    $ bundle

Or install it yourself as:

    $ gem install active_model_secure_token

This gem does not depend on ActiveRecord, only on ActiveModel. It works fine with ActiveRecord and Mongoid. You will need to `include ActiveModel::SecureToken` in your model/document before you can use it.

## Setting your ActiveRecord model

The first step is to generate a migration in order to add the token key field.

```ruby
rails g migration AddTokenToUsers token:string
=>
   invoke  active_record
   create    db/migrate/20150424010931_add_token_to_users.rb
```

Then run `rake db:migrate` in order to update users table in the database. The next step is to add `has_secure_token`
 to the model:
```ruby
# Schema: User(token:string, auth_token:string)
class User < ActiveRecord::Base
  include ActiveModel::SecureToken
  has_secure_token
end

user = User.new
user.save
user.token # => "pX27zsMN2ViQKta1bGfLmVJE"
user.regenerate_token # => true
```

To use a custom column to store the token key field you can specify the column_name option. See example above (e.g: auth_token):

```ruby
# Schema: User(token:string, auth_token:string)
class User < ActiveRecord::Base
  include ActiveModel::SecureToken
  has_secure_token :auth_token
end

user = User.new
user.save
user.auth_token # => "pX27zsMN2ViQKta1bGfLmVJE"
user.regenerate_auth_token # => true
```

## Setting your Mongoid document

Add the field, include this gem and enable it like so:

```ruby
class User
  include Mongoid::Document
  include ActiveModel::SecureToken
  field :token, type: String
  has_secure_token
end
```

The Mongoid document has all the same methods as the ActiveRecord model.

## Running tests

Running

```shell
$ rake test
```

Should return

```shell
8 runs, 14 assertions, 0 failures, 0 errors, 0 skips
```
