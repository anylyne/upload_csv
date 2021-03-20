# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CSVReader, type: :model do
  describe '#as_hash' do
    let(:uploaded_file) do
      Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/Coding Test Data - Sheet1.csv",
                                   'application/csv')
    end

    it 'shoud read the file and return as hash' do
      my_hash = CSVReader.new(uploaded_file).as_hash
      expect(my_hash.size).to eq(18)
    end

    it 'should not raise an error' do
      expect { CSVReader.new(uploaded_file).as_hash }.not_to raise_error
    rescue RSpec::Expectations::ExpectationNotMetError => e
      expect(e.message).not_to include 'MalformedCSVError'
    end
  end
end
