class DocumentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def show
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create
    if current_user.admin?
      @document = current_user.documents.create(document_params)
    else
      return render text: 'Unauthorized', status: :unauthorized
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end

end
