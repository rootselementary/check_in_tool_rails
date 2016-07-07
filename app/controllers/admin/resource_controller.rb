class Admin::ResourceController < ApplicationController
  respond_to :html

  before_action :authorize_collection, only: [:index]
  before_action :authorize_resource, only: [:new, :show, :delete, :edit, :create, :update]

  def index
    respond_with collection
  end

  def new
    respond_with resource
  end

  def create
    if resource.save
      flash[:notice] = "#{resource_class} Saved"
      respond_with resource, location: after_save_path_for(resource)
    else
      flash[:notice] = resource.errors.full_messages.to_sentence
      respond_with resource
    end
  end

  protected

  def after_save_path_for(resource)
    root_path
  end

  def collection
    resource_class.all
  end

  def resource_class
    controller_name.classify.constantize
  end

  def resource_as_sym
    Grove.to_s.downcase.to_sym
  end

  def resource
    @resource = resource_class.new(permitted_params)
  end

  def authorize_collection
    authorize(resource_as_sym, :index?)
  end

  def authorize_resource
    authorize(resource)
  end

  def permitted_params
    params.require(resource_as_sym).permit(whitelist)
  end
end
