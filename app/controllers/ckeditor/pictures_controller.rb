class Ckeditor::PicturesController < Ckeditor::ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def index
    @folder = Ckeditor::Folder.where(id: params[:folder]).first
    # @folder ||= Ckeditor::Folder.first
    if @folder
      # @pictures = @folder.pictures.find_all(ckeditor_pictures_scope)
      # @pictures = Ckeditor.picture_adapter.find_all(ckeditor_pictures_scope).where(folder_id: @folder.id)
      @pictures = Ckeditor.picture_adapter.find_all(ckeditor_pictures_scope).folder(@folder)
      @folders = @folder.children.sorted unless params[:page]
    else
      @folders = Ckeditor::Folder.roots.sorted
      @pictures = Ckeditor.picture_adapter.find_all(ckeditor_pictures_scope).where(folder_id: nil)
    end

    @pictures = Ckeditor::Paginatable.new(@pictures).page(params[:page])

    respond_to do |format|
      format.html { render layout: @pictures.first_page? }
    end
  end

  def create
    begin
      old_params = Rack::Utils.parse_nested_query(request.referer)
    rescue
    end

    @picture = Ckeditor.picture_model.new
    @picture.folder = Ckeditor::Folder.where(id: old_params['folder']).first if old_params and request.path =~ /^\/ckeditor\/pictures/
    respond_with_asset(@picture)
  end

  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_path }
      format.json { render json: @picture, status: 204 }
    end
  end

  protected

  def find_asset
    @picture = Ckeditor.picture_adapter.get!(params[:id])
  end

  def authorize_resource
    model = (@picture || Ckeditor.picture_model)
    @authorization_adapter.try(:authorize, params[:action], model)
  end
end
