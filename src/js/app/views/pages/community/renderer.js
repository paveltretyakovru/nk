define(function(require) {
  'use strict';
  var Renderer;
  return Renderer = function(canvas, num) {
    var ctx, gfx, intersect_line_box, intersect_line_line, particleSystem, that;
    particleSystem = {};
    ctx = canvas.getContext("2d");
    gfx = arbor.Graphics(canvas);
    that = {
      init: function(system) {
        particleSystem = system;
        particleSystem.screenSize(canvas.width, canvas.height);
        particleSystem.screenPadding(80);
        return that.initMouseHandling();
      },
      redraw: function() {
        var nodeBoxes;
        gfx.clear();
        ctx.fillStyle = 'rgba(0,0,0,.2)';
        nodeBoxes = {};
        particleSystem.eachNode(function(node, pt) {
          var w;
          w = 40;
          ctx.fillStyle = "#282C35";
          ctx.lineWidth = 4;
          ctx.strokeStyle = '#F1AE2F';
          gfx.oval(pt.x - w / 2, pt.y - w / 2, w, w, {
            fill: ctx.fillStyle,
            stroke: ctx.strokeStyle
          });
          return nodeBoxes[node.name] = [pt.x - w / 2, pt.y - w / 2, w, w];
        });
        return particleSystem.eachEdge(function(edge, pt1, pt2) {
          var arrowLength, arrowWidth, color, head, tail, weight, wt;
          weight = edge.data.weight;
          color = edge.data.color;
          if (!color || ("" + color).match(/^[ \t]*$/)) {
            color = null;
          }
          tail = intersect_line_box(pt1, pt2, nodeBoxes[edge.source.name]);
          head = intersect_line_box(tail, pt2, nodeBoxes[edge.target.name]);
          ctx.save();
          ctx.beginPath();
          ctx.lineWidth = !isNaN(weight) ? parseFloat(weight) : 3;
          ctx.strokeStyle = color ? color : '#ECB72E';
          ctx.fillStyle = "black";
          ctx.moveTo(tail.x, tail.y);
          ctx.lineTo(head.x, head.y);
          ctx.stroke();
          ctx.font = 'italic 13px sans-serif';
          ctx.restore();
          if (edge.data.directed) {
            ctx.save();
            wt = !isNaN(weight) ? parseFloat(weight) : 1;
            arrowLength = 6 + wt;
            arrowWidth = 2 + wt;
            ctx.fillStyle = color ? color : "#cccccc";
            ctx.translate(head.x, head.y);
            ctx.rotate(Math.atan2(head.y - tail.y, head.x - tail.x));
            ctx.clearRect(-arrowLength / 2, -wt / 2, arrowLength / 2, wt);
            ctx.beginPath();
            ctx.moveTo(-arrowLength, arrowWidth);
            ctx.lineTo(0, 0);
            ctx.lineTo(-arrowLength, -arrowWidth);
            ctx.lineTo(-arrowLength * 0.8, -0);
            ctx.closePath();
            ctx.fill();
            return ctx.restore();
          }
        });
      },
      initMouseHandling: function() {
        var dragged, handler;
        dragged = null;
        handler = {
          clicked: function(e) {
            var _mouseP, pos;
            pos = $(canvas).offset();
            _mouseP = arbor.Point(e.pageX - pos.left, e.pageY - pos.top);
            dragged = particleSystem.nearest(_mouseP);
            if (dragged && dragged.node !== null) {
              dragged.node.fixed = true;
            }
            $(canvas).on('mousemove', handler.dragged);
            $(window).on('mouseup', handler.dropped);
            return false;
          },
          dragged: function(e) {
            var p, pos, s;
            pos = $(canvas).offset();
            s = arbor.Point(e.pageX - pos.left, e.pageY - pos.top);
            if (dragged && dragged.node !== null) {
              p = particleSystem.fromScreen(s);
              dragged.node.p = p;
            }
            return false;
          },
          dropped: function(e) {
            var _mouseP;
            if (dragged === null || dragged.node === void 0) {
              return;
            }
            if (dragged.node !== null) {
              dragged.node.fixed = false;
            }
            dragged.node.tempMass = 1000;
            dragged = null;
            $(canvas).off('mousemove', handler.dragged);
            $(window).off('mouseup', handler.dropped);
            _mouseP = null;
            return false;
          }
        };
        return $(canvas).mousedown(handler.clicked);
      }
    };
    intersect_line_line = function(p1, p2, p3, p4) {
      var denom, ua, ub;
      denom = (p4.y - p3.y) * (p2.x - p1.x) - ((p4.x - p3.x) * (p2.y - p1.y));
      if (denom === 0) {
        return false;
      }
      ua = ((p4.x - p3.x) * (p1.y - p3.y) - ((p4.y - p3.y) * (p1.x - p3.x))) / denom;
      ub = ((p2.x - p1.x) * (p1.y - p3.y) - ((p2.y - p1.y) * (p1.x - p3.x))) / denom;
      if (ua < 0 || ua > 1 || ub < 0 || ub > 1) {
        return false;
      }
      return arbor.Point(p1.x + ua * (p2.x - p1.x), p1.y + ua * (p2.y - p1.y));
    };
    intersect_line_box = function(p1, p2, boxTuple) {
      var bl, br, h, p3, tl, tr, w;
      p3 = {
        x: boxTuple[0],
        y: boxTuple[1]
      };
      w = boxTuple[2];
      h = boxTuple[3];
      tl = {
        x: p3.x,
        y: p3.y
      };
      tr = {
        x: p3.x + w,
        y: p3.y
      };
      bl = {
        x: p3.x,
        y: p3.y + h
      };
      br = {
        x: p3.x + w,
        y: p3.y + h
      };
      return intersect_line_line(p1, p2, tl, tr) || intersect_line_line(p1, p2, tr, br) || intersect_line_line(p1, p2, br, bl) || intersect_line_line(p1, p2, bl, tl) || false;
    };
    return that;
  };
});
