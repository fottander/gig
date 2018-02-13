class Message
  include ActiveModel::Model
  attr_accessor :name, :email, :phone_number, :content
  validates :name, :email, :content, presence: true
end
