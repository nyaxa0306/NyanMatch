class Users::RegistrationsController < Devise::RegistrationsController
  def update
  self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

  if resource.update_with_password(account_update_params)
    redirect_to user_path(resource), notice: "アカウント情報を更新しました。"
  else
    clean_up_passwords resource
    flash.now[:alert] = "更新に失敗しました"
    render :edit, status: :unprocessable_entity
  end
end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end
end
