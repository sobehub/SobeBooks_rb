# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  notes                  :string
#  provider               :string
#  uid                    :string
#

class User < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_users, :against => [:name, :email]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :clients, dependent: :destroy
  has_many :vendors, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :setups, dependent: :destroy
  has_many :transactioninvoices, dependent: :destroy

  has_many :clienttransactions, dependent: :destroy
  has_many :vendortransactions, dependent: :destroy

  has_attached_file :avatar, :styles => { :small => "150x150>" },
                    :default_url=> "/assets/icon-user-default.png",
                    :url  => "/assets/User/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/User/:id/:style/:basename.:extension",
                    :restricted_characters => / /

  validates_attachment_size :avatar, :less_than => 1.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  def self.from_omniauth(auth)
    @users_db = User.where(:email => auth.info.email).first
    if  @users_db and @users_db.email == auth.info.email
      User.where(:email => auth.info.email).update_all(:provider => auth.provider,
                                                       :uid => auth.uid, :encrypted_password => Devise.friendly_token[0,20])
    end

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.encrypted_password = user.password = Devise.friendly_token[0,20]
      user.email = auth.info.email
      user.name = auth.info.name
    end
  end
end
