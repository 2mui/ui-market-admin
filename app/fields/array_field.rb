require "administrate/field/base"

class ArrayField < Administrate::Field::Base
  def to_s
    data
  end

  def selectable_options
    # ["PSD", "XD", "AI", "Sketch"]
    @exts ||= Filetype.all.pluck(:ext)
  end
end
