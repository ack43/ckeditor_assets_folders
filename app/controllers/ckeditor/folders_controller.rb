class Ckeditor::FoldersController < ::ApplicationController

  def index
    @folder = Ckeditor::Folder.where(id: params[:folder]).first
    @folders = @folder ? @folder.children.sorted : Ckeditor::Folder.roots
  end

  def show
    @folder = Ckeditor::Folder.where(id: params[:folder]).first
  end

  def create
    puts params_folder.inspect

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
      format.html { redirect_to pictures_path }
      format.json { render json: @folder, status: 204 }
    end
  end

  protected

  def params_folder
    params.require(:folder).permit(:name, :parent_id)
  end
end
