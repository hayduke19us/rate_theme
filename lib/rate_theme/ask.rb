module RateTheme
  class Ask
    attr_accessor :question, :input
    def initialize(args)
      @question = args.fetch(:question, nil)
      @input = args.fetch(:input, nil)
    end

    def receive_answer test=nil
      self.input = test || gets.chomp.strip
    end
  end
end




