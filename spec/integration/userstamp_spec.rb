require 'pathname'
require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'
require 'pp'

return unless HAS_SQLITE3 || HAS_MYSQL || HAS_POSTGRES

describe 'DataMapper::Userstamp' do
  before :all do
    class User
      include DataMapper::Resource
      include DataMapper::Userstamp::Stamper

      property :id, Integer, :serial => true
      property :name, String

      auto_migrate!(:default)
    end
    
    class Monkey
      include DataMapper::Resource

      property :id, Integer, :serial => true
      property :name, String
      property :created_by_id, Integer
      property :updated_by_id, Integer      

      auto_migrate!(:default)
    end
  
  end
  
  before :each do
    @user = User.create(:name => 'Bob')
    User.current_user = @user
  end
  
  after do
   DataMapper.repository(:default).adapter.execute('DELETE from users');
   DataMapper.repository(:default).adapter.execute('DELETE from monkeys');   
  end  
  
  it "should not set created_by_id if there is no current user" do
    DataMapper.repository(:default) do
      User.current_user = nil
      monkey = Monkey.new(:name => 'Eric')
      monkey.save
      monkey.created_by_id.should be_nil
    end
  end
    
    it "should not set updated_by_id if there is no current user" do
      DataMapper.repository(:default) do
        User.current_user = nil
        monkey = Monkey.new(:name => 'Eric')
        monkey.save
        monkey.updated_by_id.should be_nil
      end
    end
    
    it "should not set created_by_id if already set" do
      DataMapper.repository(:default) do
        monkey = Monkey.new(:name => 'Eric')
        monkey.created_by_id = 5
        monkey.save
        monkey.created_by_id.should == 5
        monkey.created_by_id.should be_a_kind_of(Integer)
      end
    end
    
    it "should set created_by_id on creation" do
      DataMapper.repository(:default) do
        monkey = Monkey.new(:name => 'Clyde')
        monkey.created_by_id.should be_nil
        monkey.save
        monkey.created_by_id.should be_a_kind_of(Integer)
        monkey.created_by_id.should == User.current_user.id
      end
    end
    
    it "should not alter created_by_id on model updates" do
      DataMapper.repository(:default) do
        monkey = Monkey.new(:name => 'Chump')
        monkey.created_by_id.should be_nil
        monkey.save
        original_created_by_id = monkey.created_by_id
        monkey.name = 'Wilma'
        monkey.save
        monkey.created_by_id.should eql(original_created_by_id)
      end
    end
    
    it "should set updated_by_id on creation and on update" do
      DataMapper.repository(:default) do
        monkey = Monkey.new(:name => 'Johnny')
        monkey.updated_by_id.should be_nil
        monkey.save
        
        monkey.updated_by_id.should be_a_kind_of(Integer)
        monkey.updated_by_id.should == User.current_user.id
        
        original_updated_by_id = monkey.updated_by_id
    
        User.current_user = @user2 = User.create(:name => 'Fred')  
    
        monkey.name = 'Roger'
        monkey.save
        monkey.updated_by_id.should == @user2.id
      end
    end
  
end
