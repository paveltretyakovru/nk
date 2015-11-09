define ( require ) ->
	'use strict'

	require 'd3'
	Graph = require 'views/pages/community/data'

	class Nodes
		w: 300
		h: 500

		node: {}
		link: {}

		force: {}

		element: ''

		constructor: (el) ->
			@element = el
			rightSide = d3.select '#'+el#'#viewport-left'
			.append 'svg'
			.attr 'width', @w
			.attr 'height', @h

			rightSide.append 'rect'
			.attr 'width', @w
			.attr 'height', @h
			.attr 'fill', 'none'

			@node = rightSide.selectAll el+'-node'
			@link = rightSide.selectAll el+'-link'

			@force = d3.layout.force()
			.size [@w, @h]
			.nodes Graph.nodes
			.links Graph.links
			.linkStrength 5
			.linkDistance (link) ->
				x = link.target.x - link.source.x
				y = link.target.y - link.source.y
				Math.sqrt x * x + y * y
			.gravity 0.5
			.charge 0
			.on 'tick', () =>
				@link
				.attr 'x1', (d) -> d.source.x
				.attr 'y1', (d) -> d.source.y
				.attr 'x2', (d) -> d.target.x
				.attr 'y2', (d) -> d.target.y

				@node
				.attr 'cx', (d) -> d.x
				.attr 'cy', (d) -> d.y

			nodes = @force.nodes()
			links = @force.links()

			do @render

		render: () ->
			@link = @link.data Graph.links

			@link
			.enter()
			.insert 'line', @element+'-node'
			.attr 'class', @element+'-link'
			.attr 'opacity', (link) ->
				if link.z == 1
					return 0.3
			.attr 'stroke', '#F1AD2F'
			.attr 'stroke-width', (link) ->
				if link.z == 1
					return 1
				else
					return 3

			@node = @node.data Graph.nodes

			@node
			.enter()
			.insert 'circle', '.cursor'
			.attr 'class', @element+'-node'
			.attr 'fill', '#282C34'
			.attr 'stroke-opacity', (node) ->
				if node.r == 6
					return 0.3
			.attr 'stroke', '#F1AD2F'
			.attr 'stroke-width', 2
			.attr 'r', (node) ->
				node.r;
			.call(@force.drag);

			@force.start()


