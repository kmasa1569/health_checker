class ChecklistsController < ApplicationController
  def index
    @checklists = current_user.checklists
  end

  def show
    @checklist = current_user.checklists.find(params[:id])
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
    @checklist = current_user.checklists.find(params[:id])
  end

  def update
    checklist = current_user.checklists.find(params[:id])
    checklist.update!(checklist_params)
    redirect_to checklists_url, notice: "#{checklist.date}を更新しました。"
  end

  def destroy
    checklist = current_user.checklists.find(params[:id])
    checklist.destroy
    redirect_to checklists_url, notice: "#{checklist.date}を削除しました"
  end

  private
    def checklist_params
      params.require(:checklist).permit(:date, :bt, :hr, :sbp, :dbp, :wt, :memo)
    end

end
