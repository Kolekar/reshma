class Rate < ActiveRecord::Base
  belongs_to :dairy
  validates :rate, :dairy, :dairy_id, :fat, presence: true
  validates :rate, :snf, :fat, :degree, numericality: true
  validates :animal_type, inclusion: { in: [true, false] }
  validates :fat, uniqueness: { scope: [:snf, :degree, :animal_type, :dairy_id] }

  def animal
  	return 'Cow' if animal_type
  	'Buffalo'
  end
end
