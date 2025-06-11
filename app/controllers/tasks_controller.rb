class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = @list.tasks
    @filter = params[:filter] || 'all'
    
    @tasks = case @filter
             when 'completed'
               @tasks.completed
             when 'pending'
               @tasks.pending
             else
               @tasks
             end
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
        format.html { redirect_to [@list, @task], flash: { success: 'Task was created successfully' } }
        format.json { render :show, status: :created, location: @task }
      else
        format.html do
          flash.now[:alert] = "Could not create task: #{@task.errors.full_messages.join(', ')}"
          render :new, status: :unprocessable_entity 
        end
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to [@list, @task], flash: { success: 'Task was updated successfully' } }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html do
          flash.now[:alert] = "Could not update task: #{@task.errors.full_messages.join(', ')}"
          render :edit, status: :unprocessable_entity 
        end
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy!
    respond_to do |format|
      format.html { redirect_to list_tasks_path(@list), flash: { success: 'Task was deleted successfully' } }
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