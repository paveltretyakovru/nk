define(function(require) {
  'use strict';
  var Renderer, getSparseGraph, graphAlgs;
  require('d3');
  Renderer = require('views/pages/community/renderer');
  getSparseGraph = function(num) {
    var sparseGraph;
    sparseGraph = [];
    sparseGraph[0] = {
      nodes: {
        A: {
          'shape': 'dot',
          'label': 'A'
        },
        B: {
          'shape': 'dot',
          'label': 'B'
        },
        C: {
          'shape': 'dot',
          'label': 'C'
        },
        D: {
          'shape': 'dot',
          'label': 'D'
        },
        E: {
          'shape': 'dot',
          'label': 'E'
        },
        F: {
          'shape': 'dot',
          'label': 'F'
        },
        G: {
          'shape': 'dot',
          'label': 'G'
        },
        H: {
          'shape': 'dot',
          'label': 'H'
        },
        I: {
          'shape': 'dot',
          'label': 'I'
        },
        J: {
          'shape': 'dot',
          'label': 'I'
        },
        K: {
          'shape': 'dot',
          'label': 'H'
        },
        L: {
          'shape': 'dot',
          'label': 'G'
        },
        N: {
          'shape': 'dot',
          'label': 'F'
        },
        O: {
          'shape': 'dot',
          'label': 'E'
        },
        P: {
          'shape': 'dot',
          'label': 'D'
        },
        Q: {
          'shape': 'dot',
          'label': 'C'
        },
        R: {
          'shape': 'dot',
          'label': 'B'
        },
        S: {
          'shape': 'dot',
          'label': 'A'
        }
      },
      edges: {
        A: {
          B: {
            cost: 4
          },
          H: {
            cost: 8
          }
        },
        B: {
          A: {
            cost: 4
          },
          C: {
            cost: 8
          }
        },
        C: {
          B: {
            cost: 8
          },
          D: {
            cost: 7
          },
          F: {
            cost: 4
          },
          I: {
            cost: 2
          }
        },
        D: {
          E: {
            cost: 9
          },
          F: {
            cost: 14
          }
        },
        E: {
          D: {
            cost: 9
          },
          F: {
            cost: 10
          }
        },
        F: {
          C: {
            cost: 4
          },
          E: {
            cost: 10
          },
          G: {
            cost: 2
          }
        },
        G: {
          F: {
            cost: 2
          },
          H: {
            cost: 1
          },
          I: {
            cost: 6
          }
        },
        H: {
          A: {
            cost: 8
          },
          G: {
            cost: 1
          },
          I: {
            cost: 7
          }
        },
        I: {
          C: {
            cost: 2
          },
          H: {
            cost: 7
          },
          G: {
            cost: 6
          }
        },
        J: {
          B: {
            cost: 4
          },
          H: {
            cost: 8
          }
        },
        K: {
          A: {
            cost: 4
          },
          C: {
            cost: 8
          }
        },
        L: {
          B: {
            cost: 8
          },
          D: {
            cost: 7
          },
          F: {
            cost: 4
          },
          I: {
            cost: 2
          }
        },
        N: {
          E: {
            cost: 9
          },
          F: {
            cost: 14
          }
        },
        O: {
          D: {
            cost: 9
          },
          F: {
            cost: 10
          }
        },
        P: {
          C: {
            cost: 4
          },
          E: {
            cost: 10
          },
          G: {
            cost: 2
          }
        },
        Q: {
          F: {
            cost: 2
          },
          H: {
            cost: 1
          },
          I: {
            cost: 6
          }
        },
        R: {
          A: {
            cost: 8
          },
          G: {
            cost: 1
          },
          I: {
            cost: 7
          }
        },
        S: {
          C: {
            cost: 2
          },
          H: {
            cost: 7
          },
          G: {
            cost: 6
          }
        }
      }
    };
    sparseGraph[1] = {
      nodes: {
        A1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'A1'
        },
        B1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'B1'
        },
        C1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'C1'
        },
        D1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'D1'
        },
        E1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'E1'
        },
        F1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'F1'
        },
        G1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'G1'
        },
        H1: {
          'color': 'silver',
          'shape': 'dot',
          'label': 'H1'
        }
      },
      edges: {
        A1: {
          B1: {
            cost: 13
          },
          C1: {
            cost: 7
          },
          D1: {
            cost: 22
          },
          E1: {
            cost: 13
          },
          F1: {
            cost: 10
          },
          G1: {
            cost: 21
          },
          H1: {
            cost: 2
          }
        },
        B1: {
          A1: {
            cost: 13
          },
          C1: {
            cost: 14
          },
          D1: {
            cost: 7
          },
          E1: {
            cost: 19
          },
          F1: {
            cost: 5
          },
          G1: {
            cost: 16
          },
          H1: {
            cost: 27
          }
        },
        C1: {
          A1: {
            cost: 7
          },
          B1: {
            cost: 14
          },
          D1: {
            cost: 52
          },
          E1: {
            cost: 43
          },
          F1: {
            cost: 32
          },
          G1: {
            cost: 4
          },
          H1: {
            cost: 1
          }
        },
        D1: {
          A1: {
            cost: 22
          },
          B1: {
            cost: 7
          },
          C1: {
            cost: 52
          },
          E1: {
            cost: 18
          },
          F1: {
            cost: 19
          },
          G1: {
            cost: 22
          },
          H1: {
            cost: 3
          }
        },
        E1: {
          A1: {
            cost: 13
          },
          B1: {
            cost: 19
          },
          C1: {
            cost: 43
          },
          D1: {
            cost: 18
          },
          F1: {
            cost: 31
          },
          G1: {
            cost: 1
          },
          H1: {
            cost: 7
          }
        },
        F1: {
          A1: {
            cost: 10
          },
          B1: {
            cost: 5
          },
          C1: {
            cost: 32
          },
          D1: {
            cost: 19
          },
          E1: {
            cost: 31
          },
          G1: {
            cost: 21
          },
          H1: {
            cost: 3
          }
        },
        G1: {
          A1: {
            cost: 21
          },
          B1: {
            cost: 16
          },
          C1: {
            cost: 4
          },
          D1: {
            cost: 22
          },
          E1: {
            cost: 1
          },
          F1: {
            cost: 21
          },
          H1: {
            cost: 11
          }
        },
        H1: {
          A1: {
            cost: 2
          },
          B1: {
            cost: 27
          },
          C1: {
            cost: 1
          },
          D1: {
            cost: 3
          },
          E1: {
            cost: 7
          },
          F1: {
            cost: 3
          },
          G1: {
            cost: 11
          }
        }
      }
    };
    return sparseGraph[num];
  };
  return graphAlgs = function(element, graphBlock, pBlock) {
    var cursor, fill, force, h, heightGraph, links, nodes, restart, vis, w, widthGraph;
    widthGraph = $(graphBlock).width() / 2 - pBlock.offsetWidth / 2;
    heightGraph = graphBlock.offsetWidth;
    w = 300;
    h = 300;
    fill = d3.scale.category20();
    nodes = [];
    links = [];
    vis = d3.select("#viewport-right").append("svg:svg").attr("viewBox", "0 0 " + w + " " + h).attr("preserveAspectRatio", "xMinYMin");
    vis.append("svg:rect").attr("width", w).attr("height", h);
    force = d3.layout.force().nodes(nodes).links(links).size([w, h]);
    cursor = vis.append("svg:circle").attr("r", 30).attr("transform", "translate(-100,-100)").attr("class", "cursor");
    force.on("tick", function() {
      vis.selectAll("line.link").attr("x1", function(d) {
        return d.source.x;
      }).attr("y1", function(d) {
        return d.source.y;
      }).attr("x2", function(d) {
        return d.target.x;
      }).attr("y2", function(d) {
        return d.target.y;
      });
      return vis.selectAll("circle.node").attr("cx", function(d) {
        return d.x;
      }).attr("cy", function(d) {
        return d.y;
      });
    });
    vis.on("mousemove", function() {
      return cursor.attr("transform", "translate(" + d3.mouse(this) + ")");
    });
    vis.on("mousedown", function() {
      var n, node, point;
      point = d3.mouse(this);
      node = {
        x: point[0],
        y: point[1]
      };
      n = nodes.push(node);
      nodes.forEach(function(target) {
        var x, y;
        x = target.x - node.x;
        y = target.y - node.y;
        if (Math.sqrt(x * x + y * y) < 30) {
          return links.push({
            source: node,
            target: target
          });
        }
      });
      return restart();
    });
    restart = function() {
      vis.selectAll("line.link").data(links).enter().insert("svg:line", "circle.node").attr("class", "link").attr("x1", function(d) {
        return d.source.x;
      }).attr("y1", function(d) {
        return d.source.y;
      }).attr("x2", function(d) {
        return d.target.x;
      }).attr("y2", function(d) {
        return d.target.y;
      });
      vis.selectAll("circle.node").data(nodes).enter().insert("svg:circle", "circle.cursor").attr("class", "node").attr("cx", function(d) {
        return d.x;
      }).attr("cy", function(d) {
        return d.y;
      }).attr("r", 5).call(force.drag);
      return force.start();
    };
    return restart();
  };
});
