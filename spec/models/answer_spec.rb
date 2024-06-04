require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:user) { create(:user) }
  let!(:mystery) { create(:mystery) }
  let!(:genre) { create(:genre) }
  let(:image_path) { Rails.root.join('spec', 'fixtures', 'aa.png') }
  let(:image) { fixture_file_upload(image_path, 'image/png') }
  let(:mystery) { build(:mystery, user: user, genre: genre, image: image ) }

  describe 'バリデーションチェック' do
    let(:answer) { build(:answer, user: user, mystery: mystery) }
    it '設定したバリエーションが機能しているか' do
      expect(answer).to be_valid
      expect(answer.errors).to be_empty
    end
  end
end
