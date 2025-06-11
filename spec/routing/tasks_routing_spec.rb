require "rails_helper"

RSpec.describe TasksController, type: :routing do
  let(:list_id) { "1" }
  let(:task_id) { "1" }

  describe "Task routes" do
    it "routes to #index" do
      expect(get: "/lists/#{list_id}/tasks").to route_to("tasks#index", list_id: list_id)
    end

    it "routes to #new" do
      expect(get: "/lists/#{list_id}/tasks/new").to route_to("tasks#new", list_id: list_id)
    end

    it "routes to #show" do
      expect(get: "/lists/#{list_id}/tasks/#{task_id}").to route_to("tasks#show", list_id: list_id, id: task_id)
    end

    it "routes to #edit" do
      expect(get: "/lists/#{list_id}/tasks/#{task_id}/edit").to route_to("tasks#edit", list_id: list_id, id: task_id)
    end

    it "routes to #create" do
      expect(post: "/lists/#{list_id}/tasks").to route_to("tasks#create", list_id: list_id)
    end

    it "routes to #update via PUT" do
      expect(put: "/lists/#{list_id}/tasks/#{task_id}").to route_to("tasks#update", list_id: list_id, id: task_id)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/lists/#{list_id}/tasks/#{task_id}").to route_to("tasks#update", list_id: list_id, id: task_id)
    end

    it "routes to #destroy" do
      expect(delete: "/lists/#{list_id}/tasks/#{task_id}").to route_to("tasks#destroy", list_id: list_id, id: task_id)
    end
  end
end