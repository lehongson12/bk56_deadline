class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @title = "Question"
    @questions = Question.all
    @questions = Question.all.paginate(page: params[:page], per_page: 10)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @title = @question.title
    @question = Question.find(params[:question_id] || params[:id])
    @answer = @question.answers
    @new_answer = @question.answers.new
   # @answer = Answer.new
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @title = "Edit Question"
      unless @question.user_id == current_user.try(:id)
        redirect_to question_path, :alert => "Access denied."
      end
  end

  # POST /questions
  # POST /questions.json
  def create
    #if user_signed_in? || admin_signed_in?
      @question = Question.new(question_params.merge!({user: current_user}))
      respond_to do |format|
        if @question.save
        #if verify_recaptcha(:private_key => '6LfJnwQTAAAAAM7Wvb01oUDsmoRgXm46bzLovZr_') and @question.save
            format.html { redirect_to @question, notice: 'Question was successfully created.' }
            format.json { render :show, status: :created, location: @question }
        else
            #flash[:recaptcha_error] = I18n.t("defaults.recaptcha")
            format.html { render :new }
            format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    #else
    #redirect_to root_path, :alert => "You must signed in"
    #end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
    unless @question.user_id == current_user.try(:id)
        redirect_to question_path, :alert => "Access denied."
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy if (@question.user_id == current_user.try(:id)) || current_user.try(:supermod) || admin_signed_in?
    respond_to do |format|
        format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
      redirect_to root_path, alert: "Access Denided" unless @question
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :content, :user_id)
    end

    ##
    ##def authorized_user
    ##  @question = Question.find(params[:id])
    ##  redirect_to root_path unless current_user?@question.user) 
    ##end

end
