require 'test_helper'
require 'timecop'

class DateTimeAttributesTest < ActiveSupport::TestCase

  def setup
    @object = Dummy.new
  end

  test "responds to getter/setter for date and time attributes" do
    assert_respond_to @object, :ending_date
    assert_respond_to @object, :ending_time
    assert_respond_to @object, :ending_date=
    assert_respond_to @object, :ending_time=
  end

  test "removes the '_at' at the end of the attribute name, if it exists" do
    assert_respond_to @object, :start_date
    assert_respond_to @object, :start_time
    assert_respond_to @object, :start_date=
    assert_respond_to @object, :start_time=
  end

  test "returns empty strings from an empty attribute" do
    @object.start_at = nil
    assert_equal '', @object.start_date
    assert_equal '', @object.start_time

    @object.start_at = ''
    assert_equal '', @object.start_date
    assert_equal '', @object.start_time
  end


  test "returns date of date_time attribute" do
    @object.start_at = DateTime.new 1971, 10, 21, 11, 30, 0, '-4'
    assert_equal '1971-10-21', @object.start_date
  end

  test "returns date of time attribute" do
    @object.start_at = Time.new 1971, 10, 21, 11, 30, 0, '-04:00'
    assert_equal '1971-10-21', @object.start_date
  end

  test "returns date of date_time attribute, taking into account time zone" do
    @object.start_at = DateTime.new 1971, 10, 21, 23, 30, 0, '-4'
    assert_equal '1971-10-22', @object.start_date
  end

  test "returns date of time attribute, taking into account time zone" do
    @object.start_at = Time.new 1971, 10, 21, 23, 30, 0, '-04:00'
    assert_equal '1971-10-22', @object.start_date
  end


  test "returns time of date_time attribute" do
    @object.start_at = DateTime.new 1971, 10, 21, 11, 30, 0, '-4'
    assert_equal '15:30:00', @object.start_time
  end

  test "returns time of time attribute" do
    @object.start_at = Time.new 1971, 10, 21, 11, 30, 0, '-04:00'
    assert_equal '15:30:00', @object.start_time
  end


  test "set nil to the attribute if assigning an empty date" do
    [ nil, '' ].each do |empty_value|
      @object.ending = Time.now
      assert_not_nil @object.ending
      @object.ending_date = empty_value
      assert_nil @object.ending
    end
  end

  test "set a date as a string" do
    date = Date.new 1971, 10, 21
    @object.ending = Time.now
    @object.ending_date = date.to_s
    assert_equal date.to_s, @object.ending.to_date.to_s
  end

  test "set a date as a date" do
    date = Date.new 1971, 10, 21
    @object.ending = Time.now
    @object.ending_date = date
    assert_equal date.to_s, @object.ending.to_date.to_s
  end

  test "time is implicitly set when assigning a date to an empty attribute" do
    time = Time.now
    Timecop.freeze time
    date = Date.new 1971, 10, 21
    @object.ending = nil
    @object.ending_date = date
    assert_equal time.utc.strftime('%H:%M:%S'), @object.ending_time
    Timecop.return
  end


  test "does not change the attribute when assigning an empty time" do
    time = Time.now
    @object.ending = time
    [ nil, '' ].each do |empty_value|
      @object.ending_time = empty_value
      assert_equal time, @object.ending
    end
  end

  test "set a time as a string" do
    now   = Time.now.utc
    now_s = now.utc.strftime('%H:%M:%S')
    @object.ending = Time.utc 1971, 10, 21, 11, 30, 0
    @object.ending_time = now_s
    assert_equal now_s, @object.ending.strftime('%H:%M:%S')
  end

  test "set a time as a time" do
    now   = Time.now.utc
    now_s = now.utc.strftime('%H:%M:%S')
    @object.ending = Time.utc 1971, 10, 21, 11, 30, 0
    @object.ending_time = now
    assert_equal now_s, @object.ending.strftime('%H:%M:%S')
  end

  test "does not change the date when setting a time" do
    @object.ending = Time.utc 1971, 10, 21, 11, 30, 0
    @object.ending_time = Time.utc 2003, 03, 01, 11, 30, 0
    assert_equal '1971-10-21', @object.ending_date
  end

  test "does change the date when setting a time if the attribute is empty" do
    time = Time.new 1971, 10, 21, 11, 30, 0, '-04:00'
    Timecop.freeze time
    @object.ending = nil
    @object.ending_time = time
    assert_equal time.utc.strftime('%Y-%m-%d'), @object.ending_date
    Timecop.return
  end


  class Dummy
    extend DateTimeAttributes::ClassMethods
    attr_accessor :start_at, :ending
    date_time_attributes_for :start_at, :ending
  end

end
