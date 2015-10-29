require 'test_helper'

class DateTimeAttributesRailsTest < ActiveSupport::TestCase

  test "extends ActiveRecord::Base" do
    assert_respond_to ActiveRecord::Base, :date_time_attributes_for
  end

end
