module Users
  class QuestionsController < Poodle::AdminController

    skip_before_filter :require_admin

    def create
      @question = Question.new
      prepare_question
      save_resource(@question)
    end

    def update
      @question = Question.find_by_id(params[:id])
      prepare_question
      save_resource(@question)
    end

    def resource_url(obj)
      url_for([:users, obj])
    end

    private

    def prepare_question
      @question.title = params[:question][:title]
      @question.description = params[:question][:description]

      @question.remove_all_choices

      @question.add_choice(params[:question][:choice_1])
      @question.add_choice(params[:question][:choice_2])
      @question.add_choice(params[:question][:choice_3])
      @question.add_choice(params[:question][:choice_4])

      # params[:question][:answer] will be a string which is a subset of ["Choice 1", "Choice 2", "Choice 3", "Choice 4"]
      # e.g: if params[:question][:answer] == "Choice 1", then key will be "choice_1" and that value will be set as answer
      key = params[:question][:answer].gsub(" ", "_").downcase
      @question.set_answer(params[:question][key])
    end

    def get_collections
      # Fetching the questions
      relation = Question.where("")
      @filters = {}
      if params[:query]
        @query = params[:query].strip
        relation = relation.search(@query) if !@query.blank?
      end

      @per_page = params[:per_page] || "20"
      @questions = relation.order("created_at desc").page(@current_page).per(@per_page)

      ## Initializing the @question object so that we can render the show partial
      @question = @questions.first unless @question

      return true
    end

  end
end
