# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  image           :string(255)
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  platform        :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :comments, foreign_key: :user_id, dependent: :destroy
  has_many :boards, foreign_key: :user_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, on: :create
  validates :platform, presence: true

  mount_uploader :image, ImageUploader
end
