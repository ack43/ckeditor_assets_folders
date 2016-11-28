class Ckeditor::Folder
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :parent, class_name: "Ckeditor::Folder", inverse_of: :children
  scope :sorted, -> {
    asc :name
  }
  scope :roots, -> {
    any_of({parent_id: nil}, {parent_id: ""})
  }
  def self_and_descendants
    _ret = []
    _ret << Ckeditor::Folder.any_of({parent_id: self.id}, {id: self.id}).to_a
    self.children.all.to_a.each do |c|
      _ret << c.self_and_descendants
    end
    _ret.flatten
  end
  def children
    Ckeditor::Folder.any_of({parent_id: self.id})
  end


  # acts_as_nested_set
  # scope :sorted, -> { asc(:lft) }

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
      return [_p.full_path_array(_params), {name: self.name, params: _params.merge(folder: self.id.to_s)}]
    else
      return [{name: 'Главная', params: _params.merge(folder: nil)}, {name: self.name, params: _params.merge(folder: self.id.to_s)}]
    end
  end


  def pictures
    self.assets.where(_type: 'Ckeditor::Picture')
  end

  def attachment_files
    self.assets.where(_type: 'Ckeditor::AttachmentFile')
  end
end
