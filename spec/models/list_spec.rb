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

  describe '#percent_complete' do
    let(:list) { List.create!(title: 'Tasks List') }

    context 'when there are no tasks' do
      it 'returns 0' do
        expect(list.percent_complete).to eq(0)
      end
    end

    context 'when all tasks are completed' do
      before do
        3.times { list.tasks.create!(title: 'Task', completed: true) }
      end

      it 'returns 100' do
        expect(list.percent_complete).to eq(100)
      end
    end

    context 'when some tasks are completed' do
      before do
        2.times { list.tasks.create!(title: 'Completed Task', completed: true) }
        list.tasks.create!(title: 'Incomplete Task', completed: false)
      end

      it 'returns the correct percentage' do
        expect(list.percent_complete).to eq(67)
      end
    end

    context 'when no tasks are completed' do
      before do
        3.times { list.tasks.create!(title: 'Incomplete Task', completed: false) }
      end

      it 'returns 0' do
        expect(list.percent_complete).to eq(0)
      end
    end
  end
end
