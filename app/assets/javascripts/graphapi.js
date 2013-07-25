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
        fill: '#DBDBDB',
        stroke: 'blue',
        strokeWidth: 4
    });

    graph.canvas.layer.add(rect);

    graph.onLoadImage(function () {
        graph.drawCourse("Comp 202", new Point(30, 30));
        graph.drawCourse("Comp 250", new Point(120, 30));

    });

    // add the shape to the layer


    graph.update();
});


function Graph(options) {
    var that = this;
    that.options = null;
    that.canvas = null;
    that.images = Object();
    that.ressources = Object();

    this.init = function (options) {
        var defaults = {
            container: 'canvas',
            width: 700,
            height: 400
        };
        that.options = $.extend({}, defaults, options);
        that.canvas = new ViewPort({
            container: options.container,
            width: options.width,
            height: options.height
        });

        that.initImage('/assets')
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
            y: pos.y
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
        that.canvas.layer.add(group);
        that.update();

    };

    this.addImage = function (key) {
        var src = key.replace(/\./g, '/');
        var image = new Image();
        image.src = that.ressources.url + '/' + src + '.png';
        that.images[key] = image;
    };

    this.update = function () {
        that.canvas.update();
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