# frozen_string_literal: true

class Person < ApplicationRecord
  paginates_per 10

  has_and_belongs_to_many :locations
  has_and_belongs_to_many :affiliations

  validates :first_name, :species, :gender, presence: true
  validate :one_affiliation_at_least?

  scope :filtered, lambda { |term|
    where(filter_query, term: "%#{term}%")
  }

  scope :paginated, lambda { |order_query, page|
    includes(:locations, :affiliations)
      .left_outer_joins(:locations, :affiliations)
      .distinct
      .order(order_query).page(page)
  }

  def self.sortable_columns
    Person.column_names.dup << 'locations.name' << 'affiliations.name'
  end

  def self.filter_options
    sortable_columns.dup - %w[id created_at updated_at]
  end

  def self.filter_query
    filter_options.join(' LIKE :term OR ') << ' LIKE :term'
  end

  private

  def one_affiliation_at_least?
    errors.add(:affiliations, 'need one affiliation at least') if affiliations.empty?
  end
end
