require "administrate/base_dashboard"

class ItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    description: Field::String,
    # category: Field::Number,
    # category: Field::Select.with_options(collection: [
    #   ["web", 1],
    #   ["app", 2],
    #   ["banner", 3],
    #   ["illustration", 4],
    #   ["icon", 5],
    #   ["animation", 6],
    #   ["3d", 7]
    # ]),
    # cover: Field::String,
    cover: Field::ActiveStorage,
    detail: Field::ActiveStorage,
    url: Field::ActiveStorage,
    author: Field::String,
    featured: Field::Boolean,
    draft: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    likes_count: Field::Number,
    downloads_count: Field::Number,
    filesize: Field::String,
    # category_id: Field::Number,
    # category_id: Field::Select.with_options(collection: [
    #     ["网页", 1],
    #     ["APP", 2],
    #     ["Banner", 3],
    #     ["插画", 4],
    #     ["图标", 5],
    #     ["动画", 6],
    #     ["3D", 7]
    # ]),
    category_id: Field::Select.with_options(collection: Category.all.map {|x| [x.name, x.id] }),
    industry_id: Field::Select.with_options(collection: Industry.all.map {|x| [x.name, x.id] }),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    title
    draft
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    title
    description
    cover
    detail
    url
    author
    filesize
    category_id
    industry_id
    featured
    draft
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    title
    description
    cover
    detail
    url
    author
    likes_count
    downloads_count
    filesize
    category_id
    industry_id
    featured
    draft
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how items are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(item)
  #   "Item ##{item.id}"
  # end

 
end
