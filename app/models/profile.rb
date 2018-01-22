class Profile < ApplicationRecord
  validates_presence_of :username, :title, :description, :city_ids, :category_ids
  validates_length_of :title, maximum: 80
  validates_length_of :rate, maximum: 35
  belongs_to :user
  has_many :applications, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  has_and_belongs_to_many :cities, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  has_many :notices, foreign_key: :recipient_id
  default_scope {order('created_at DESC')}
  has_attached_file :avatar,
                       storage: :s3,
                       s3_protocol: :https, #specify the protocol as https
                       s3_credentials: Proc.new{|a| a.instance.s3_credentials },
                       styles: { small: '60x60#', large: '300x300#' }, default_style: :large,
                       default_url: ->(attachment) { ActionController::Base.helpers.asset_path('Default-avatar1.png') },
                       size: { less_than: 2.megabytes }

  validates_attachment :avatar,
                        content_type:
                          {content_type: %w(image/jpg image/jpeg image/png image/gif)}

  scope :with_category,  ->(category) { joins(:categories).where(categories: { name: category }) }
  scope :with_city,  ->(city) { joins(:cities).where(cities: { name: city }) }
  scope :with_username, -> (username) { where username: username }
  scope :with_id, -> (id) { where id: id }

  def s3_credentials
   {
     bucket: 'gigalot',
     access_key_id: ENV['AWS_ACCESS_KEY'],
     secret_access_key: ENV['AWS_SECRET_KEY'],
     s3_region: ENV['AWS_REGION'],
     url: ':s3_domain_url',
     s3_host_name: 's3-eu-west-1.amazonaws.com'
   }
  end

  self.per_page = 5

end
