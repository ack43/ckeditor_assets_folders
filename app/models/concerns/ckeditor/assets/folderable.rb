module Ckeditor
  module Assets
    module Folderable
      extend ActiveSupport::Concern

      included do
        belongs_to :folder, class_name: 'Ckeditor::Folder', inverse_of: :assets
        scope :no_folder, -> {
          folder
        }
        scope :folder, -> (_folder = nil) {
          if _folder.is_a?(Ckeditor::Folder)
            where(folder_id: _folder._id)
          else
            where(folder_id: _folder)
          end
        }
      end

    end
  end
end
