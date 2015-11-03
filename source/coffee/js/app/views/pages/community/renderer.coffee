define ( require ) ->
	'use strict'	

	Renderer = ( canvas , num ) ->
		particleSystem = {}
		ctx = canvas.getContext "2d"
		gfx = arbor.Graphics(canvas)

		that =
			init : (system) ->
				particleSystem = system        
				particleSystem.screenSize canvas.width, canvas.height
				particleSystem.screenPadding 80
				that.initMouseHandling()

			redraw: ->
				gfx.clear()

				ctx.fillStyle = 'rgba(0,0,0,.2)'
				nodeBoxes = {}				

				particleSystem.eachNode (node, pt) ->					
					# label = node.data.label||""
					# w = ctx.measureText(""+label).width + 40
					# if not (""+label).match(/^[ \t]*$/)
					# 	pt.x = Math.floor(pt.x)
					# 	pt.y = Math.floor(pt.y)
					# else
					# 	label = null					
					w = 40
					
					ctx.fillStyle 	= "#282C35"	# Заливка точки
					ctx.lineWidth 	= 4			# Ширина рамки точки
					ctx.strokeStyle = '#F1AE2F'	# Цвет рамки точки
					
					gfx.oval(pt.x-w/2, pt.y-w/2, w,w, { fill:ctx.fillStyle , stroke : ctx.strokeStyle })
					nodeBoxes[node.name] = [pt.x-w/2, pt.y-w/2, w,w]
					
					# if label
					# 	ctx.font 		= "12px Helvetica"
					# 	ctx.textAlign 	= "center"
					# 	ctx.fillStyle 	= "white"						
					# 	ctx.fillText 	label||"", pt.x, pt.y+4
					# 	ctx.fillText 	label||"", pt.x, pt.y+4

				particleSystem.eachEdge (edge, pt1, pt2) ->
					weight 	= edge.data.weight
					color 	= edge.data.color

					if not color or (""+color).match(/^[ \t]*$/) then color = null
					
					tail = intersect_line_box(pt1, pt2, nodeBoxes[edge.source.name])
					head = intersect_line_box(tail, pt2, nodeBoxes[edge.target.name])

					ctx.save() 
					ctx.beginPath()
					ctx.lineWidth 	= if !isNaN(weight) then parseFloat(weight) else 3
					ctx.strokeStyle = if color then color else '#ECB72E'
					ctx.fillStyle 	= "black"
					ctx.moveTo(tail.x, tail.y)
					ctx.lineTo(head.x, head.y)
					ctx.stroke()
					ctx.font = 'italic 13px sans-serif';
					#if edge.data.cost
					#	 ctx.fillText edge.data.cost , (pt1.x + pt2.x) / 2, (pt1.y + pt2.y) / 2

					ctx.restore()
					
					if edge.data.directed
						ctx.save()
						
						wt = if !isNaN(weight) then parseFloat(weight) else 1
						arrowLength = 6 + wt
						arrowWidth 	= 2 + wt
						ctx.fillStyle 	= if color then color else "#cccccc"
						ctx.translate(head.x, head.y);
						ctx.rotate Math.atan2(head.y - tail.y, head.x - tail.x)						
						ctx.clearRect(-arrowLength/2,-wt/2, arrowLength/2,wt)
						
						ctx.beginPath();
						ctx.moveTo(-arrowLength, arrowWidth)
						ctx.lineTo(0, 0)
						ctx.lineTo(-arrowLength, -arrowWidth)
						ctx.lineTo(-arrowLength * 0.8, -0)
						ctx.closePath()
						ctx.fill()
						ctx.restore()

			initMouseHandling : ->
				dragged = null
				
				handler = 
					clicked: (e) ->
						pos 	= $(canvas).offset()
						_mouseP = arbor.Point e.pageX-pos.left, e.pageY-pos.top
						dragged = particleSystem.nearest _mouseP

						if dragged && dragged.node != null
							dragged.node.fixed = true

						$(canvas).on 'mousemove'	, handler.dragged
						$(window).on 'mouseup'	, handler.dropped

						return false

					dragged: (e) ->
						pos = $(canvas).offset()
						s = arbor.Point e.pageX-pos.left, e.pageY-pos.top

						if dragged && dragged.node != null
							p = particleSystem.fromScreen s
							dragged.node.p = p

						return false

					dropped: (e) ->
						if dragged == null || dragged.node == undefined then return
						if dragged.node != null then dragged.node.fixed = false
						
						dragged.node.tempMass = 1000
						dragged = null

						$(canvas).off 'mousemove', handler.dragged
						$(window).off 'mouseup'	, handler.dropped

						_mouseP = null
						return false
				
				$(canvas).mousedown handler.clicked

		intersect_line_line = (p1, p2, p3, p4) ->
			denom = (p4.y - (p3.y)) * (p2.x - (p1.x)) - ((p4.x - (p3.x)) * (p2.y - (p1.y)))
			if denom == 0
				return false
			# lines are parallel
			ua = ((p4.x - (p3.x)) * (p1.y - (p3.y)) - ((p4.y - (p3.y)) * (p1.x - (p3.x)))) / denom
			ub = ((p2.x - (p1.x)) * (p1.y - (p3.y)) - ((p2.y - (p1.y)) * (p1.x - (p3.x)))) / denom
			if ua < 0 or ua > 1 or ub < 0 or ub > 1
				return false
			arbor.Point p1.x + ua * (p2.x - (p1.x)), p1.y + ua * (p2.y - (p1.y))

		intersect_line_box = (p1, p2, boxTuple) ->
			p3 = 
				x: boxTuple[0]
				y: boxTuple[1]
			w = boxTuple[2]
			h = boxTuple[3]
			tl = 
				x: p3.x
				y: p3.y
			tr = 
				x: p3.x + w
				y: p3.y
			bl = 
				x: p3.x
				y: p3.y + h
			br = 
				x: p3.x + w
				y: p3.y + h
			intersect_line_line(p1, p2, tl, tr) or intersect_line_line(p1, p2, tr, br) or intersect_line_line(p1, p2, br, bl) or intersect_line_line(p1, p2, bl, tl) or false

		return that