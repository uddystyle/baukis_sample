class Staff::TopController < Staff::Base
  skip_before_action :authorize

  def index
    render action: 'index'
    @staff_members = @staff_members.page(params[:page])
  end

end
