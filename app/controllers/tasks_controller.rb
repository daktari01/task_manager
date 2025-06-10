class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = @list.tasks
  end

  def show
  end

  def new
    @task = @list.tasks.build
  end

  def edit
  end

  def create
    @task = @list.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to [@list, @task], notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to [@list, @task], notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy!
    respond_to do |format|
      format.html { redirect_to list_path(@list), notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id]) if params[:list_id].present?
  end

  def set_task
    @task = @list ? @list.tasks.find(params[:id]) : Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :list_id)
  end
end