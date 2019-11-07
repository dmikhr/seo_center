class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      # т.к. по root_path находится форма проверки сайта, недоступная гостю,
      # в случае CanCan::AccessDenied у гостя возникнет циклический редирект
      # для этого обрабатываем исключение по разному для пользователя и гостя
      if current_user.present?
        format.html { redirect_to root_path, alert: exception.message }
      else
        format.html { redirect_to new_user_session_path }
      end
      format.json { render json: { error: exception.message }, status: 403 }
      format.js { render nothing: true, status: 403 }
    end
  end

  check_authorization unless: :devise_controller?
end
