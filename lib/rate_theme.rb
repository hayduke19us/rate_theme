$: << File.expand_path('../rate_theme.rb', __FILE__)
require "colorize"
require "yaml"
require "rate_theme/version"
require "rate_theme/monitor"
require "rate_theme/ask"


  @div = lambda{ puts "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-".colorize(:blue)}
  @status = lambda{|str| 20.times do |t|
                           sleep(1.0/24)
                           print ".".colorize(:green)
                         end
                    str}


  @div.call
  puts "1. Rate theme."
  puts "2. List all rated themes and change theme."
  puts "3. Change theme to random."
  @div.call

  ask = RateTheme::Ask.new expected: 1
  ask.receive_answer
  @div.call

  if ask.input == '1'
    name = RateTheme::Ask.new question: "Theme name?"
    puts name.question
    @div.call
    name.receive_answer
    unless name.input == ''
      @div.call
      rating = RateTheme::Ask.new question: "Theme rating? (1-10)"
      puts rating.question
      @div.call
      rating.receive_answer
      @div.call

      logger = RateTheme::Logger.new name: name.input, rating: rating.input
      logger.action
    end
  elsif ask.input == '2'
    chosen = RateTheme::Lister.new
    if chosen.find_file
      @best = chosen.best_theme
      puts @best.colorize(:red) + " Is your highest rated!"
      @div.call
      chosen.all
      @div.call
      puts "1. Change theme to highest rated?"
      puts "2. Choose specific theme?"
      @div.call
      change_theme = RateTheme::Ask.new question: "choose theme?"
      change_theme.receive_answer

      @div.call

      if change_theme.input == '1'
        change = RateTheme::Changer.new @best
        @status.call("done")

        change.find_file
      elsif change_theme.input == '2'
        specific_theme = RateTheme::Ask.new question: "Type in the specific theme"
        puts specific_theme.question
        specific_theme.receive_answer
        unless specific_theme.input == ''
          change = RateTheme::Changer.new specific_theme.input
          @status.call("done")
          change.find_file
          @div.call
          puts "open a new window for changes to show!".colorize(:green)
        end
      else
        puts "choice must be 1 or 2"
      end
    else
      puts "No rated themes!"
      @div.call
    end
  elsif ask.input == '3'
    @status.call("done")
    random = RateTheme::Changer.new 'random'
    random.find_file
  end
