class WebsitesController < ApplicationController

  before_action :load_website, only: %i[show destroy destroy_all_versions]

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
    @websites = Website.scanned_latest(current_user)
  end

  def destroy
    @website.destroy
    redirect_to websites_path
  end

  def destroy_all_versions
    websites = Website.where(url: @website.url)
    Website.transaction do
      websites.each do |website|
        website.destroy!
      end
    end

    redirect_to websites_path
  end

  private

  def website_params
    params.require(:website).permit(:url)
  end

  def load_website
    @website = Website.find(params[:id])
  end
end
