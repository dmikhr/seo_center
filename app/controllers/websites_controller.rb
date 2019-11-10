class WebsitesController < ApplicationController

  before_action :load_website, only: %i[show]

  authorize_resource

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(website_params)
    @website.user = current_user
    if @website.save
      redirect_to @website, notice: "Website was submitted for check"
    else
      render :new, notice: "Something went wrong"
    end
  end

  def show; end

  def index
    @websites = scanned_latest
  end

  private

  def website_params
    params.require(:website).permit(:url)
  end

  def load_website
    @website = Website.find(params[:id])
  end

  def scanned_latest
    websites = []

    if current_user.admin?
      urls = Website.all.distinct.pluck(:url)
      urls.each { |url| websites << Website.where(url: url).order(scanned_time: :desc).first }
    else
      urls = Website.where(user: current_user).distinct.pluck(:url)
      urls.each { |url| websites << Website.where(user: current_user, url: url).order(scanned_time: :desc).first }
    end

    websites
  end
end
