class Job < ApplicationRecord
  validates_presence_of :title, :description, :category, :city, :budget, :deadline, :duration, :hour_week
  belongs_to :company
  has_many :applications, dependent: :destroy
  default_scope {order('created_at DESC')}
  has_attached_file :avatar,
                       storage: :s3,
                       s3_protocol: :https, #specify the protocol as https
                       s3_credentials: Proc.new{|a| a.instance.s3_credentials },
                       styles: { small: '60x60#', large: '300x300#' }, default_style: :small,
                       default_url: ->(attachment) { ActionController::Base.helpers.asset_path('Default-company.png') },
                       size: { less_than: 2.megabytes }

  validates_attachment :avatar,
                        content_type:
                          {content_type: %w(image/jpg image/jpeg image/png image/gif)}

  scope :with_category, -> (category) { where category: category }
  scope :with_city, -> (city) { where city: city }
  scope :with_id, -> (id) { where id: id }
  scope :expired, -> { where('deadline >= ?', Date.today) }
  scope :with_company_id, -> (company_id) { where company_id: company_id }
  scope :with_company_username, -> (company_username) { where company_username: company_username }

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

  def self.city
    ['Hela sverige', 'Göteborg', 'Malmö', 'Stockholm']
  end

  def self.category
    ['Målare', 'Snickare', 'Plåtslagare', 'Lagerarbetare']
  end

  self.per_page = 5
end
