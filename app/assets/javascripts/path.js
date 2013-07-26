// $Id: path.js 262 2009-05-19 11:55:24Z ryandesign.com $

function Point(x, y) {
    this.x = x;
    this.y = y;
    this.offset = function (dx, dy) {
        this.x += dx;
        this.y += dy;
        return this;
    };
    this.distanceFrom = function (point) {
        var dx = this.x - point.x;
        var dy = this.y - point.y;
        return Math.sqrt(dx * dx + dy * dy);
    };
    this.makePath = function (ctx) {
        ctx.moveTo(this.x, this.y);
        ctx.lineTo(this.x + 0.001, this.y);
    };
    return true;
};

function Bezier(points) {
    this.points = points;
    this.order = points.length;
    this.reset = function () {
        //with (Bezier.prototype) {
        //	this.controlPolygonLength = controlPolygonLength;
        //	this.chordLength = chordLength;
        //	this.triangle = triangle;
        //	this.chordPoints = chordPoints;
        //	this.coefficients = coefficients;
        //}
    };
    this.offset = function (dx, dy) {
        for (var i = 0; i < this.points.length; i++) {
            this.points[i].offset(dx, dy);
        }
        this.reset();
        return this;
    };

    this.getBB = function () {
        if (!this.order) return undefined;
        var l, t, r, b, p = this.points[0];
        l = r = p.x;
        t = b = p.y;
        for (var i = 0; i < this.points.length; i++) {
            l = Math.min(l, this.points[i].x);
            t = Math.min(t, this.points[i].y);
            r = Math.max(r, this.points[i].x);
            b = Math.max(b, this.points[i].y);
        }
        var rect = new Rect(l, t, r, b);
        return (this.getBB = function () {
            return rect;
        })();
    };

    this.isPointInBB = function (x, y, tolerance) {
        if (Object.isUndefined(tolerance)) tolerance = 0;
        var bb = this.getBB();
        if (0 < tolerance) {
            bb = Object.clone(bb);
            bb.inset(-tolerance, -tolerance);
        }
        return !(x < bb.l || x > bb.r || y < bb.t || y > bb.b);
    };
    this.isPointOnBezier = function (x, y, tolerance) {
        if (Object.isUndefined(tolerance)) tolerance = 0;
        if (!this.isPointInBB(x, y, tolerance)) return false;
        var segments = this.chordPoints();
        var p1 = segments[0].p;
        var p2, x1, y1, x2, y2, bb, twice_area, base, height;
        for (var i = 1; i < segments.length; ++i) {
            p2 = segments[i].p;
            x1 = p1.x;
            y1 = p1.y;
            x2 = p2.x;
            y2 = p2.y;
            bb = new Rect(x1, y1, x2, y2);
            if (bb.isPointInBB(x, y, tolerance)) {
                twice_area = Math.abs(x1 * y2 + x2 * y + x * y1 - x2 * y1 - x * y2 - x1 * y);
                base = p1.distanceFrom(p2);
                height = twice_area / base;
                if (height <= tolerance) return true;
            }
            p1 = p2;
        }
        return false;
    };
    // Based on Oliver Steele's bezier.js library.
    this.controlPolygonLength = function () {
        var len = 0;
        for (var i = 1; i < this.order; ++i) {
            len += this.points[i - 1].distanceFrom(this.points[i]);
        }
        return (this.controlPolygonLength = function () {
            return len;
        })();
    };
    // Based on Oliver Steele's bezier.js library.
    this.chordLength = function () {
        var len = this.points[0].distanceFrom(this.points[this.order - 1]);
        return (this.chordLength = function () {
            return len;
        })();
    };
    // From Oliver Steele's bezier.js library.
    this.triangle = function () {
        var upper = this.points;
        var m = [upper];
        for (var i = 1; i < this.order; ++i) {
            var lower = [];
            for (var j = 0; j < this.order - i; ++j) {
                var c0 = upper[j];
                var c1 = upper[j + 1];
                lower[j] = new Point((c0.x + c1.x) / 2, (c0.y + c1.y) / 2);
            }
            m.push(lower);
            upper = lower;
        }
        return (this.triangle = function () {
            return m;
        })();
    };
    // Based on Oliver Steele's bezier.js library.
    this.triangleAtT = function (t) {
        var s = 1 - t;
        var upper = this.points;
        var m = [upper];
        for (var i = 1; i < this.order; ++i) {
            var lower = [];
            for (var j = 0; j < this.order - i; ++j) {
                var c0 = upper[j];
                var c1 = upper[j + 1];
                lower[j] = new Point(c0.x * s + c1.x * t, c0.y * s + c1.y * t);
            }
            m.push(lower);
            upper = lower;
        }
        return m;
    };
    // Returns two beziers resulting from splitting this bezier at t=0.5.
    // Based on Oliver Steele's bezier.js library.
    this.split = function (t) {
        if ('undefined' == typeof t) t = 0.5;
        var m = (0.5 == t) ? this.triangle() : this.triangleAtT(t);
        var leftPoints = new Array(this.order);
        var rightPoints = new Array(this.order);
        for (var i = 0; i < this.order; ++i) {
            leftPoints[i] = m[i][0];
            rightPoints[i] = m[this.order - 1 - i][i];
        }
        return {left: new Bezier(leftPoints), right: new Bezier(rightPoints)};
    };
    // Returns a bezier which is the portion of this bezier from t1 to t2.
    // Thanks to Peter Zin on comp.graphics.algorithms.
    this.mid = function (t1, t2) {
        return this.split(t2).left.split(t1 / t2).right;
    };
    // Returns points (and their corresponding times in the bezier) that form
    // an approximate polygonal representation of the bezier.
    // Based on the algorithm described in Jeremy Gibbons' dashed.ps.gz
    this.chordPoints = function () {
        var p = [
            {tStart: 0, tEnd: 0, dt: 0, p: this.points[0]}
        ].concat(this._chordPoints(0, 1));
        return (this.chordPoints = function () {
            return p;
        })();
    };
    this._chordPoints = function (tStart, tEnd) {
        var tolerance = 0.001;
        var dt = tEnd - tStart;
        if (this.controlPolygonLength() <= (1 + tolerance) * this.chordLength()) {
            return [
                {tStart: tStart, tEnd: tEnd, dt: dt, p: this.points[this.order - 1]}
            ];
        } else {
            var tMid = tStart + dt / 2;
            var halves = this.split();
            return halves.left._chordPoints(tStart, tMid).concat(halves.right._chordPoints(tMid, tEnd));
        }
    };
    // Returns an array of times between 0 and 1 that mark the bezier evenly
    // in space.
    // Based in part on the algorithm described in Jeremy Gibbons' dashed.ps.gz
    this.markedEvery = function (distance, firstDistance) {
        var nextDistance = firstDistance || distance;
        var segments = this.chordPoints();
        var times = [];
        var t = 0; // time
        var dt; // delta t
        var segment;
        var remainingDistance;
        for (var i = 1; i < segments.length; ++i) {
            segment = segments[i];
            segment.length = segment.p.distanceFrom(segments[i - 1].p);
            if (0 == segment.length) {
                t += segment.dt;
            } else {
                dt = nextDistance / segment.length * segment.dt;
                segment.remainingLength = segment.length;
                while (segment.remainingLength >= nextDistance) {
                    segment.remainingLength -= nextDistance;
                    t += dt;
                    times.push(t);
                    if (distance != nextDistance) {
                        nextDistance = distance;
                        dt = nextDistance / segment.length * segment.dt;
                    }
                }
                nextDistance -= segment.remainingLength;
                t = segment.tEnd;
            }
        }
        return {times: times, nextDistance: nextDistance};
    };
    // Return the coefficients of the polynomials for x and y in t.
    // From Oliver Steele's bezier.js library.
    this.coefficients = function () {
        // This function deals with polynomials, represented as
        // arrays of coefficients.  p[i] is the coefficient of n^i.

        // p0, p1 => p0 + (p1 - p0) * n
        // side-effects (denormalizes) p0, for convienence
        function interpolate(p0, p1) {
            p0.push(0);
            var p = new Array(p0.length);
            p[0] = p0[0];
            for (var i = 0; i < p1.length; ++i) {
                p[i + 1] = p0[i + 1] + p1[i] - p0[i];
            }
            return p;
        };
        // folds +interpolate+ across a graph whose fringe is
        // the polynomial elements of +ns+, and returns its TOP
        function collapse(ns) {
            while (ns.length > 1) {
                var ps = new Array(ns.length - 1);
                for (var i = 0; i < ns.length - 1; ++i) {
                    ps[i] = interpolate(ns[i], ns[i + 1]);
                }
                ns = ps;
            }
            return ns[0];
        };
        // xps and yps are arrays of polynomials --- concretely realized
        // as arrays of arrays
        var xps = [];
        var yps = [];
        for (var i = 0, pt; pt = this.points[i++];) {
            xps.push([pt.x]);
            yps.push([pt.y]);
        }
        var result = {xs: collapse(xps), ys: collapse(yps)};
        return (this.coefficients = function () {
            return result;
        })();
    };
    // Return the point at time t.
    // From Oliver Steele's bezier.js library.
    this.pointAtT = function (t) {
        var c = this.coefficients();
        var cx = c.xs, cy = c.ys;
        // evaluate cx[0] + cx[1]t +cx[2]t^2 ....

        // optimization: start from the end, to save one
        // muliplicate per order (we never need an explicit t^n)

        // optimization: special-case the last element
        // to save a multiply-add
        var x = cx[cx.length - 1], y = cy[cy.length - 1];

        for (var i = cx.length - 1; --i >= 0;) {
            x = x * t + cx[i];
            y = y * t + cy[i];
        }
        return new Point(x, y);
    };
    // Render the Bezier to a WHATWG 2D canvas context.
    // Based on Oliver Steele's bezier.js library.
    this.makePath = function (ctx, moveTo) {
        if ('undefined' == typeof moveTo) moveTo = true;
        if (moveTo) ctx.moveTo(this.points[0].x, this.points[0].y);
        var fn = this.pathCommands[this.order];
        if (fn) {
            var coords = [];
            for (var i = 1 == this.order ? 0 : 1; i < this.points.length; ++i) {
                coords.push(this.points[i].x);
                coords.push(this.points[i].y);
            }
            fn.apply(ctx, coords);
        }
    };
    // Wrapper functions to work around Safari, in which, up to at least 2.0.3,
    // fn.apply isn't defined on the context primitives.
    // Based on Oliver Steele's bezier.js library.
    this.pathCommands = [
        null,
        // This will have an effect if there's a line thickness or end cap.
        function (x, y) {
            this.lineTo(x + 0.001, y);
        },
        function (x, y) {
            this.lineTo(x, y);
        },
        function (x1, y1, x2, y2) {
            this.quadraticCurveTo(x1, y1, x2, y2);
        },
        function (x1, y1, x2, y2, x3, y3) {
            this.bezierCurveTo(x1, y1, x2, y2, x3, y3);
        }
    ];
    this.makeDashedPath = function (ctx, dashLength, firstDistance, drawFirst) {
        if (!firstDistance) firstDistance = dashLength;
        if ('undefined' == typeof drawFirst) drawFirst = true;
        var markedEvery = this.markedEvery(dashLength, firstDistance);
        if (drawFirst) markedEvery.times.unshift(0);
        var drawLast = (markedEvery.times.length % 2);
        if (drawLast) markedEvery.times.push(1);
        for (var i = 1; i < markedEvery.times.length; i += 2) {
            this.mid(markedEvery.times[i - 1], markedEvery.times[i]).makePath(ctx);
        }
        return {firstDistance: markedEvery.nextDistance, drawFirst: drawLast};
    };
    this.makeDottedPath = function (ctx, dotSpacing, firstDistance) {
        if (!firstDistance) firstDistance = dotSpacing;
        var markedEvery = this.markedEvery(dotSpacing, firstDistance);
        if (dotSpacing == firstDistance) markedEvery.times.unshift(0);
        for (var i = 1; i < markedEvery.times.length; i++)
            this.pointAtT(markedEvery.times[i]).makePath(ctx);
        return markedEvery.nextDistance;
    };
    return true;

};

