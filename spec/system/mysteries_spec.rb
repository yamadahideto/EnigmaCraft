require 'rails_helper'

RSpec.describe "Mysteries", type: :system do

  describe 'ログイン前' do
    it 'トップページにリダイレクトされる' do
      visit mysteries_path
      expect{ visit new_mystery_path }.to change{
        current_path
      }.from(mysteries_path).to(root_path)
      expect(page).to have_content('ログインしてください')
    end
  end
end
