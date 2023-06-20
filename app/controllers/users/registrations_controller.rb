class Users::RegistrationsController < Devise::RegistrationsController
  layout "application", only: [:edit]
  
  protected
  
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end