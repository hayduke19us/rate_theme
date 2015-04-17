gems = %w[rate_theme/ask
          rate_theme/monitor
          rate_theme/version
          minitest/autorun
          minitest/focus
          minitest/pride
          minitest/unit]

gems.each {|gem| require "#{gem}"}

include RateTheme

def test_the_version_constant_truly_exist
  assert RateTheme::Version
end
