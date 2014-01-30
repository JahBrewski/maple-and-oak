class ProjectCategory < ActiveRecord::Base

  def pluralized_name
    self.key_name.gsub("_"," ").capitalize.pluralize
  end
end
