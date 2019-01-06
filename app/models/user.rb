class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # devise :database_authenticatable, :authentication_keys => [:mobile]

  belongs_to :dairy

  validates :mobile, :name, :dairy, :dairy_id, :address, presence: true
  validates :mobile, length: { is: 10 }
  validates :mobile, numericality: { only_integer: true }, uniqueness: { scope: :dairy_id}
  validates :animal_type, inclusion: { in: [true, false] }
  # validates :email, allow_blank: true, uniqueness: { scope: :dairy_id}

  scope :buffalo, -> { where(animal_type: false) }
  scope :cow, -> { where(animal_type: true) }

  has_many :collections

  def animal
    return 'Cow' if animal_type
    'Buffalo'
  end

  # private

  # def email_required?
  #   false
  # end
end
