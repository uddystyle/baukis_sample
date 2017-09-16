class Admin::SessionsController < Admin::Base
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(user_params)
    admin = Administrator.find_by(email_for_index: @form.email.downcase) if @form.email.present?

    if Admin::Authenticator.new(admin).authenticate(@form.password)
      if admin.suspended?
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        session[:admin_id] = admin.id
        session[:last_access_time] = Time.current
        flash.notice = 'ログインしました。'
        redirect_to :staff_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end
  #     session[:admin_id] = admin.id
  #     flash.notice = 'ログイン成功'
  #     redirect_to :admin_root
  #   else
  #     admin.suspended ? flash.now.alert = 'アカウントが停止されています。' : flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
  #     render action: 'new'
  #   end
  # end

  def destroy
    session.delete(:admin_id)
    redirect_to :admin_root
  end

  private

  def user_params
    params.require(:admin_login_form).permit(:email, :password)
  end
end