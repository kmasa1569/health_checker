class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  before_action :set_checklist_user
  before_action :browsing_authority

  def index
    @q = @user.checklists.ransack(params[:q])
    @checklists = @q.result.order(date: :desc).paginate(page: params[:page], per_page: 14)

    @graph = Checklist.where(user_id: params[:user_id]).limit(14)
    bt = @graph.group_by_day(:date, range: 2.weeks.ago.midnight..Time.now, series: false).sum(:bt)
    hr = @graph.group_by_day(:date, range: 2.weeks.ago.midnight..Time.now, series: false).sum(:hr)
    sbp = @graph.group_by_day(:date, range: 2.weeks.ago.midnight..Time.now, series: false).sum(:sbp)
    dbp = @graph.group_by_day(:date, range: 2.weeks.ago.midnight..Time.now, series: false).sum(:dbp)
    wt = @graph.group_by_day(:date, range: 2.weeks.ago.midnight..Time.now, series: false).sum(:wt)
    @data = [
      { name: "体温", data: bt },
      { name: "心拍数", data: hr },
      { name: "収縮期血圧", data: sbp, color: "green" },
      { name: "拡張期血圧", data: dbp, color: "green" },
      { name: "体重", data: wt, color: "orange" }
    ]

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
      redirect_to user_checklists_url, notice: '本日の値を入力しました。'
    else
      flash.now[:alert] = '空欄がある、もしくは登録済みの日付のようです。'
      render :new
    end
  end

  def edit
  end

  def update
    @checklist.update!(checklist_params)
    redirect_to user_checklists_url, notice: "#{@checklist.date}を更新しました。"
  end

  def destroy
    @checklist.destroy
    redirect_to user_checklists_url, notice: "#{@checklist.date}を削除しました"
  end

  private
    def checklist_params
      params.require(:checklist).permit(:date, :bt, :hr, :sbp, :dbp, :wt, :memo, :user_id)
    end

    def set_checklist
      @checklist = current_user.checklists.find(params[:id])
    end

    def set_checklist_user
      @user = User.find(params[:user_id])
    end

    def browsing_authority
      unless current_user.admin || @user == current_user
        redirect_to root_url
      end
    end
end
