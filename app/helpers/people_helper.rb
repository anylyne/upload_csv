# frozen_string_literal: true

module PeopleHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    link_to title, { sort: column, direction: direction }, { class: css_class }
  end

  def format_names(entities)
    entities.map(&:name).join(', ')
  end

  def active_link(action)
    action_name == action ? 'active' : ''
  end

  private

  def css_class
    "current #{sort_direction}" if sort_column
  end

  def direction
    sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
  end
end
