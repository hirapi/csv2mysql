require 'csv'
require "thor"

require "csv2mysql/version"

module Csv2mysql
  class CLI< Thor

    desc "ins --db DATABASE --table TABLE CSV_FILE_PATH", "create INSERT query from CSV file"
    option :db, required: true
    option :table, aliases: '-t', required: true
    def ins(path)
      path = expand_path(path)
      help_exit("ins", "#{path} not found.") if !file_exist?(path)
      help_exit("ins", "Specify CSV file.") if !csv?(path)

      query = "INSERT INTO #{options[:db]}.#{options[:table]} %s VALUES %s;"

      t = to_csv_t(path)
      cols = get_cols(t)
      recs = get_recs(t)

      say('Query generated!', :green)
      print "CSV file: #{path}\n"
      print sprintf(query, cols_to_query_str(cols), recs_to_query_str(recs))
      print "\n"
    end

    private

    def help_exit(method, msg)
      say("#{msg} See '$ bundle exec bin/csv2mysql help #{method}'", :red)
      exit
    end

    def file_exist?(path)
      File.exist?(path)
    end

    def csv?(path)
      File.extname(path) == ".csv"
    end

    def expand_path(path)
      File.exist?(path) ? path : File.expand_path(path)
    end

    def to_csv_t(path)
      CSV.table(path)
    end

    def get_cols(csv_t)
      csv_t.headers
    end

    def get_recs(csv_t)
      csv_t.to_a.drop(1)
    end

    def cols_to_query_str(cols)
      str = '('
      cols.each do |col|
        str << col.to_s + ','
      end
      str.chop! << ')'
    end

    def recs_to_query_str(recs)
      str = ''
      recs.each do |rec|
        str << '('
        rec.each do |val|
          if val.instance_of?(String)
            str << "'#{val}'"
          else
            str << val.to_s
          end
          str << ','
        end
        str.chop! << '),'
      end
      str.chop!
    end
  end
end
