var canvas = $("canvas");

$(document).ready(function () {
    var graph = new Graph({
        container: 'canvas'
    });
    var rect = new Kinetic.Rect({
        x: 10,
        y: 10,
        width: 980,
        height: 680,
        fill: 'green',
        stroke: 'black',
        strokeWidth: 4
    });
    var rect2 = new Kinetic.Rect({
        x: 200,
        y: 200,
        width: 600,
        height: 300,
        fill: 'red',
        stroke: 'black',
        strokeWidth: 4
    });

    // add the shape to the layer
    graph.layer.add(rect);
    graph.layer.add(rect2);
    graph.layer.draw();
});

function Graph(options) {

    var that = this;
    that.stage = null;
    that.layer = null;
    that.layerSize = null;
    that.offset = null;
    that.canvasSize = null;
    that.options = null;

    this.init = function (options) {

        var defaults = {
            container: 'canvas',
            width: 700,
            height: 400
        };
        that.options = $.extend({}, defaults, options);

        this.canvasSize = new Point(that.options.width, that.options.height);
        console.log("Size: " + this.canvasSize);
        this.stage = new Kinetic.Stage({
            container: options.container,
            width: this.canvasSize.x,
            height: this.canvasSize.y
        });

        this.layerSize = new Point(1000, 700);

        //Create the mainlayer
        this.layer = new Kinetic.Layer({
            draggable: true,
            dragBoundFunc: this.verifyPosition
        });

        this.offset = $("#" + options.container).offset();

        //Enable all the layer to be draggable
        var background = new Kinetic.Rect({
            x: 0,
            y: 0,
            width: this.layerSize.x,
            height: this.layerSize.y,
            fill: "#000000",
            opacity: 0
        });
        that.layer.add(background);


        $(this.stage.content).on('mousewheel', this.zoom);

        this.stage.add(this.layer);
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

    this.init(options);
}

function Point(x, y) {
    this.x = typeof x !== 'undefined' ? x : 0;
    this.y = typeof y !== 'undefined' ? y : 0;

    this.toString = function () {
        return "(" + x + ", " + y + ")";
    }
}