var Path = function (segments) {
    this.segments = segments || [];
    this.setupSegments = function () {
    },
        // Based on Oliver Steele's bezier.js library.
        this.addBezier = function (pointsOrBezier) {
            this.segments.push(pointsOrBezier instanceof Array ? new Bezier(pointsOrBezier) : pointsOrBezier);
        },
        this.offset = function (dx, dy) {
            if (0 == this.segments.length) this.setupSegments();

            for (var i = 0; i < this.segments.length; i++) {
                this.segments[i].offset(dx, dy);
            }

        },
        this.getBB = function () {
            if (0 == this.segments.length) this.setupSegments();
            var l, t, r, b, p = this.segments[0].points[0];
            l = r = p.x;
            t = b = p.y;
            for (var i = 0; i < this.segments.length; i++) {
                for (var j = 0; j < this.segments[i].points.length; j++) {
                    l = Math.min(l, this.segments[i].points[j].x);
                    t = Math.min(t, this.segments[i].points[j].y);
                    r = Math.max(r, this.segments[i].points[j].x);
                    b = Math.max(b, this.segments[i].points[j].y);
                }
                ;
            }
            ;


            var rect = new Rect(l, t, r, b);
            return (this.getBB = function () {
                return rect;
            })();
        },
        this.isPointInBB = function (x, y, tolerance) {
            if (Object.isUndefined(tolerance)) tolerance = 0;
            var bb = this.getBB();
            if (0 < tolerance) {
                bb = Object.clone(bb);
                bb.inset(-tolerance, -tolerance);
            }
            return !(x < bb.l || x > bb.r || y < bb.t || y > bb.b);
        },
        this.isPointOnPath = function (x, y, tolerance) {
            if (Object.isUndefined(tolerance)) tolerance = 0;
            if (!this.isPointInBB(x, y, tolerance)) return false;
            var result = false;
            for (var i = 0; i < this.segments.length; i++) {
                if (this.segments[i].isPointOnBezier(x, y, tolerance)) {
                    result = true;
                    return result;
                }
            }
            return result;
        },
        this.isPointInPath = function (x, y) {
            return false
        },
        // Based on Oliver Steele's bezier.js library.
        this.makePath = function (ctx) {
            if (0 == this.segments.length) this.setupSegments();
            var moveTo = true;
            for (var i = 0; i < this.segments.length; i++) {
                this.segments[i].makePath(ctx, moveTo);
                moveTo = false;
            }
        },
        this.makeDashedPath = function (ctx, dashLength, firstDistance, drawFirst) {
            if (0 == this.segments.length) this.setupSegments();
            var info = {
                drawFirst: ('undefined' == typeof drawFirst) ? true : drawFirst,
                firstDistance: firstDistance || dashLength
            };
            for (var i = 0; i < this.segments.length; i++) {
                info = this.segments[i].makeDashedPath(ctx, dashLength, info.firstDistance, info.drawFirst);
            }
            ;
        },
        this.makeDottedPath = function (ctx, dotSpacing, firstDistance) {
            if (0 == this.segments.length) this.setupSegments();
            if (!firstDistance) firstDistance = dotSpacing;
            for (var i = 0; i < this.segments.length; i++) {
                firstDistance = this.segments[i].makeDottedPath(ctx, dotSpacing, firstDistance);
            }
            ;
        };
};

