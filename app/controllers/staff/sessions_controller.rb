class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    # Rails5では、Strong Parametersが必須
    @form = Staff::LoginForm.new(user_params)
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase) if @form.email.present?
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      session[:staff_member_id] = staff_member.id
      flash.notice = 'ログインしました。'
      redirect_to :staff_root
    else
      staff_member.suspended ? flash.now.alert = 'アカウントが停止されてます。' : flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :staff_root
  end

  def user_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
