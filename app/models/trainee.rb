class Trainee < ApplicationRecord
  validates :record_type, presence: { message: "You must select a route" }
  validates :trainee_id, length: { maximum: 100, message: "Your entry must not exceed 100 characters" }

  enum record_type: { assessment_only: 0 }
  enum locale_code: { uk: 0, non_uk: 1 }

  has_many :degrees
  has_many :nationalisations, dependent: :destroy, inverse_of: :trainee
  has_many :nationalities, through: :nationalisations

  def dttp_id=(value)
    raise LockedAttributeError, "dttp_id update failed for trainee ID: #{id}, with value: #{value}" if dttp_id.present?

    super
  end
end
