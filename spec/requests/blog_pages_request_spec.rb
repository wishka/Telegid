require 'rails_helper'

RSpec.describe "BlogPages", type: :request do

  describe 'Root path' do
    it 'should contain menu items' do
      menu_items = ['Искать','Профиль', 'Мои объявления', 'Избранное', 'Сообщения', 'Полезные статьи', 'Ожидают оплаты', 'Отзывы', 'Поиск/Создать']
      get root_path
      expect(response).to be_ok
      menu_items.map do |item|
        expect(response.body).to include(item)
      end
    end

    it "should get home" do
      get root_path
      expect(response).to be_ok
    end
  end
end
