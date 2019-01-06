class Collection < ActiveRecord::Base
  validates :rate, :fat, :litre, :user_id, :collection_date, :dairy, :dairy_id, presence: true
  validates :rate, :snf, :fat, :degree, :litre, numericality: true
  validates :user_id, numericality: { only_integer: true }
  validates :animal_type, :time, inclusion: { in: [true, false] }
  validate :validate_with_user, :validate_with_rate

  scope :morning, -> { where(time: true) }
  scope :evening, -> { where(time: false) }
  scope :buffalo, -> { where(animal_type: false) }
  scope :cow, -> { where(animal_type: true) }
  scope :collection_at, ->(d = Date.today) { where(collection_date: d) }
  scope :collection_between, ->(sd,ed) { where('collections.collection_date >= ? AND collections.collection_date <= ?', sd, ed) }
 
  belongs_to :user
  belongs_to :dairy

  def animal
    return 'Cow' if animal_type
    'Buffalo'
  end

  def collection_time
    return 'Morning' if time
    'Evening'
  end

  def validate_with_user
    if animal_type != user.animal_type
      errors.add(:animal_type, "is not match with user animal type")
    end
  end

  def validate_with_rate
    rate_obj = Rate.find_by(fat: fat, snf: snf, degree: degree, animal_type: animal_type, dairy_id: dairy_id)
    if rate != rate_obj.rate
      errors.add(:rate, "is not match with saved rate")
    end
  end
end
