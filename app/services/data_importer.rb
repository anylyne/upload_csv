# frozen_string_literal: true

class DataImporter
  def initialize(tempfile)
    @tempfile = tempfile
    @data = CSVReader.new(@tempfile).as_hash
  end

  def run
    Person.transaction do
      @data.each { |item| Person.create(build_params(item)) }
    end
  end

  private

  def split_name(full_name)
    parts = full_name.downcase.split(' ').map(&:titlecase)
    size = parts.size
    if size > 1
      if (the_index = parts.find_index('The'))
        return [parts[0..the_index - 1].join(' '), parts[the_index..size].join(' ')]
      end

      return [parts[0..size - 2].join(' '), parts[size - 1]]
    end
    [parts[0], nil]
  end

  def find_or_create(model, names)
    return names.split(',').map { |name| model.find_or_create_by(name: name.strip.titlecase) } if names

    []
  end

  def build_params(item)
    {
      first_name: split_name(item[:name])[0],
      last_name: split_name(item[:name])[1],
      species: item[:species],
      gender: item[:gender],
      weapon: item[:weapon],
      vehicle: item[:vehicle],
      locations: find_or_create(Location, item[:location]),
      affiliations: find_or_create(Affiliation, item[:affiliation])
    }
  end
end
