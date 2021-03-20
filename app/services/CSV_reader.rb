# frozen_string_literal: true

require 'csv'

class CSVReader
  def initialize(uploaded_file)
    @file = uploaded_file.tempfile
  end

  def as_hash
    result = []
    converter = ->(header) { header.downcase.singularize.to_sym }
    CSV.parse(file_content, skip_blanks: true,
                            headers: true,
                            header_converters: converter) do |row|
      result << row.to_h
    end
    result
  end

  private

  def file_content
    content = ''
    begin
      @file.open.each_line { |line| content += line }
    ensure
      @file.close
      @file.unlink
    end
    content.strip.encode(universal_newline: true)
  end
end
