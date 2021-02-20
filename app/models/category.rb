class Category < ApplicationRecord

  def self.options_for_select
    Category.all.map {|x| [x.name, x.id] }
  end
end
