require 'spec_helper'

describe Article do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:username) }

  FakeUser = Struct.new(:id, :username)

  describe '#user=' do

    let(:user) { FakeUser.new(3, 'dauser') }

    it 'sets the value for user_id and username' do
      article      = Article.new
      article.user = user
      article.user_id.should == user.id
      article.username.should == user.username
    end
  end

end