Polygon.prototype = new Path();
Polygon.prototype.constructor = Polygon;
function Polygon(points, options) {
    this.points = points || [];
    Path.call(this, [], options);
    this.offset = function (dx, dy) {
        for (var i = 0; i < points.length; i++) {
            point[i].offset(dx, dy);
        }
        ;
        return this;
    };
};

Polygon.prototype.setupSegments = function () {
    for (var i = 0; i < this.points.length; i++) {
        var next = i + 1;
        if (this.points.length == next) next = 0;
        this.addBezier([
            this.points[i],
            this.points[next]
        ]);
    }
};

Rect.prototype = new Polygon();
Rect.prototype.constructor = Rect;
function Rect(l, t, r, b, options) {
    this.l = l;
    this.t = t;
    this.r = r;
    this.b = b;
    Polygon.call(this, [], options);

    this.offset = function (dx, dy) {
        this.l = l;
        this.t = t;
        this.r = r;
        this.b = b;
        return this;
    },
        this.inset = function (ix, iy) {
            this.l += ix;
            this.t += iy;
            this.r -= ix;
            this.b -= iy;
            return this;
        },
        this.expandToInclude = function (rect) {
            this.l = Math.min(this.l, rect.l);
            this.t = Math.min(this.t, rect.t);
            this.r = Math.max(this.r, rect.r);
            this.b = Math.max(this.b, rect.b);
        },
        this.getWidth = function () {
            return this.r - this.l;
        },
        this.getHeight = function () {
            return this.b - this.t;
        },
        this.setupSegments = function ($super) {
            var w = this.getWidth();
            var h = this.getHeight();
            this.points = [
                new Point(this.l, this.t),
                new Point(this.l + w, this.t),
                new Point(this.l + w, this.t + h),
                new Point(this.l, this.t + h)
            ];
            Polygon.prototype.setupSegments.call(this);
        };
    return true;
};


