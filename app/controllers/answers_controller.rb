class AnswersController < ApplicationController
  def create
    @question = Question.find params[:question_id]
    @answer = @question.answer.new answer_params
    if @answer.save
      respond_to do |format|
        format.js
      end
    end
  end

  private 
  def review_params
    params.require(:answer).permit :admin_id, :question_id, :content
    
  end
end
