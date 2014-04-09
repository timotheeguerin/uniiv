TimJSON documentation
tlwr

entities:
  node - the default node, set properties for shape / size of all nodes
  node_unavailable - the colors for unavailable nodes
  node_available - the colors for available nodes
  node_taking - the colors for nodes the student is currently taking
  node_taken - the colors for nodes the student has taken
  arrow - the shape / size of arrows that connect nodes (includes line edges)
  op - the shape of operators
  op_unavailable - the colors for unavailable operators
  op_available - the colors for available operators
  
node:
  shape = circle/rect
  state
    background
      color
      cornerradius
      border
        width
        color
      image
        src
        offset {x y}
      gradient
        angle
        colors []
    label
      halign
      valign
      color
arrow
  color
  width
  length
  angle