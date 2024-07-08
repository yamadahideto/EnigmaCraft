require 'rails_helper'

RSpec.describe "Mysteries", type: :system do
  # include LoginMacros
  let(:user) { create(:user) } 

  describe 'ログイン前' do
    it 'トップページにリダイレクトされる' do
      visit new_mystery_path
      expect(current_path).to eq root_path
    end

    it 'ログインができる' do
      login(user)
      sleep(15)
      expect(current_path).to eq mysteries_path
    end
  end

end
