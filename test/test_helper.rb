gems = %w[rate_theme/ask
          rate_theme/monitor
          minitest/autorun
          minitest/pride
          minitest/unit]
gems.each {|gem| require "#{gem}"}

describe RateTheme do
  it "must be defined" do
    RateTheme::VERSION.wont_be_nil
  end
end

