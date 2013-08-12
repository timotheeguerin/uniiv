class Course::Node < ActiveRecord::Base

  belongs_to :parent, :class_name => Course::Node
  belongs_to :course, :class_name => Course
  has_many :nodes, :class_name => Course::Node, :foreign_key => "parent_id"
  accepts_nested_attributes_for :nodes

  def self.create_from_course_str(string)
    return if string.blank?
    node = Course::Node.new

    array = string.split(' ', 2)
    subject = Course::Subject.find_by_name(array[0])
    node.course = Course::Course.where(:subject_id => subject, :code => array[1]).first
    return nil if node.course.nil?
    node.operation = NodeOperation::NODE
    return node
  end

  def self.parse(string)
    if string.blank?
      return []
    end
    string = string.strip
    if string.start_with?('OR(') or string.start_with?('AND(')
      node = Course::Node.new
      if string.start_with?('OR')
        node.operation = NodeOperation::OR
      else
        node.operation = NodeOperation::AND
      end
      start_index = string.index('(') + 1
      open_delta = 1
      end_index = 0

      (start_index...string.length).each do |i|
        end_index = i
        if string[i] == '('
          open_delta += 1
        elsif string[i] == ')'
          open_delta -= 1
        end
        if open_delta == 0
          children = parse(string[start_index...i])
          return nil if children.nil?
          node.nodes = children
          break
        end
      end
      end_index += 1
      list = [node]
      newl = parse(string[end_index...string.length])
      list += newl
      return list
    else
      array = string.split(',', 2)
      n = Course::Node.create_from_course_str(array[0])
      return nil if n.nil?
      list = [n]
      list += parse(array[1])
      return list
    end

  end

  def is_linking_one_course? (courses)
    if operation == NodeOperation::NODE
      return courses.include?(course.id_to_s)
    else
      nodes.each do |node|
        return true if node.is_linking_one_course?(courses)
      end
    end
    false
  end


  def to_s
    r = ''
    return '' if operation.nil?
    if operation == NodeOperation::NODE
      r = r + course.to_s
    else
      r = r + ' (' + nodes.map! { |k| "#{k.to_s}" }.join(' ' + operation + ' ') + ') '
    end
    r
  end

  def to_html
    r = ''
    return '' if operation.nil?
    if operation == NodeOperation::NODE
      r = r + course.to_link
    else
      r = r + ' (' + nodes.map! { |k| "#{k.to_html}" }.join(' ' + operation + ' ') + ') '
    end
    r
  end

  def name
    to_s
  end

  def id_to_s
    if operation == NodeOperation::NODE
      course.id_to_s
    else
      'op_' + id.to_s
    end
  end


  def requirements_completed?(user)
    case operation
      when NodeOperation::OR
        nodes.each do |n|
          if n.requirements_completed?(user)
            return true
          end
        end
        return false
      when NodeOperation::AND
        nodes.each do |n|
          unless n.requirements_completed?(user)
            return false
          end
        end
        return true
      else
        return user.has_completed_course?(course)
    end
  end

  def as_json(options={})
    hash = super(:except => [:created_at, :updated_at])
    hash[:nodes] = nodes.as_json
    hash
  end

  def count_requirements
    if operation == NodeOperation::NODE
      1
    else
      count = 0
      nodes.each do |n|
        count += n.count_requirements
      end
      count
    end
  end
end


class NodeOperation
  NODE = 'NODE'
  OR = 'OR'
  AND = 'AND'

  public
  def self.all_values
    return [NodeOperation::NODE, NodeOperation::AND, NodeOperation::OR]
  end
end
