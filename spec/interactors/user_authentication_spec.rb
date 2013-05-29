require 'spec_helper'


describe UserAuthentication do

  describe '#authenticate' do

    before(:each) { Fabricate(:user) }

    context 'provided with valid credentials' do
      let(:credentials) do
        {
          email:    'john@example.com',
          password: 'password'
        }
      end

      it 'Returns the authenticated user' do
        rm = UserAuthentication.new.authenticate(credentials[:email], credentials[:password])

        rm.success?.should be_true
        rm.user.instance_of?(User).should be_true
        rm.user.email.should == credentials[:email]
      end

    end

    context 'provided with invalid credentials' do
      let(:credentials) do
        {
          email:    'john@example.com',
          password: 'wrongpassword'
        }
      end

      it 'returns errors' do
        response = UserAuthentication.new.authenticate(credentials[:email], credentials[:password])

        response.errors.should_not be_nil
        response.success?.should == false
      end

    end

  end

end
