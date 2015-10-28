define ( require ) ->
	'use strict'

	#require 'arbor'
	#require 'arbor-graphics'
	require 'd3'

	Renderer	= require 'views/pages/community/renderer'
	
	getSparseGraph = (num) ->
		sparseGraph = []

		sparseGraph[0] =
			nodes:
				A	: {'shape':'dot','label':'A'}
				B	: {'shape':'dot','label':'B'}
				C	: {'shape':'dot','label':'C'}
				D	: {'shape':'dot','label':'D'}
				E	: {'shape':'dot','label':'E'}
				F	: {'shape':'dot','label':'F'}
				G	: {'shape':'dot','label':'G'}
				H	: {'shape':'dot','label':'H'}
				I	: {'shape':'dot','label':'I'}
				J	: {'shape':'dot','label':'I'}
				K	: {'shape':'dot','label':'H'}
				L	: {'shape':'dot','label':'G'}
				N	: {'shape':'dot','label':'F'}
				O	: {'shape':'dot','label':'E'}
				P	: {'shape':'dot','label':'D'}
				Q	: {'shape':'dot','label':'C'}
				R	: {'shape':'dot','label':'B'}
				S	: {'shape':'dot','label':'A'}
			, 
			edges:
				A	: { B	: {cost: 4}, H	: {cost: 8} }
				B	: { A	: {cost: 4}, C	: {cost: 8} }
				C	: { B	: {cost: 8}, D	: {cost: 7}, F	: {cost: 4}, I	: {cost: 2} }
				D	: { E	: {cost: 9}, F	: {cost: 14} }
				E	: { D	: {cost: 9}, F	: {cost: 10} }
				F	: { C	: {cost: 4}, E	: {cost: 10}, G	: {cost: 2} }
				G	: { F	: {cost: 2}, H	: {cost: 1}, I	: {cost:6}	}
				H	: { A	: {cost: 8}, G	: {cost: 1}, I	: {cost: 7} }
				I	: { C	: {cost: 2}, H	: {cost: 7}, G	: {cost: 6} }
				J	: { B	: {cost: 4}, H	: {cost: 8} }
				K	: { A	: {cost: 4}, C	: {cost: 8} }
				L	: { B	: {cost: 8}, D	: {cost: 7}, F	: {cost: 4}, I	: {cost: 2} }
				N	: { E	: {cost: 9}, F	: {cost: 14} }
				O	: { D	: {cost: 9}, F	: {cost: 10} }
				P	: { C	: {cost: 4}, E	: {cost: 10}, G	: {cost: 2} }
				Q	: { F	: {cost: 2}, H	: {cost: 1}, I	: {cost:6}	}
				R	: { A	: {cost: 8}, G	: {cost: 1}, I	: {cost: 7} }
				S	: { C	: {cost: 2}, H	: {cost: 7}, G	: {cost: 6} }

		sparseGraph[1] =
			nodes:
				A1:{'color':'silver','shape':'dot','label':'A1'}
				B1:{'color':'silver','shape':'dot','label':'B1'}
				C1:{'color':'silver','shape':'dot','label':'C1'}
				D1:{'color':'silver','shape':'dot','label':'D1'}
				E1:{'color':'silver','shape':'dot','label':'E1'}
				F1:{'color':'silver','shape':'dot','label':'F1'}
				G1:{'color':'silver','shape':'dot','label':'G1'}
				H1:{'color':'silver','shape':'dot','label':'H1'}

			edges:
				A1:{ B1:{cost: 13}, C1:{cost: 7 }, D1:{cost: 22}, E1:{cost: 13}, F1:{cost: 10}, G1:{cost: 21}, H1:{cost: 2 } }
				B1:{ A1:{cost: 13}, C1:{cost: 14}, D1:{cost: 7 }, E1:{cost: 19}, F1:{cost: 5 }, G1:{cost: 16}, H1:{cost: 27} }
				C1:{ A1:{cost: 7 }, B1:{cost: 14}, D1:{cost: 52}, E1:{cost: 43}, F1:{cost: 32}, G1:{cost: 4 }, H1:{cost: 1 } }
				D1:{ A1:{cost: 22}, B1:{cost: 7 }, C1:{cost: 52}, E1:{cost: 18}, F1:{cost: 19}, G1:{cost: 22}, H1:{cost: 3 } }
				E1:{ A1:{cost: 13}, B1:{cost: 19}, C1:{cost: 43}, D1:{cost: 18}, F1:{cost: 31}, G1:{cost: 1 }, H1:{cost: 7 } }
				F1:{ A1:{cost: 10}, B1:{cost: 5 }, C1:{cost: 32}, D1:{cost: 19}, E1:{cost: 31}, G1:{cost: 21}, H1:{cost: 3 } }
				G1:{ A1:{cost: 21}, B1:{cost: 16}, C1:{cost: 4 }, D1:{cost: 22}, E1:{cost: 1 }, F1:{cost: 21}, H1:{cost: 11} }
				H1:{ A1:{cost: 2 }, B1:{cost: 27}, C1:{cost: 1 }, D1:{cost: 3 }, E1:{cost: 7 }, F1:{cost: 3 }, G1:{cost: 11} }
		
		return sparseGraph[num]

	graphAlgs = (element , graphBlock , pBlock)  ->
		#widthGraph += widthGraph/100 * 10
		#graphBlock.offsetWidth/2 - pBlock.offsetWidth/2

		widthGraph = $(graphBlock).width() / 2 - pBlock.offsetWidth / 2
		heightGraph = graphBlock.offsetWidth


		# width = widthGraph
		# height = heightGraph

		# color = d3.scale.category20()

		# window.force = d3.layout.force()
		# #.charge -120
		# #.linkDistance 100
		# .size [width, height]		

		# #viewport-right

		# svg = d3.select("#viewport-left").append("svg")
		# .attr("width", width)
		# .attr("height", height/2)
		

		# d3.json "test.json", (error, graph) ->
		# 	if error then throw error

		# 	force
		# 		.nodes(graph.nodes)
		# 		.links(graph.links)
		# 		.gravity(0.01)
		# 		.charge(-250)
		# 		.linkDistance(200)
		# 		.linkStrength(1)
		# 		.start();

		# 	link = svg.selectAll(".link")
		# 	.data 	graph.links
		# 	.enter().append "line"
		# 	.attr	"class", "link"
		# 	.style	"stroke-width", (d) -> return Math.sqrt d.value

		# 	node = svg.selectAll ".node"
		# 	.data graph.nodes
		# 	.enter().append "circle"
		# 	.attr 	"class", "node"
		# 	.attr 	"r", 20
		# 	.style 	"fill", (d) -> return if d.color? then d.color else '#282C35'
		# 	#.style 	"fill", (d) -> return color d.group
		# 	.call force.drag

		# 	node.append "title"
		# 	.text (d) -> return d.name

		# 	force.on "tick", ->
		# 		link.attr "x1", (d) -> return d.source.x
		# 		.attr "y1", (d) -> return d.source.y
		# 		.attr "x2", (d) -> return d.target.x
		# 		.attr "y2", (d) -> return d.target.y

		# 		node.attr "cx", (d) -> return d.x
		# 		.attr "cy", (d) -> return d.y

		#### -------------------------------------------------- ####

		w = 300
		h = 300
		fill = d3.scale.category20()
		nodes = []
		links = []

		vis = d3.select("#viewport-right").append("svg:svg")
		.attr("viewBox", "0 0 " + w + " " + h )
		.attr("preserveAspectRatio", "xMinYMin")

		vis.append("svg:rect")
		.attr("width", w)
		.attr("height", h)

		force = d3.layout.force()
		.nodes(nodes)
		.links(links)
		.size([w, h])

		cursor = vis.append("svg:circle")
		.attr("r", 30)
		.attr("transform", "translate(-100,-100)")
		.attr("class", "cursor")

		force.on "tick", ->
			vis.selectAll("line.link")
			.attr "x1", (d) -> return d.source.x
			.attr "y1", (d) -> return d.source.y
			.attr "x2", (d) -> return d.target.x
			.attr "y2", (d) -> return d.target.y;

			vis.selectAll("circle.node")
			.attr "cx", (d) -> return d.x
			.attr "cy", (d) -> return d.y

		vis.on "mousemove", ->			
			cursor.attr "transform", "translate(" + d3.mouse(this) + ")"

		vis.on "mousedown", ->
			point 	= d3.mouse(this)
			node 	= {x: point[0], y: point[1]}
			n 		= nodes.push(node)
			
			nodes.forEach (target) ->
				x = target.x - node.x
				y = target.y - node.y
				if (Math.sqrt(x * x + y * y) < 30)
					links.push({source: node, target: target})

			restart();

		restart = ->
			vis.selectAll "line.link"
			.data links
			.enter().insert "svg:line", "circle.node"
			.attr "class", "link"
			.attr "x1", (d) -> return d.source.x
			.attr "y1", (d) -> return d.source.y
			.attr "x2", (d) -> return d.target.x
			.attr "y2", (d) -> return d.target.y

			vis.selectAll("circle.node")
			.data nodes
			.enter().insert "svg:circle", "circle.cursor"
			.attr "class", "node"
			.attr "cx", (d) -> return d.x
			.attr "cy", (d) -> return d.y
			.attr "r", 5
			.call force.drag

			force.start()

		restart()

		# widthGraph = $(graphBlock).width()
		# widthGraph += widthGraph/100 * 10

		# heightGraph = $(graphBlock).height()

		# element.setAttribute 'height' 	, heightGraph
		# element.setAttribute 'width' 	, widthGraph

		# console.log 'WIDTH HEIGHT GRAPH ' , widthGraph , heightGraph

		# sys = arbor.ParticleSystem 1000*(num+1) , 600 * (num+1) , 0.5 *(num+1)
		# sys.parameters gravity : true , 
		# sys.renderer = Renderer element

		# sys.graft getSparseGraph 0
		# sys.graft getSparseGraph 1