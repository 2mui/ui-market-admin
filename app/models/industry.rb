class Industry < ApplicationRecord

  def self.options_for_select
    Industry.all.map {|x| [x.name, x.id] }
  end
end
