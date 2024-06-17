require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '設定したバリデーションが機能しているか' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
    it '名前が未入力の場合にバリデーションが効いているか' do
      user = build(:user, name: '')
      expect(user).to be_invalid
    end
    it 'emailが未入力の場合にバリデーションが効いているか' do
      user = build(:user, email: '')
      expect(user).to be_invalid
    end
    it 'passwordが未入力の場合にバリデーションが効いているか' do
      user = build(:user, password: '')
      expect(user).to be_invalid
    end
  end
end
