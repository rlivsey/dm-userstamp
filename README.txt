= dm-userstamp

DataMapper plugin which adds "magic" to created_by_id, updated_by_id fields

Assumes a model called User and a class attribute of current_user
Just need to add created_by_id and/or updated_by_id Integer fields to the model

Eg:

class User
  include DataMapper::Resource
  
  cattr_accessor :current_user
  ...
end

class Monkey
  include DataMapper::Resource
  
  property :created_by_id, Integer
  property :updated_by_id, Integer      
  ...
end

== Install

sudo gem install dm-userstamp

== Thanks

Code based on:
 * AR userstamp plugin - http://github.com/ctran/userstamp/tree/master
 * DM timestamps plugin - http://github.com/sam/dm-more/tree/master/dm-timestamps
