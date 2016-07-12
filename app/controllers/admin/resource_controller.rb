module Admin
  # ResourceController is the base class for handling administrative resources. The intent is to reduce the amount of
  # boilerplate and views that need to be created for standard crud tasks that are generally quite similar. The class
  # provides several hooks and options to allow overrides when necessary.
  #
  # == Hooks
  #
  # :method: collection
  #
  # Returns the scoped resource as needed for the index action, by default it returns all records, but that is generally
  # not appropriate.
  #
  # :method: resource An attr_reader that provides access to the current record for :show, :edit, :update, :destroy
  #
  # :method: after_save_path_for(resource)
  #
  # indicates where the controller should direct a successful save or update
  #
  # :method: form_attributes
  #
  # the attributes to expose in the form for the resource
  #
  # :method: collection_attributes
  #
  # the attributes to expose in the table on the index view
  #
  # :method: resource_class
  #
  # the classname of the current resource
  #
  # list of attributes that allowed through the permitted params call
  #
  # :method: whitelist
  #
  # list of attributes that allowed through the permitted params call
  #
  # :method: authorize_collection, authorize_resource
  #
  # hooks to authorize the resource if the current authorization is not enough
  #
  # == Creating an admin resource
  #
  # The goal of this base class is to make creating any new resource that is admin-able as simple as possible and reduce
  # the number of views that you must style and keep consistent across admin views.
  #
  # When creating a new resource you will most likely need:
  #
  # - a policy that enforces authorization
  # - a controller stub that inherits from this class in the admin namespace
  # - a declaration of the resource in the router
  # - an integration test that goes through the major crud actions
  #
  # You may also need:
  #
  # - a set of partials in the directory named for the resource
  # - full views instead of partials for some use cases
  # - special controller action handling and hooks as needed for handling the business logic around each resource task
  #
  # == Views
  #
  # By default there are views in the `admin/resource` directory. To override what you see in each view, create a
  # partial named for the action, eg the `admin/posts#index` action would get overridden by adding an `_index.html.erb`
  # file into the `admin/posts` directory.



  class ResourceController < ApplicationController
    respond_to :html

    before_action :authorize_collection, only: [:index]
    before_action :build_and_authorize_resource, only: [:create, :update]
    before_action :authorize_resource, only: [:edit, :show, :destroy]

    helper_method :resource, :collection, :resource_as_sym, :resource_class,
                  :form_attributes, :collection_attributes

    attr_reader :resource

    def index
      respond_with collection
    end

    def new
      @resource = resource_class.new
      authorize(resource)
      respond_with resource
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
      resource.destroy
      flash[:notice] = "#{resource_class} Deleted"
      redirect_to after_save_path_for(resource)
    end

    def show
      respond_with resource
    end

    protected

    def after_save_path_for(resource)
      root_path
    end

    def form_attributes
      []
    end

    def collection_attributes
      form_attributes
    end

    def resource_class
      controller_name.classify.constantize
    end

    def collection
      resource_class.all
    end

    def resource_as_sym
      resource_class.to_s.downcase.to_sym
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
