class ChecklistsController < ApplicationController
  def index
    @checklists = Checklist.all
  end

  def show
    @checklist = Checklist.find(params[:id])
  end

  def new
    @checklist = Checklist.new
  end

  def create
    checklist = Checklist.new(checklist_params)
    if checklist.save
      redirect_to checklists_url, notice: '本日の値を入力しました。'
    else
      flash.now[:alert] = '何か入力に間違いがあるようです。'
      render :new
    end
  end

  def edit
    @checklist = Checklist.find(params[:id])
  end

  def update
    checklist = Checklist.find(params[:id])
    checklist.update!(checklist_params)
    redirect_to checklists_url, notice: "#{checklist.date}を更新しました。"
  end

  def destroy
    checklist = Checklist.find(params[:id])
    checklist.destroy
    redirect_to checklists_url, notice: "#{checklist.date}を削除しました"
  end

  private
    def checklist_params
      params.require(:checklist).permit(:date, :bt, :hr, :sbp, :dbp, :wt)
    end

end
