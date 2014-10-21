require 'test_helper'

class Course::CourseTest < ActiveSupport::TestCase

  test '#already_exists?' do
    course = create(:course_course)
    assert course.already_exist?
    new_course = Course::Course.new
    new_course.assign_attributes(subject_id: -1212, code: 211, part: 1)
    assert_not new_course.already_exist?
  end

  test 'should find course by string' do
    subject = create(:course_subject)
    course = create(:course_course, subject: subject)
    course_str = "#{course.subject} #{course.code}"
    new_course = Course::Course.find_by_string(course_str, subject.university)
    assert_equal new_course, course
  end

  test '#find_course_by_string should return nil for wrong format' do
    subject = create(:course_subject)
    assert_nil Course::Course.find_by_string('MATH222', subject.university)
    assert_nil Course::Course.find_by_string('MATH 202d', subject.university)
    assert_nil Course::Course.find_by_string('MATH 202D', subject.university)
    assert_nil Course::Course.find_by_string('MATH COMP', subject.university)
  end

  test '#find_course_by_string should return nil for course not found' do
    subject = create(:course_subject, name: 'UNKNOWN')
    new_course = Course::Course.find_by_string('UNKNOWN 202', subject.university)
    assert_nil new_course
  end
end
