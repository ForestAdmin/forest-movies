class Forest::ActionsController < ForestLiana::ApplicationController
  def approve
    comment = Comment.find(params['data']['attributes']['ids'][0])
    msg = "Comment by #{comment.customer.firstname} (##{comment.id}) approved."
    render json: { success: msg }, status: 200
  end

  def disapprove
    comment = Comment.find(params['data']['attributes']['ids'][0])
    msg = "Comment by #{comment.customer.firstname} (##{comment.id})
      disapproved."
    render json: { success: msg }, status: 200
  end
end
