require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  let(:task) {
    Task.create!(
      title: "MyString",
      description: "MyText",
      completed: false,
      list: nil
    )
  }

  before(:each) do
    assign(:task, task)
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(task), "post" do

      assert_select "input[name=?]", "task[title]"

      assert_select "textarea[name=?]", "task[description]"

      assert_select "input[name=?]", "task[completed]"

      assert_select "input[name=?]", "task[list_id]"
    end
  end
end
