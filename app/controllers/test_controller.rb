class TestController < ApplicationController
  def index
    authorize! :test, :all
    render :json => JSON.pretty_generate(migrate_program_version)
  end


  def migrate_program_version
    Program::Program.all.each do |program|
      version = Program::Version.new
      version.program = program
      version.id = program.id
      version.start_year=2010
      version.end_year=2014
      version.save
      Program::Group.where(:groupparent_id => program, :groupparent_type => 'Program::ProgramVersion').each do |group|
        group.groupparent = version
        group.save
      end
    end
  end

  def set_group_restricions
    Program::GroupRestriction.destroy_all
    Program::Group.all.each do |group|
      restriction = Program::GroupRestriction.new
      restriction.group = group
      restriction.value = group.value
      restriction.type = group.restriction
      restriction.save
    end
  end

  def check_course_requirement_filled
    Admin::CourseRequirementFilled.all.destroy_all
    Course::Course.all.each do |course|
      if course.admin_course_requirement_filled.nil?
        filled = Admin::CourseRequirementFilled.new
        filled.corequisites=true
        filled.prerequisites=true
        filled.prerequisites=false if course.prerequisite.nil?
        filled.corequisites=false if course.corequisite.nil?
        filled.course = course
        filled.save
      end
    end
  end


  def check_user_has_main_scenario
    User.all.each do |user|
      if user.main_course_scenario.nil?
        scenario = Course::Scenario.new
        scenario.main = true
        user.main_course_scenario = scenario
      end
    end
  end

  def remove_dup
    nodes = Course::Node.all

  end

  def check
    nodes = Course::Node.all
    nodes.each do |node|

      nodes.each do |n|
        if node_same?(n, node) and n.id != node.id
          puts 'TWO node same: ' + n.to_s + ' - '+ node.to_s
          n.exprs.each do |expr|
            puts 'Change expr'
            expr.node = node
            expr.save
          end
          n.parents.each do |parent|
            puts 'Change parents'
            node.parents << parent
            parent.nodes.delete(n)
            parent.save
          end
          n.destroy
          node.save
          return true
        end
      end
    end
    false
  end

  def node_same?(n1, n2)
    if n1.operation == NodeOperation::NODE || n2.operation == NodeOperation::NODE
      n1.to_s == n2.to_s
    else
      return false if n1.nodes.size != n2.nodes.size
      n1.nodes.each do |n|
        return false unless n2.nodes.include?(n)
      end
      true
    end
  end

  def check_null_parent
    nodes = Course::Node.all
    nodes.each do |node|
      if node.parents.size == 0 and node.exprs.size == 0
        puts 'NULL PARENT OR XPR'
        node.destroy
        return true
      end
    end
    exprs = Course::Expr.all
    exprs.each do |expr|
      if expr.courses_pre.size == 0 and expr.courses_co.size== 0
        expr.destroy
        return true
      end
    end
    false
  end
end
