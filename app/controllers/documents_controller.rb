class DocumentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @documents = Document.all
  end

  def new
    if current_user.admin?
      @document = Document.new
    else
      return unauthorized
    end
  end

  def create
    @document = current_user.documents.create(document_params)
    if current_user.admin? && @document.valid?
      redirect_to documents_path
      flash[:success] = "Document uploaded successfully!"
    elsif current_user.admin? && !@document.valid?
      return render :new, status: :unprocessable_entity
    else
      return unauthorized
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end

  def unauthorized
    render plain: 'Unauthorized', status: :unauthorized
  end

end
