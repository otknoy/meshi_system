#!/usr/bin/env ruby
require 'json'


class Database
  def initialize filename
    @filename = filename
    open(@filename, 'w').write('{}') unless File.exist? @filename
  end
  
  def read
    JSON.load(open(@filename))
  end

  def add date, where
    data = self.read
    data[date] = {} unless data.has_key? date
    data[date][where] = 0 unless data[date].has_key? where
    data[date][where] += 1

    open(@filename, 'w') do |f|
      JSON.dump(data, f)
    end
  end
end
