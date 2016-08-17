require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:grove) }
  it { should belong_to(:school) }

  describe '#first_name' do
    describe 'user with name field' do
      it 'returns first name if there is a space in the name field' do
        user = create(:user)
        expect(user.first_name).to eq "JJ"
      end

      it 'returns fullname if there is no space in the name field' do
        user = create(:user, name: "Cher")
        expect(user.first_name).to eq "Cher"
      end
    end

    describe 'user without name field' do
      it 'returns email' do
        user = create(:user, name: nil)
        expect(user.first_name).to eq user.email
      end
    end
  end

  describe '.from_omniauth' do
    let(:package) { double(:package, email: 'student@example.com',
                                     image: 'foo.jpg',
                                     token: 'abc123',
                                     refresh_token: '123abc',
                                     expires_at: 1.year.from_now)}

    it 'sets the refresh token on the user' do
      user = create(:user, email: 'student@example.com')
      expect { User.from_omniauth(package) }.to change {
        User.find(user.id).refresh_token
      }.from(nil).to("123abc")
    end
  end
end
