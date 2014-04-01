class Course::Node < ActiveRecord::Base
  #Course to complete in this node
  belongs_to :course, :class_name => Course

  #Multiple expression can have the same requirement
  has_many :exprs, :class_name => Course::Expr

  has_and_belongs_to_many :nodes,
                          :foreign_key => 'course_node_id',
                          :association_foreign_key => 'children_id',
                          :class_name => Course::Node,
                          :join_table => 'course_node_childrens'

  has_and_belongs_to_many :parents,
                          :foreign_key => 'children_id',
                          :association_foreign_key => 'course_node_id',
                          :class_name => Course::Node,
                          :join_table => 'course_node_childrens'

  has_many :subject_requirement_nodes, :class_name => Course::SubjectRequirementNode, :foreign_key => 'node_id', :dependent => :destroy

  accepts_nested_attributes_for :nodes

  def self.create_from_course_str(string)
    return if string.blank?
    node = Course::Node.new

    array = string.split(' ', 2)
    subject = Course::Subject.find_by_name(array[0])
    code = array[1]
    node.course = Course::Course.where(:subject_id => subject, :code => code).first
    return nil if node.course.nil?

    existing_node = Course::Node.find_by_course_id(node.course.id)
    return existing_node unless existing_node.nil?
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
          childrens = parse(string[start_index...i])
          return nil if childrens.nil?
          node.nodes = childrens
          break
        end
      end
      #Check if the node is already exising somewhere
      existing_node = get_similar_node(node)
      node= existing_node unless existing_node.nil?

      end_index += 1
      list = [node]
      newl = parse(string[end_index...string.length])
      list += newl
      return list
    else #Course
      array = string.split(',', 2)
      n = Course::Node.create_from_course_str(array[0])
      return nil if n.nil?
      list = [n]
      list += parse(array[1])
      return list
    end

  end

  def self.get_similar_node(node)

    Course::Node.all.each do |n|
      if node.operation == NodeOperation::NODE
        return nil
      else
        if n.nodes.size== node.nodes.size
          next
        end
        same=true
        node.nodes.each do |c|
          same = false unless n.nodes.include?(c)
        end
        if same
          return n
        end
      end
    end
    return nil
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
      list = nodes.map { |k| "#{k.to_s}" } + subject_requirement_nodes.map { |k| "#{k.to_s}" }
      r = r + ' (' + list.join(' ' + operation + ' ') + ') '
    end
    r
  end

  def to_input
    r = ''
    return '' if operation.nil? or nodes.size == 0
    if operation == NodeOperation::NODE
      r = r + course.to_s
    else
      r = r + ' (' + nodes.map { |k| "#{k.to_s}" }.join(' ' + operation + ' ') + ') '
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


  def requirements_completed?(scenario, term = nil)
    user = scenario.user
    case operation
      when NodeOperation::OR
        nodes.each do |n|
          if n.requirements_completed?(scenario, term)
            return true
          end
        end
        return false
      when NodeOperation::AND
        nodes.each do |n|
          unless n.requirements_completed?(scenario, term)
            return false
          end
        end
        return true
      else
        if term.nil?
          return user.has_completed_course?(course)
        else #Check if the requirements will be complted at the given term
          return (user.has_completed_course?(course) or scenario.will_course_be_completed(course, term))
        end
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

  def get_complexity
    case operation
      when NodeOperation::AND
        complexity = 0
        nodes.each do |node|
          complexity += node.get_complexity
        end
        return complexity
      when NodeOperation::AND
        complexity = 0
        nodes.each do |node|
          complexity += 0.5*node.get_complexity
        end
        return complexity
      else
        course.get_complexity


    end
  end

  def list_dependencies
    case operation
      when NodeOperation::NODE
        [course]
      else
        courses = []
        nodes.each do |node|
          courses += node.list_dependencies
        end
        courses
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