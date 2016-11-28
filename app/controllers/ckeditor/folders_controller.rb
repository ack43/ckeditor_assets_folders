class Ckeditor::FoldersController < ::ApplicationController

  def index
    @folder = Ckeditor::Folder.where(id: params[:folder]).first
    @folders = @folder ? @folder.children.sorted : Ckeditor::Folder.roots.sorted
  end

  def show
    @folder = Ckeditor::Folder.where(id: params[:folder]).first
  end

  def create
    @referer_part = request.referer.match(/\/ckeditor\/(attachment_files|pictures)\?/)
    puts request.referer.inspect
    puts @referer_part.inspect
    @referer_part = @referer_part[1] if @referer_part
    @folder = Ckeditor::Folder.create(params_folder)
    render layout: false
  end

  def destroy
    @folder = Ckeditor::Folder.where(id: params[:id]).first
    if @folder
      @folder.self_and_descendants.each do |f|
        Ckeditor::Asset.where(folder_id: f.id).update_all(folder_id: @folder.parent_id)
      end
      @folder.destroy
    end

    respond_to do |format|
      format.html { redirect_to folders_path }
      format.json { render json: @folder, status: 204 }
    end
  end

  protected

  def params_folder
    params.require(:folder).permit(:name, :parent_id)
  end
end
