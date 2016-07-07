class Admin::GrovesController < ApplicationController
  respond_to :html

  def index
    authorize(:grove, :index?)
  end

  def new
    @grove = Grove.new
    authorize(@grove)
    respond_with @grove
  end

  def create
    @grove = Grove.new(grove_params)
    authorize(@grove)
    if @grove.save
      flash[:notice] = "Grove Saved"
      respond_with @grove, location: admin_groves_path
    else
      flash[:notice] = @grove.errors.full_messages.to_sentence
      respond_with @grove
    end
  end

  protected

  def grove_params
    params.require(:grove).permit(:name)
  end
end
