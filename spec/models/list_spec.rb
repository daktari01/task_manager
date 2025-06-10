require 'rails_helper'

RSpec.describe List, type: :model do
  let(:valid_attributes) {
    { title: 'Test List', description: 'This is a test list' }
  }

  it 'is valid with valid attributes' do
    list = List.new(valid_attributes)
    expect(list).to be_valid
  end

  it 'is not valid without a title' do
    list = List.new(valid_attributes.merge(title: nil))
    expect(list).not_to be_valid
    expect(list.errors[:title]).to include("can't be blank")
  end

  it 'is valid without a description' do
    list = List.new(valid_attributes.merge(description: nil))
    expect(list).to be_valid
  end

  describe 'validations' do
    it 'validates presence of title' do
      list = List.new(description: 'Only description')
      expect(list).not_to be_valid
      expect(list.errors[:title]).to include("can't be blank")
    end

    it 'validates length of title' do
      list = List.new(title: 'a' * 256, description: 'Long title')
      expect(list).not_to be_valid
      expect(list.errors[:title]).to include('is too long (maximum is 255 characters)')
    end
  end

  describe 'scopes' do
    let!(:list1) { List.create!(title: 'First List', description: 'First') }
    let!(:list2) { List.create!(title: 'Second List', description: 'Second') }

    it 'orders lists by most recently created first' do
      expect(List.ordered).to eq([list2, list1])
    end
  end
end
