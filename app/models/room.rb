class Room < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name,  presence: true, length: { maximum: 50 }
  validates :content,  presence: true
  has_many :posts, dependent: :delete_all
  has_many :customers, through: :posts
  belongs_to :customer
  before_save   :downcase_name
  include PgSearch
  pg_search_scope :search_everywhere, against: [:name, :content]

  filterrific(
    :default_filter_params => { },
    :available_filters => %w[
      sorted_by
      with_room_route
      with_room_city
      search_query
      with_room_category
      with_created_at_gte
    ])

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    rooms = Room.arel_table
    case sort_option.to_s
    when /^route/
      order("route #{ direction }")
    when /^created_at/
      order("created_at #{ direction }")
    when /^category/
      order("category #{ direction }")
    when /^cat_route/
      order("cat_route #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_room_route, ->(room_route) {
      where(
       'rooms.route like :room_route',
       room_route: "%#{room_route}%"
      )
    }

   scope :with_room_city, ->(room_city) {
     where(
      'rooms.city like :room_city',
      room_city: "%#{room_city}%"
     )
   }

   scope :with_room_category, ->(room_category) {
     where(
      'rooms.category like :room_category',
      room_category: "%#{room_category}%"
     )
   }

   def self.options_for_sorted_by
    [
      ["Дата создания (сначала новые)", "created_at_desc"],
      ["Дата создания (сначала старые)", "created_at_asc"],
      ["Категория а-я", "category_asc"],
      ["Категория я-а", "category_desc"]
    ]
  end

  def self.route_for_select
    rooms = Room.arel_table
    # order('LOWER(name)').map { |e| [e.name, e.id] }
    order(rooms[:route].lower).pluck(:route).uniq
  end

  def self.city_for_select
    rooms = Room.arel_table
    # order('LOWER(name)').map { |e| [e.name, e.id] }
    order(rooms[:city].lower).pluck(:city).uniq
  end

  def self.category_for_select
    rooms = Room.arel_table
    # order('LOWER(name)').map { |e| [e.name, e.id] }
    order(rooms[:category].lower).pluck(:category).uniq
  end

  private

  def downcase_name
    self.name = name.downcase
  end


end
