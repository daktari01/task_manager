require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:list) { List.create!(title: 'Test List') }
  let(:valid_attributes) do
    {
      title: 'Test Task',
      completed: false,
      list: list
    }
  end

  it 'is valid with valid attributes' do
    task = Task.new(valid_attributes)
    expect(task).to be_valid
  end

  it 'is not valid without a title' do
    task = Task.new(valid_attributes.merge(title: ''))
    expect(task).not_to be_valid
    expect(task.errors[:title]).to include("can't be blank")
  end

  it 'is not valid with a title longer than 255 characters' do
    task = Task.new(valid_attributes.merge(title: 'a' * 256))
    expect(task).not_to be_valid
    expect(task.errors[:title]).to include('is too long (maximum is 255 characters)')
  end

  it 'is not valid without a list' do
    task = Task.new(valid_attributes.merge(list: nil))
    expect(task).not_to be_valid
    expect(task.errors[:list]).to include('must exist')
  end

  it 'belongs to a list' do
    task = Task.reflect_on_association(:list)
    expect(task.macro).to eq(:belongs_to)
  end

  describe 'scopes' do
    let!(:completed_task) { Task.create!(title: 'Completed Task', completed: true, list: list) }
    let!(:pending_task) { Task.create!(title: 'Pending Task', completed: false, list: list) }

    it 'returns completed tasks' do
      expect(Task.completed).to include(completed_task)
      expect(Task.completed).not_to include(pending_task)
    end

    it 'returns pending tasks' do
      expect(Task.pending).to include(pending_task)
      expect(Task.pending).not_to include(completed_task)
    end
  end

  describe '#toggle!' do
    let(:task) { Task.create!(valid_attributes) }

    it 'toggles completed from false to true' do
      expect {
        task.toggle!(:completed)
      }.to change { task.reload.completed }.from(false).to(true)
    end

    it 'toggles completed from true to false' do
      task.update!(completed: true)
      expect {
        task.toggle!(:completed)
      }.to change { task.reload.completed }.from(true).to(false)
    end
  end
end