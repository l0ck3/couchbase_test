require 'spec_helper'


describe User do
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it { should validate_presence_of(:email) }
  #it { should validate_uniqueness_of(:email) } # Doesn't work ! TODO : Fix it

  it { should validate_presence_of(:password) }

  it { should validate_presence_of(:password_confirmation) }
end
