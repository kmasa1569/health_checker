class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  def index
    @user = User.find_by(id: checklists.user_id)
    @q = @user.checklists.ransack(params[:q])
    @checklists = @q.result.order(date: :desc).paginate(page: params[:page], per_page: 14)

    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @checklists.generate_csv, filename: "checklists-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    # end
  end

  def show
  end

  def new
    @checklist = Checklist.new
  end

  def create
    @checklist = current_user.checklists.new(checklist_params)
    if @checklist.save
      redirect_to checklists_url, notice: '本日の値を入力しました。'
    else
      flash.now[:alert] = '空欄がある、もしくは登録済みの日付のようです。'
      render :new
    end
  end

  def edit
  end

  def update
    @checklist.update!(checklist_params)
    redirect_to checklists_url, notice: "#{@checklist.date}を更新しました。"
  end

  def destroy
    @checklist.destroy
    redirect_to checklists_url, notice: "#{@checklist.date}を削除しました"
  end

  private
    def checklist_params
      params.require(:checklist).permit(:date, :bt, :hr, :sbp, :dbp, :wt, :memo)
    end

    def set_checklist
      @checklist = current_user.checklists.find(params[:id])
    end

end
