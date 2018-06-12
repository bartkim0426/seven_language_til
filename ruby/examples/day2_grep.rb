module Grep
    def read_file
        File.open(get_filename, 'r') do |f|
            f.each_line.with_index do |line, index|
                if line.include?(get_search)
                    puts "Found #{get_search} in #{index}'s line - #{line}"
                end
            end
        end
    end
end

class Text
    include Grep
    attr_accessor :filename, :search

    def initialize(filename, search)
        @filename = filename
        @search = search
    end

    def get_filename
        filename
    end

    def get_search
        search
    end
end

# Text.new('grep_test.txt', 'seulchan').read_file
Text.new(ARGV[0], ARGV[1]).read_file
