
require 'users'
# require './lib/database_connection'
require 'database_helpers'
require 'bcrypt'

describe Users do

  describe ".create" do
   it 'allows you to make an account' do
    test_user = Users.create(name: 'Katy', email: 'test@example.com', password: 'password123')

    persisted_data = persisted_data(table: :users, id: test_user.user_id)

    expect(test_user).to be_a Users
    expect(test_user.email).to eq 'test@example.com'
    expect(test_user.name).to eq 'Katy'
  end

   it 'hashes the password using Bcrypt' do
    expect(BCrypt::Password).to receive(:create).with('password123')

    Users.create(name: 'Katy', email: 'test@example.com', password: 'password123')
  end

end

describe '.authenticate' do
  it 'returns a user given a correct email and password, if they exist' do
    user = Users.create(name: 'Katy', email: 'test@example.com', password: 'password123')
    auth_user = Users.authenticate(email: 'test@example.com', password: 'password123')

    expect(auth_user.user_id).to eq user.user_id
  end

  it 'returns nil given an uncorrect email address' do
    user = Users.create(name: 'Katy', email: 'test@example.com', password: 'password123')

    expect(Users.authenticate(email: 'notherightemail@me.com', password: 'password123')).to be_nil
  end

  it 'returns nil given an incorrect password' do
    user = Users.create(name: 'Katy', email: 'test@example.com', password: 'password')

    expect(Users.authenticate(email: 'test@example.com', password: 'incorrectpassword' )).to be_nil
  end

end


  describe '.find' do
    it 'finds a user by ID' do
      user = Users.create(name: 'Katy', email: 'test@example.com', password: 'password')
      result = Users.find(user_id: user.user_id)

      expect(result.user_id).to eq user.user_id
      expect(result.email).to eq user.email
      expect(result.name).to eq user.name
    end

    it 'returns nil if there is no ID given' do
      expect(Users.find(user_id: nil)).to eq nil
    end


  end
end
