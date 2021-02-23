class ChecklistsController < ApplicationController
  def index
    @checklists = Checklist.all
  end

  def show
  end

  def new
    @checklist = Checklist.new
  end

  def edit
  end
end
