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
    default_filter_params: { sorted_by: "created_at_desc" },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_room_route,
      :with_room_cat_route,
      :with_room_city,
      :with_room_category,
      :with_room_subdir,
      :with_created_at_gte,
    ],
  )

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
      joins(:room).where(
       'rooms.route like :room_route',
       room_route: "%#{room_route}%"
      )
    }

   scope :with_room_cat_route, ->(room_cat_route) {
     joins(:room).where(
      'room.cat_route like :room_cat_route',
      room_cat_route: "%#{room_cat_route}%"
     )
   }

   scope :with_room_city, ->(room_city) {
     joins(:room).where(
      'room.city like :room_city',
      room_city: "%#{room_city}%"
     )
   }

   scope :with_room_category, ->(room_category) {
     joins(:room).where(
      'room.category like :room_category',
      room_category: "%#{room_category}%"
     )
   }

   scope :with_room_subdir, ->(room_subdir) {
     joins(:room).where(
      'room.subdir like :room_subdir',
      room_subdir: "%#{room_subdir}%"
     )
   }

   scope :with_customer_id, ->(customer_id) {
      joins(:customer).where(
       'customers.id like :customer_id',
       customer_id: "%#{customer_id}%"
      )
    }

   def self.options_for_sorted_by
    [
      ["Route", "route_asc"],
      ["Route", "route_desk"],
      ["Creation date (newest first)", "created_at_desc"],
      ["Creation date (oldest first)", "created_at_asc"],
      ["Category", "cat_route_asc"],
    ]
  end


  private

  def downcase_name
    self.name = name.downcase
  end


end
