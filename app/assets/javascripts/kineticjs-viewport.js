//=require kineticjs

function ViewPort(options) {

    var that = this;
    that.stage = null;
    that.layer = null;
    that.layerSize = null;
    that.offset = null;
    that.canvasSize = null;
    that.options = null;
    that.background = null;         //Allow all the layer to be draggable

    this.init = function (options) {

        var defaults = {
            container: 'canvas-container',
            width: 700,
            height: 400
        };
        that.options = $.extend({}, defaults, options);

        this.canvasSize = new Point(that.options.width, that.options.height);
        this.stage = new Kinetic.Stage({
            container: options.container,
            width: this.canvasSize.x,
            height: this.canvasSize.y
        });

        this.layerSize = new Point(this.canvasSize.x, this.canvasSize.y);

        //Create the mainlayer
        this.layer = new Kinetic.Layer({
            draggable: true,
            dragBoundFunc: this.verifyPosition
        });

        this.offset = $("#" + options.container).offset();

        //Enable all the layer to be draggable
        that.background = new Kinetic.Rect({
            x: 0,
            y: 0,
            width: this.layerSize.x,
            height: this.layerSize.y,
            fill: "#000000",
            opacity: 0
        });
        that.layer.add(that.background);


        $(this.stage.content).on('mousewheel', this.zoom);

        this.stage.add(this.layer);
    };

    this.resizeLayer = function (width, height) {
        that.background.setWidth(width);
        that.background.setHeight(height);
        that.layerSize.x = width;
        that.layerSize.y = height;
    };


    this.zoom = function (event) {

        var minScaleX = that.canvasSize.x / that.layerSize.x;
        var minScaleY = that.canvasSize.y / that.layerSize.y;
        var minScale = Math.max(minScaleX, minScaleY);

        event.preventDefault();
        var oevt = event.originalEvent;
        var mx = oevt.pageX - that.offset.left;
        var my = oevt.pageY - that.offset.top;

        var zoomAmount = oevt.wheelDelta * 0.001;
        var oldScale = that.layer.getScale().x;
        var newScale = oldScale + zoomAmount;
        if (newScale < minScale) {
            newScale = minScale;
        } else if (newScale > 2) {
            newScale = 2;
        }
        var dscale = newScale / oldScale;
        var ox = mx - dscale * ( mx - that.layer.getPosition().x);
        var oy = my - dscale * (my - that.layer.getPosition().y);
        that.layer.setScale(newScale);
        var pos = that.verifyPosition(new Point(ox, oy));
        that.layer.setPosition(pos.x, pos.y);


        that.layer.draw();

    };
    this.verifyPosition = function (pos) {

        var newX = pos.x;
        var newY = pos.y;
        var currentScale = that.layer.getScale().x;
        if (pos.x > 0) {
            newX = 0;
        }
        if (pos.y > 0) {
            newY = 0;
        }
        if (that.canvasSize.x - pos.x > that.layerSize.x * currentScale) {
            newX = that.canvasSize.x - that.layerSize.x * currentScale;
        }
        if (that.canvasSize.y - pos.y > that.layerSize.y * currentScale) {
            newY = that.canvasSize.y - that.layerSize.y * currentScale;
        }
        return {
            x: newX,
            y: newY
        };
    };

    this.update = function () {
        that.layer.draw();
    }

    this.init(options);
}

function Point(x, y) {
    this.x = typeof x !== 'undefined' ? x : 0;
    this.y = typeof y !== 'undefined' ? y : 0;

    this.toString = function () {
        return "(" + x + ", " + y + ")";
    }
}