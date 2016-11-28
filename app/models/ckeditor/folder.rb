class Ckeditor::Folder
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  acts_as_nested_set
  scope :sorted, -> { asc(:lft) }

  field :name
  has_many :assets, class_name: 'Ckeditor::Asset', inverse_of: :folder

  before_validation do
    self.name = self.id.to_s if self.name.blank?
    true
  end

  def full_name
    if _p = self.parent
      return "#{_p.full_name}/#{self.name}"
    else
      return self.name
    end
  end

  def full_path_array(_params)
    if _p = self.parent
      return [_p.full_path_array(_params).flatten, [self.name, _params.merge(folder: self.id.to_s)]]
    else
      return [['Главная', _params.merge(folder: nil)], [self.name, _params.merge(folder: self.id.to_s)]]
    end
  end


  def pictures
    self.assets.where(_type: 'Ckeditor::Picture')
  end

  def attachment_files
    self.assets.where(_type: 'Ckeditor::AttachmentFile')
  end
end