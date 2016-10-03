class DocumentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def show

  end

  def new
    @document = Document.new
  end

  def create
    # if current_user.admin?
      @document = current_user.documents.create(document_params)
    # else

  end

  private

  def document_params
    params.require(:document).permit(:title)
  end

end
