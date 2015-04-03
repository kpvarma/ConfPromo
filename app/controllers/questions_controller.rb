class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.save
    redirect_to users_question_path(@question)
  end
  def show
    @question=Question.find_by_id params[:id]
  end

  private
def question_params
  params.require(:question).permit(:question, :answer_id)
end

end
