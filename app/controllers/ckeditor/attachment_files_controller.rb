class Ckeditor::AttachmentFilesController < Ckeditor::ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def index
    @folder = Ckeditor::Folder.where(id: params[:folder]).first
    # @folder ||= Ckeditor::Folder.first
    if @folder
      # @attachments = @folder.attachments.find_all(ckeditor_attachment_files_scope)
      @attachments = Ckeditor.attachment_file_adapter.find_all(ckeditor_attachment_files_scope).where(folder_id: @folder.id)
      @attachments = Ckeditor.attachment_file_adapter.find_all(ckeditor_attachment_files_scope).folder(@folder)
      @folders = @folder.children.sorted unless params[:page]
    else
      @folders = Ckeditor::Folder.roots.sorted
      @attachments = Ckeditor.attachment_file_adapter.find_all(ckeditor_attachment_files_scope).where(folder_id: nil)
    end

    @attachments = Ckeditor::Paginatable.new(@attachments).page(params[:page])

    respond_to do |format|
      format.html { render layout: @attachments.first_page? }
    end
  end

  def create
    begin
      old_params = Rack::Utils.parse_nested_query(request.referer)
    rescue
    end

    @attachment = Ckeditor.attachment_file_model.new
    @attachment.folder = Ckeditor::Folder.where(id: old_params['folder']).first if old_params and request.path =~ /^\/ckeditor\/attachment_files/
    respond_with_asset(@attachment)
  end

  def destroy
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to attachment_files_path }
      format.json { render json: @attachment, status: 204 }
    end
  end

  protected

  def find_asset
    @attachment = Ckeditor.attachment_file_adapter.get!(params[:id])
  end

  def authorize_resource
    model = (@attachment || Ckeditor.attachment_file_model)
    @authorization_adapter.try(:authorize, params[:action], model)
  end
end
