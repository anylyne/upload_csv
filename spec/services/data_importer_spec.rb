# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataImporter, type: :model do
  describe '#run' do
    let(:tempfile) do
      Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/Coding Test Data - Sheet1.csv",
                                   'application/csv')
    end
    it 'shoud import people' do
      DataImporter.new(tempfile).run
      expect(Person.count).to eq(17)
    end
    it 'should get the last_name' do
      data_importer = DataImporter.new(tempfile)
      result = data_importer.send(:split_name, 'luke vader  skywalker')
      expect(result).to eq(['Luke Vader', 'Skywalker'])
    end
    it 'should start last_name from The' do
      data_importer = DataImporter.new(tempfile)
      result = data_importer.send(:split_name, 'jabba the Hutt')
      expect(result).to eq(['Jabba', 'The Hutt'])
    end
    it 'should titlecase the names' do
      data_importer = DataImporter.new(tempfile)
      result = data_importer.send(:split_name, 'C-3PO R2_D2')
      expect(result).to eq(['C 3po', 'R2 D2'])
    end
    it 'should accept empty last_name' do
      data_importer = DataImporter.new(tempfile)
      result = data_importer.send(:split_name, 'Chewbacca')
      expect(result).to eq(['Chewbacca', nil])
    end
    it 'empty' do
      data_importer = DataImporter.new(tempfile)
      result = data_importer.send(:split_name, '')
      expect(result).to eq([nil, nil])
    end
  end
end
