require "rails_helper"

RSpec.describe ListsController, type: :routing do
  let(:list_id) { "1" }

  describe "List routes" do
    it "routes to #index" do
      expect(get: "/lists").to route_to("lists#index")
    end

    it "routes to #new" do
      expect(get: "/lists/new").to route_to("lists#new")
    end

    it "routes to #show" do
      expect(get: "/lists/#{list_id}").to route_to("lists#show", id: list_id)
    end

    it "routes to #edit" do
      expect(get: "/lists/#{list_id}/edit").to route_to("lists#edit", id: list_id)
    end

    it "routes to #create" do
      expect(post: "/lists").to route_to("lists#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/lists/#{list_id}").to route_to("lists#update", id: list_id)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/lists/#{list_id}").to route_to("lists#update", id: list_id)
    end

    it "routes to #destroy" do
      expect(delete: "/lists/#{list_id}").to route_to("lists#destroy", id: list_id)
    end
  end

  describe "nested tasks routes" do
    let(:task_id) { "1" }


    it "routes to tasks#index" do
      expect(get: "/lists/#{list_id}/tasks").to route_to("tasks#index", list_id: list_id)
    end

    it "routes to tasks#new" do
      expect(get: "/lists/#{list_id}/tasks/new").to route_to("tasks#new", list_id: list_id)
    end

    it "routes to tasks#create" do
      expect(post: "/lists/#{list_id}/tasks").to route_to("tasks#create", list_id: list_id)
    end
  end
end