Ellipse.prototype = new Path();
Ellipse.prototype.constructor = Ellipse;
function Ellipse(cx, cy, rx, ry, options) {
    this.cx = cx; // center x
    this.cy = cy; // center y
    this.rx = rx; // radius x
    this.ry = ry; // radius y
    this.KAPPA = 0.5522847498;
    Path.call(this, [], options);

    this.offset = function (dx, dy) {
        this.cx += dx;
        this.cy += dy;
        return this;
    };
    this.setupSegments = function () {
        this.addBezier([
            new Point(this.cx, this.cy - this.ry),
            new Point(this.cx + this.KAPPA * this.rx, this.cy - this.ry),
            new Point(this.cx + this.rx, this.cy - this.KAPPA * this.ry),
            new Point(this.cx + this.rx, this.cy)
        ]);
        this.addBezier([
            new Point(this.cx + this.rx, this.cy),
            new Point(this.cx + this.rx, this.cy + this.KAPPA * this.ry),
            new Point(this.cx + this.KAPPA * this.rx, this.cy + this.ry),
            new Point(this.cx, this.cy + this.ry)
        ]);
        this.addBezier([
            new Point(this.cx, this.cy + this.ry),
            new Point(this.cx - this.KAPPA * this.rx, this.cy + this.ry),
            new Point(this.cx - this.rx, this.cy + this.KAPPA * this.ry),
            new Point(this.cx - this.rx, this.cy)
        ]);
        this.addBezier([
            new Point(this.cx - this.rx, this.cy),
            new Point(this.cx - this.rx, this.cy - this.KAPPA * this.ry),
            new Point(this.cx - this.KAPPA * this.rx, this.cy - this.ry),
            new Point(this.cx, this.cy - this.ry)
        ]);
    };
    return true;
};

