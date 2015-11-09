define ( require ) ->
	'use strict'

	Graph =
		nodes: [
			{id: 0, x:340, y:230, r: 0, fixed: true }
			{id: 1, x:340, y:360, r: 0, fixed: true }
			{id: 2, x:240, y:550, r: 0, fixed: true }
			{id: 3, x:200, y:550, r: 0, fixed: true }
			{id: 4, x:40, y:550, r: 0, fixed: true }
			{id: 5, x:-45, y:480, r: 0, fixed: true }
			{id: 6, x:-45, y:40, r: 0, fixed: true }
			{id: 7, x:0, y:-20, r: 0, fixed: true }
			{id: 8, x:180, y:-70, r: 0, fixed: true }
			{id: 9, x:330, y:-70, r: 0, fixed: true }
			{id: 10, x:205, y:-10, r: 10 }
			{id: 11, x:45, y:60, r: 10 }
			{id: 12, x:17, y:460, r: 10 }
			{id: 13, x:150, y:525, r: 10 }
			{id: 14, x:270, y:250, r: 16 }
			{id: 15, x:150, y:50, r: 6 }
			{id: 16, x:50, y:250, r: 6 }
			{id: 17, x:150, y:270, r: 6 }
		]
		links: [
			{source: 0, target: 10}
			{source: 0, target: 14}
			{source: 0, target: 15, z: 1}
			{source: 1, target: 14}
			{source: 1, target: 13}
			{source: 1, target: 17, z: 1}
			{source: 2, target: 13, root: true}
			{source: 3, target: 13, root: true}
			{source: 4, target: 12, root: true}
			{source: 5, target: 12, root: true}
			{source: 6, target: 11, root: true}
			{source: 7, target: 11, root: true}
			{source: 8, target: 10, root: true}
			{source: 9, target: 10, root: true}
			{source: 10, target: 14}
			{source: 10, target: 11}
			{source: 10, target: 15, z: 1}
			{source: 11, target: 15, z: 1}
			{source: 11, target: 14}
			{source: 11, target: 12}
			{source: 12, target: 13}
			{source: 12, target: 14}
			{source: 12, target: 16, z: 1}
			{source: 12, target: 17, z: 1}
			{source: 13, target: 17, z: 1}
			{source: 13, target: 14}
			{source: 14, target: 15, z: 1}
			{source: 14, target: 16, z: 1}
			{source: 14, target: 17, z: 1}
			{source: 15, target: 16, z: 1}
			{source: 16, target: 17, z: 1}
		]
