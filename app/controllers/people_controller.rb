# frozen_string_literal: true

class PeopleController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @people = Person.paginated("#{sort_column} #{sort_direction}", params[:page])
    @people = @people.filtered(params[:term][:text]) if params[:term]
  end

  def new; end

  def import
    if params[:file].nil?
      flash.now[:notice] = 'Please, select a file to import the data.'
      render :new
    else
      DataImporter.new(params[:file]).run
      redirect_to action: :index
    end
  end

  private

  def sort_column
    Person.sortable_columns.include?(params[:sort]) ? params[:sort] : 'first_name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
