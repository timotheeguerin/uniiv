# This class should be removed with enum when switching to rails 4.1
class NodeOperation
  NODE = 'NODE'
  OR = 'OR'
  AND = 'AND'

  public
  def self.all_values
    return [NodeOperation::NODE, NodeOperation::AND, NodeOperation::OR]
  end
end