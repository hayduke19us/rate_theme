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
    attr_accessor :file
    attr_reader :theme
    def initialize(theme)
      @theme = theme
      @file = Dir.home + "/.zshrc"
      @personal_defualt = Dir.home + "/code/configs/.zshrc"
      @user_location = ''
    end

    def file?
      File.exist?(self.file) ? true : false
    end

    def self.find_theme_config lines
      tmp = 0
      lines.each { |l| tmp = l if l =~ /ZSH_THEME/ }
      tmp > 1 ? tmp : false
    end

    def self.rewrite_config lines, file
      return lines
    end

    def find_file
      if self.file?
        Success.p_found_file self.file
        config_file = File.open(self.file, 'w+')
        all_lines = config_file.readlines
        config_line = Changer.find_theme_config config_file
        index = all_lines.index config_line
        all_lines[index.to_i] = "ZSH_THEME=" + "'" + "#{@theme}" + "'"
        Changer.rewrite_config all_lines, config_file
      else
        Error.missing_file
        input = gets.chomp
        unless input == ''
          self.file = input
          self.file_search
        end
      end
    end

    class Error
      def self.p_missing_file
        puts "We can't find your file".colorize(:red)
        puts "Please enter the path of your .zshrc file '/../../'"
      end
    end

    class Success
      def self.p_found_file file
        puts "File found in #{file}".colorize(:green)
      end
    end
  end
end
