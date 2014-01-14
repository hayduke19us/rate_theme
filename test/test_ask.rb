require 'test_helper'

module RateTheme
  class TestAsk < Minitest::Test
    def setup 
      @ask = RateTheme::Ask.new question: "how are you"
    end

    def test_Ask_class_question_is_writable
      assert_equal @ask.question, "how are you"
      @ask.question = "whats your name"
      assert_equal @ask.question, "whats your name"
    end

    def test_receive_answer_changes_input
      @ask.receive_answer "favorite color"
      assert_equal @ask.input, "favorite color" 
    end
  end
end
