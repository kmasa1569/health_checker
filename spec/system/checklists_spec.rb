require 'rails_helper'

describe 'checklist管理', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'UserA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'UserB', email: 'b@example.com') }
  let!(:checklist_a) { FactoryBot.create(:checklist, date: '2021-04-25', user: user_a) } # UserAの1日date作成

  before do
    visit root_path
    fill_in 'Email',	with: login_user.email
    fill_in 'Password',	with: login_user.password
    click_button 'ログイン'
  end

  shared_examples_for 'UserAのチェックリストが表示される' do
    it { expect(page).to have_content '2021-04-25' }
  end

  describe 'index表示機能' do
    context 'UserAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'UserAのチェックリストが表示される'
    end

    context 'UserBがログインしているとき' do
      let(:login_user) { user_b }

      it 'UserAが作成したデータが表示されない' do
        expect(page).not_to have_content '2021-04-25'
      end
    end
  end

  describe 'show表示機能' do
    context 'UserAがログインしているとき' do
      let(:login_user) { user_a }
      before do
        visit user_checklists_path(checklist_a)
      end
      it_behaves_like 'UserAのチェックリストが表示される'
    end
  end

  # describe 'new機能' do
    
  # end
  
end
