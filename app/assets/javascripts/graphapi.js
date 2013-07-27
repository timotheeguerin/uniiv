//var canvas = $("canvas");

$(document).ready(function () {
    var graph = new Graph({
        container: 'canvas-container'
    });

    graph.load("/assets/test.json", function () {

    });
    var rect = new Kinetic.Rect({
        x: 10,
        y: 10,
        width: 980,
        height: 980,
        fill: '#DBDBDB',
        stroke: 'blue',
        strokeWidth: 4
    });

    graph.viewport.layer.add(rect);

    graph.onLoadImage(function () {
        graph.drawCourse("Comp 202", new Point(30, 30));
        graph.drawCourse("Comp 250", new Point(120, 30));
        graph.drawArrow(120, 100, 200, 200);
    });

    // add the shape to the layer
    graph.update();
});


function Graph(options) {
    var that = this;
    that.options = null;
    that.viewport = null;
    that.images = Object();
    that.ressources = Object();

    this.init = function (options) {
        var defaults = {
            container: 'canvas',
            width: 700,
            height: 400
        };
        that.options = $.extend({}, defaults, options);
        that.viewport = new ViewPort({
            container: options.container,
            width: options.width,
            height: options.height
        });

        that.initImage('/assets')
    };
    this.load = function (url, callback) {
        $.post(url, function (data) {

            that.viewport.resizeLayer(data.graph.dimension.width, data.graph.dimension.height);
        }, "json");
        callback();
    };

    this.initImage = function (url) {
        that.ressources.url = url;
        that.addImage("course.unavailable");
    };

    this.onLoadImage = function (callback) {
        var loadedImages = 0;
        var numImages = 0;
        // get num of sources

        for (var tmp in that.images) {
            if (that.images.hasOwnProperty(tmp)) {
                numImages++;
            }
        }
        for (var src in that.images) {
            if (that.images.hasOwnProperty(src)) {
                that.images[src].onload = function () {
                    if (++loadedImages >= numImages) {
                        callback();
                    }
                };
            }
        }
    };

    that.drawCourse = function (course, pos) {
        var group = new Kinetic.Group({
            x: pos.x,
            y: pos.y,
            draggable: true
        });

        var rect = new Kinetic.Rect({
            x: 0,
            y: 0,
            width: 70,
            height: 70,
            cornerRadius: 10,
            fill: '#DBDBDB',
            stroke: 'blue',
            strokeWidth: 4
        });

        var image = new Kinetic.Image({
            x: 5,
            y: 5,
            image: that.images['course.unavailable'],
            width: 20,
            height: 20

        });

        var text = new Kinetic.Text({
            x: 5,
            y: 30,
            text: course,
            fontSize: 12,
            fontFamily: 'Helvetica',
            fill: 'black'
        });

        group.add(rect);
        group.add(image);
        group.add(text);
        // add the shape to the layer
        that.viewport.layer.add(group);
        that.update();

    };
    this.drawArrow = function (fromx, fromy, tox, toy) {
        var headlen = 20;   // how long you want the head of the arrow to be, you could calculate this as a fraction of the distance between the points as well.
        var angle = Math.atan2(toy - fromy, tox - fromx);

        line = new Kinetic.Line({
            points: [fromx, fromy, tox, toy, tox - headlen * Math.cos(angle - Math.PI / 6), toy - headlen * Math.sin(angle - Math.PI / 6), tox, toy, tox - headlen * Math.cos(angle + Math.PI / 6), toy - headlen * Math.sin(angle + Math.PI / 6)],
            stroke: "red"
        });
        that.viewport.layer.add(line);
    };

    this.addImage = function (key) {
        var src = key.replace(/\./g, '/');
        var image = new Image();
        image.src = that.ressources.url + '/' + src + '.png';
        that.images[key] = image;
    };

    this.update = function () {
        that.viewport.update();
    };

    this.init(options);


}

function Course() {
    var course = this;      //Alias for this
    var group = null;       //Group

    this.on = function (event, callback) {
        group.on(event, callback);
    }
}
