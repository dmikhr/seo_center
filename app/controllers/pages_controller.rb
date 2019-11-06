class PagesController < ApplicationController

  before_action :load_page, only: %i[parse show]

  def parse
    Services::PageStructure.call(@page)
    redirect_to @page
  end

  def show

  end

  private

  def load_page
    @page = Page.find(params[:id])
  end
end
