require 'rails_helper'

RSpec.describe Mystery, type: :model do
    let!(:user) { create(:user) }
    let!(:genre) { create(:genre) }
    let(:image_path) { Rails.root.join('spec', 'fixtures', 'aa.png') }
    let(:image) { fixture_file_upload(image_path, 'image/png') }

  describe 'バリデーションチェック' do
    context '必須項目がすべて入力済み' do
      let(:mystery) { build(:mystery, user: user, genre: genre, image: image ) }
      it '設定したバリデーションが機能しているか' do
        expect(mystery).to be_valid
        expect(mystery.errors).to be_empty
      end
    end

    context 'titleが未入力の場合にバリデーションが有効か' do
      let(:mystery) { build(:mystery, title: '', user: user, genre: genre, image: image ) }
      it '投稿が失敗する' do
        expect(mystery).to be_invalid
        expect(mystery.errors[:title]).to include('を入力してください')
      end
    end

    context 'contentが未入力の場合にバリデーションが有効か' do
      let(:mystery) { build(:mystery, content: '', user: user, genre: genre, image: image ) }
      it '投稿が失敗する' do
        expect(mystery).to be_invalid
        expect(mystery.errors[:content]).to include('を入力してください')
      end
    end

    context 'correct_answerが未入力の場合にバリデーションが有効か' do
      let(:mystery) { build(:mystery, correct_answer: '', user: user, genre: genre, image: image ) }
      it '投稿が失敗する' do
        expect(mystery).to be_invalid
        expect(mystery.errors[:correct_answer]).to include('を入力してください')
      end
    end

    context 'genreが未入力の場合にバリデーションが有効か' do
      let(:mystery) { build(:mystery, user: user, genre: nil, image: image ) }
      it '投稿が失敗する' do
        expect(mystery).to be_invalid
        expect(mystery.errors[:genre]).to include('を入力してください')
      end
    end

    context 'userが未入力' do
      let(:mystery) { build(:mystery, user: nil, genre: genre, image: image ) }
      it '投稿が失敗する' do
        expect(mystery).to be_invalid
        expect(mystery.errors[:user]).to include('を入力してください')
      end
    end
  end
end

