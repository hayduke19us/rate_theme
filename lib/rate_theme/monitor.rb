module  RateTheme
  class Logger
    attr_reader :name, :rating
    def initialize(args)
      @name = args.fetch(:name)
      @rating = args.fetch(:rating)
      @file = File.expand_path("../themes.yml", __FILE__)
    end

    def file_virgin
      File.open(@file, 'w') do |f|
        f.puts({self.name => self.rating.to_i}.to_yaml)
        f.close
      end
    end

    def file_exist
      data = YAML.load_file(@file)
      data[self.name] = self.rating.to_i
      File.open(@file, 'w+') {|f| YAML.dump(data, f)}
    end

    def action
      unless File.exists?(@file)
        self.file_virgin
      else
        self.file_exist
      end
    end
  end

  class Lister
    attr_accessor :best_theme, :sorted, :data
    attr_reader :file
    def initialize
      @file = File.expand_path("../themes.yml", __FILE__)
      @data = nil
      @best_theme = nil
      @sorted = nil
    end

    def file_search
      if File.exist?(@file)
        self.data = YAML.load_file(@file)
        true
      end
    end

    def best_theme
      @sorted = @data.sort_by {|k, v| v}
      reversed = sorted.reverse
      theme = reversed.first
      self.best_theme = theme.first.dup
    end

    def all
      self.sorted.reverse.each {|k,v| puts "#{k}: #{v}"}
    end
  end

  class Changer
    attr_writer :file
    attr_reader :theme, :file
    def initialize(theme)
      @theme = theme
      @file = Dir.home + "/.zshrc"
      @user_location = nil
    end

    def file_search
      if File.exist?(@file)
        puts "File found in #{@file}".colorize(:green)
        rc = File.open(@file, 'a+')
        all = rc.readlines
        all.each do |line|
          if line =~ /ZSH_THEME=/
            @tmp = line
          end
        end
        index = all.index(@tmp).to_i
        all[index] = "ZSH_THEME=" + "'" + "#{@theme}" + "'"
        File.open(@file, 'w') do |file|
          all.each do |a|
            file.puts a
          end
        end
      else
        puts "We can't find your file".colorize(:red)
        puts "Please enter the path of your .zshrc file '/../../'"
        input = gets.chomp
        unless input == ''
          self.file = input
          self.file_search
        end
      end
    end
  end
end
