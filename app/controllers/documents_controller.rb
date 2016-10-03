# documents controller
class DocumentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  def index
    @documents = Document.all
  end

  def new
    if current_user.admin?
      @document = Document.new
    else
      unauthorized
    end
  end

  def create
    return unauthorized unless user_admin?
    @document = current_user.documents.create(document_params)
    return unproc_entity unless @document.valid? && user_admin?
    redirect_to documents_path
    flash[:success] = 'Document uploaded successfully!'
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end

  def unauthorized
    render plain: 'Unauthorized', status: :unauthorized
  end

  def unproc_entity
    render :new, status: :unprocessable_entity
  end

  def user_admin?
    current_user.admin?
  end
end
