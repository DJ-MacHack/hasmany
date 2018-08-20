class TrainingsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  helper_method :sort_column, :sort_direction
  @ans = []

  def index
    @trainings = Training.paginate(page: params[:page])
  end

  def new
    @training = Training.new
  end

  def show
    @training = Training.find(params[:id])
  end

  def search
#    @training = Training.find(params[:id])
  end

  def insert_line(line)
    self.line.clear
    self.line << line
  end

  def insert_worker(worker)
    self.worker.clear
    self.worker << worker
  end

  def create
    @training = Training.new(training_params)
    if @training.save
      flash[:info] = "Training hinzugefügt."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    Training.find(params[:id]).destroy
    flash[:success] = "Training gelöscht"
    redirect_to trainings_url
  end

  def edit
    @training = Training.find(params[:id])
  end

  def update
    @training = Training.find(params[:id])
    if @training.update_attributes(training_params)
      flash[:success] = "Training updated"
      redirect_to training_path
    else
      render 'edit'
    end
  end

  def add_worker_tm
    @workers = Worker.order("#{sort_column} #{sort_direction}")
    @workerids = []
  end

  def addworkers_tm
    @trainings = Training.all
    @training = params[:training_id]
    @tm = Trainingsmembership.new(tm_params)
    if @tm.save
      flash[:success] = "Mitarbeiter eingefügt"
      redirect_to root_path
    else
      @tm.errors
      render 'add_worker_tm'
    end
  end


  private
  def sortable_columns
    ["name", "line_ids", "shift_id", "position_id"]
  end

  def sort_column
    Worker.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def training_params
    params.require(:training).permit(:name, :shortname, :clockcycle, :cc, :jcms, :status, :line_ids => [], :worker_ids => [])
  end

  def tm_params
    params.require(:trainingsmembership).permit(:training_id, :duration, :date, :attachement, :comment, :worker_id)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

