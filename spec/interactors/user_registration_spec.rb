require 'spec_helper'


describe UserRegistration do

  describe '#register' do

    context 'Valid user information' do
      let(:user_info) do
        {
          username:               'John',
          email:                  'john@example.com',
          password:               'password',
          password_confirmation:  'password'
        }
      end

      it 'creates a new user' do
        response = UserRegistration.new.register(user_info)

        response.success?.should == true
        response.user.persisted?.should == true
      end

    end

    context 'Invalid user information' do
      let(:user_info) do
        {
          username:               'John',
          email:                  'john@example.com',
          password:               'password',
          password_confirmation:  'otherpassword'
        }
      end

      it 'returns errors' do
        response = UserRegistration.new.register(user_info)

        response.errors.should_not be_nil
        response.success?.should == false
        response.user.persisted?.should == false
      end

    end

  end

end
