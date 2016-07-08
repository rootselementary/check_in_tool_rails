module Admin
  # ResourceController is the base class for handling administrative resources. The intent is to reduce the amount of
  # boilerplate and views that need to be created for standard crud tasks that are generally quite similar. The class
  # provides several hooks and options to allow overrides when neccesary.
  #
  # == Hooks
  #
  # :method: collection
  #
  # Returns the scoped resource as needed for the index action, by default it returns all records, but that is generally
  # not appropriate.
  #
  # :method: after_save_path_for(resource)
  #
  # indicates where the controller should direct a successful save or update
  #
  # :method: whitelist
  #
  # list of attributes that allowed through the permitted params call

  class ResourceController < ApplicationController
    respond_to :html

    before_action :authorize_collection, only: [:index]
    before_action :build_and_authorize_resource, only: [:create, :update]
    before_action :authorize_resource, only: [:edit, :show, :delete]

    helper_method :resource, :collection
    attr_reader :resource

    def index
      respond_with collection
    end

    def new
      @resource = resource_class.new
      authorize(resource)
      respond_with resource
    end

    def show
    end

    def edit
      respond_with resource
    end

    def update
      if resource.save
        flash[:notice] = "#{resource_class} Saved"
        redirect_to after_save_path_for(resource)
      else
        flash.now[:notice] = resource.errors.full_messages.to_sentence
        respond_with resource
      end
    end

    def create
      if resource.save
        flash[:notice] = "#{resource_class} Saved"
        redirect_to after_save_path_for(resource)
      else
        flash.now[:notice] = resource.errors.full_messages.to_sentence
        respond_with resource
      end
    end

    def destroy
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

    def build_resource
      @resource = resource_class.new(permitted_params)
    end

    def build_and_authorize_resource
      build_resource
      authorize(resource)
    end

    def authorize_collection
      authorize(resource_as_sym, :index?)
    end

    def authorize_resource
      @resource = resource_class.find(params[:id])
      authorize(resource)
    end

    def permitted_params
      params.require(resource_as_sym).permit(whitelist)
    end
  end
end
