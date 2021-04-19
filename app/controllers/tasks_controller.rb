class TasksController < ApplicationController
  before_action :authenticate_user!
  after_action :save_my_previous_url, only: [:new, :edit]

  def save_my_previous_url
    session[:previous_url] = URI(request.referrer || '').path
  end

  def index
    @tasks = current_user.tasks.where(:completed => false).order("due_date ASC")
  end
  def show
    @task = Task.all.find(params[:id])
  end
  def new
    @task = current_user.tasks.build
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task successfully created"
    else
      render :new
    end
  end

  def edit
    @task = Task.all.find(params[:id])
  end
  def update
    @task = Task.all.find(params[:id])
    if @task.update(task_params)
      redirect_to session[:previous_url], notice: "Task updated"
    else
      render :edit
    end
  end
  def destroy
    @task = Task.all.find(params[:id])
    @task.destroy
    redirect_to session[:previous_url], notice: "Task deleted"
  end

  def complete
    @task = Task.all.find(params[:task_id])
    if @task.completed?
      @task.update_attribute(:completion_date, "")
      @task.update_attribute(:completed, false)
      redirect_to request.referrer, notice: "Task marked as incomplete"
    else
      @task.update_attribute(:completion_date, Time.now)
      @task.update_attribute(:completed, true)
      redirect_to request.referrer, notice: "Task marked as complete"
    end
  end

  def today
    @today = current_user.tasks.where("due_date <= ? AND completed = ?", Date.current, false).order("due_date ASC")
  end

  def completed_tasks
    @completed = current_user.tasks.where(:completed => true).order("due_date ASC")
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :category_id, :due_date)
  end
end
