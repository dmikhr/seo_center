class PagesController < ApplicationController

  before_action :load_page, only: %i[parse show]

  # skip_authorization_check
  # skip_authorize_resource only: [:action]
  authorize_resource

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
