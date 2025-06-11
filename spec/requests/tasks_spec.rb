require 'rails_helper'

RSpec.describe "/lists/:list_id/tasks", type: :request do
  let!(:list) { List.create!(title: 'Test List') }
  let(:valid_attributes) {
    { title: 'Test Task', completed: false }
  }

  let(:invalid_attributes) {
    { title: '', completed: false }
  }

  describe "GET /index" do
    it "renders a successful response" do
      get list_tasks_path(list)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_list_task_path(list)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      task = list.tasks.create!(valid_attributes)
      get edit_list_task_path(list, task)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task for the list" do
        expect {
          post list_tasks_path(list), params: { task: valid_attributes }
        }.to change(list.tasks, :count).by(1)
      end

      it "redirects to the created task's show page" do
        post list_tasks_path(list), params: { task: valid_attributes }
        expect(response).to redirect_to(list_task_path(list, Task.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post list_tasks_path(list), params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a response with 422 status" do
        post list_tasks_path(list), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    let!(:task) { list.tasks.create!(valid_attributes) }
    
    context "with valid parameters" do
      let(:new_attributes) {
        { title: 'Updated Task Title', completed: true }
      }

      it "updates the requested task" do
        patch list_task_path(list, task), params: { task: new_attributes }
        task.reload
        expect(task.title).to eq('Updated Task Title')
        expect(task.completed).to be_truthy
      end

      it "redirects to the task's show page" do
        patch list_task_path(list, task), params: { task: new_attributes }
        expect(response).to redirect_to(list_task_path(list, task))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status" do
        patch list_task_path(list, task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = list.tasks.create!(valid_attributes)
      expect {
        delete list_task_path(list, task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the list's tasks index page" do
      task = list.tasks.create!(valid_attributes)
      delete list_task_path(list, task)
      expect(response).to redirect_to(list_tasks_path(list))
    end
  end

  describe "PATCH /update" do
    let!(:task) { list.tasks.create!(title: 'Test Task', completed: false) }

    it "updates the task's completed status" do
      expect {
        patch list_task_path(list, task), params: { task: { completed: true } }
      }.to change { task.reload.completed }.from(false).to(true)

      expect {
        patch list_task_path(list, task), params: { task: { completed: false } }
      }.to change { task.reload.completed }.from(true).to(false)
    end
  end
end