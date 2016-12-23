module CkeditorAssetsFolders
  class Engine < ::Rails::Engine
    # isolate_namespace Ckeditor

    initializer "CkeditorAssetsFolders.asset_patch" do
      begin
        Ckeditor::Asset.send(:include, Ckeditor::Assets::Folderable)
      rescue
      end
    end

  end
end
