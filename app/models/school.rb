# frozen_string_literal: true

class School < ApplicationRecord
  validates :urn, presence: true, uniqueness: true
  validates :name, presence: true
  validates :lead_school, inclusion: { in: [true, false] }
end
