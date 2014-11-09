#!/Users/ramusara/.rbenv/shims/ruby
# -*- coding:utf-8 -*-
require 'minitest/autorun'
require 'minitest/unit'
require './%testee%'

class %test_class% < MiniTest::Unit::TestCase
  def setup
    @sut = %cap-testee%.new
  end

  def teardown
  end

  def test_sample
  end
end
