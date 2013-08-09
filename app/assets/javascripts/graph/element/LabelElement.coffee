#=require graph/element/BoxElement

class LabelElement extends BoxElement
  constructor: (group, style, graph, label) ->
    super group, style, graph
    @label = label.replace("\\n", "\n")
  computeStyle: (style) ->
    super(style)
    label = @group.get(".label")[0]
    if(!label?)
      label = new Kinetic.Text({
        x: 0,
        y: 0,
        text: @label,
        fontSize: 20,
        fontFamily: 'Calibri',
        fill: 'black'
        name: 'label'

        width: @group.getWidth()
        align: 'center'
      });

      @group.add(label)

    if(style.label?)
      unless style.label.hidden
        label.setOpacity(100)
        if(style.label.halign?)
          label.setAlign(style.label.halign)
        if(style.label.valign?)
          valign = style.label.valign
          switch valign
            when 'center'
              newY = (@group.getHeight() - label.getHeight()) / 2
            when 'bottom'
              newY = (@group.getHeight() - label.getHeight())
            else
              newY = (@group.getHeight() - label.getHeight()) / 2
          label.setY(newY);
        if(style.label.color?)
          label.setFill(style.label.color)
        if(style.label.fontStyle?)
          label.setFontStyle('bold');
        else
          label.setFontStyle('normal');
      else
        label.setOpacity(0)

    label.setZIndex(20) if label?

window.LabelElement = LabelElement