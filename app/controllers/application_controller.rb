class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #devise認証機能が使われる時はその前に、 configure_permitted_parametersが実行される

  def after_sign_in_path_for(resource)#ログイン後にマイページに遷移
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    #会員登録nicknameのデータ許可
  end
end
