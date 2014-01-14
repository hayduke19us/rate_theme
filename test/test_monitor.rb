require 'test_helper'
require 'yaml'
require 'colorize'

module RateTheme
  class TestLogger < Minitest::Test
    def setup 
      @logger = RateTheme::Logger.new name: "minimal", rating: 5
    end

    def test_logger_valid
      assert_instance_of RateTheme::Logger, @logger
    end
  end

  class TestLister < Minitest::Test
    def test_lister_valid
      lister = Lister.new
      assert_instance_of RateTheme::Lister, lister
    end
  
  end

  class TestChanger < Minitest::Test
    def setup
      @changer = RateTheme::Changer.new "minimal"
    end 
  end
end
