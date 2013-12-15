class TasksController < ApplicationController
  before_action :set_task, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_task

  def index
    task = Task.create!
    redirect_to task
  end

  def show
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def invalid_task
    redirect_to tasks_url
  end
end
