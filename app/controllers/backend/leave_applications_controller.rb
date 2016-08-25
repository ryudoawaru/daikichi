# frozen_string_literal: true
class Backend::LeaveApplicationsController < Backend::BaseController

  def verify
  end

  def update
    if current_object.update(resource_params)
      params[:approve] ? approve : reject
    else
      respond_to do |f|
        f.html {render action: :verify}
        f.json
      end
    end
  end

  private

  def approve
    current_object.approve!(current_user)
    action_success
  end

  def reject
    current_object.reject!(current_user)
    action_success
  end

  def collection_scope
    if params[:id]
      LeaveApplication
    else
      LeaveApplication.order(id: :desc)
    end
  end

  def resource_params
    params.require(:leave_application).permit(:comment)
  end
end