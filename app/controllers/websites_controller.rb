class WebsitesController < ApplicationController

  before_action :load_website, only: %i[show]

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(website_params)
    @website.scanned_time = DateTime.now # для сохранения разных версий сайта
    if @website.save
      redirect_to @website, notice: "Website was submitted for check"
    else
      render :new, notice: "Something went wrong"
    end
  end

  def show

  end

  private

  def website_params
    params.require(:website).permit(:url)
  end

  def load_website
    @website = Website.find(params[:id])
  end
end
