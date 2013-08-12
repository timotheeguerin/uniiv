#=require graph/element/BoxElement

class LabelElement extends BoxElement
  constructor: (group, style, graph, label) ->
    super group, style, graph
    @label = label.replace("\\n", "\n")
    @label_element = null

  computeStyle: (style) ->
    super(style)
    # label = @group.get(".label")[0]
    if not @label_element?
      @label_element = new Kinetic.Text({
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

      @group.add(@label_element)

    if(style.label?)
      unless style.label.hidden
        @label_element.setOpacity(100)
        if(style.label.halign?)
          @label_element.setAlign(style.label.halign)
        if(style.label.valign?)
          valign = style.label.valign
          switch valign
            when 'center'
              newY = (@group.getHeight() - @label_element.getHeight()) / 2
            when 'bottom'
              newY = (@group.getHeight() - @label_element.getHeight())
            else
              newY = (@group.getHeight() - @label_element.getHeight()) / 2
          @label_element.setY(newY);
        if(style.label.color?)
          @label_element.setFill(style.label.color)
        if(style.label.fontStyle?)
          @label_element.setFontStyle(style.label.fontStyle);
        else
          @label_element.setFontStyle('normal');
      else
        @label_element.setOpacity(0)

    @label_element.setZIndex(20) if @label_element?

window.LabelElement = LabelElement