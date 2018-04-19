class Category < ApplicationRecord
  validates_presence_of :name, :ssyk_code
  has_and_belongs_to_many :profiles, dependent: :destroy
  has_and_belongs_to_many :jobs, dependent: :destroy
  default_scope {order('name ASC')}
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

  self.per_page = 4

end
