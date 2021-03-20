# frozen_string_literal: true

class Affiliation < ApplicationRecord
  has_and_belongs_to_many :people

  validates :name, uniqueness: true
end
