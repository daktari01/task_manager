class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]

  def index
    @lists = List.includes(tasks: :list).references(:tasks)
  end

  def show
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, flash: { success: 'List was created successfully' } }
        format.json { render :show, status: :created, location: @list }
      else
        format.html do 
          flash.now[:alert] = "Could not create list: #{@list.errors.full_messages.join(', ')}"
          render :new, status: :unprocessable_entity 
        end
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, flash: { success: 'List was updated successfully' } }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html do
          flash.now[:alert] = "Could not update list: #{@list.errors.full_messages.join(', ')}"
          render :edit, status: :unprocessable_entity 
        end
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    respond_to do |format|
      if @list.destroy
        format.html { redirect_to lists_path, status: :see_other, flash: { success: 'List was deleted successfully' } }
        format.json { head :no_content }
      else
        format.html { redirect_to lists_path, alert: @list.errors.full_messages.join(', ') }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:title, :description)
    end
end
