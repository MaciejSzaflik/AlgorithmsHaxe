package algo.problems.hanoi;

class BFS
{
	var hanoi:Hanoi;
	var distance: Map<String,Int>;
	var parents : Map<String,String>;
	public var counter : Int;
	public function new(hanoi:Hanoi) 
	{
		this.hanoi = hanoi;
		distance = new Map<String,Int>();
		parents = new Map<String,String>();
	}
	
	public function findState(endState:String):Array<String>
	{
		counter = 1;
		var Q = new List<HanoiState>();
		var path = new Array<String>();
		distance[hanoi.state.generateStateId()] = 0;
		parents[hanoi.state.generateStateId()] = "";
		Q.push(hanoi.state);
		var teminator = true;
		while (Q.length > 0  && teminator)
		{
			var state = Q.pop();
			hanoi.state = state;
			var currentId = state.generateStateId();
			for (item in hanoi.generatePosibleStates())
			{
				var id = item.generateStateId();
				if (!distance.exists(id))
				{
					distance[id] = distance[currentId] + 1;
					parents[id] = currentId;
					Q.add(item);
					counter++;
				}
				
				if (endState == id)
				{
					teminator = false;
					break;
				}
			}
		}
		if (!teminator)
			tracePath(path, endState);
		return path;
	}
	
	function tracePath(path : Array<String>, endState : String)
	{
		var node = endState;
		path.push(node);
		while (true)
		{
			if (parents[node] != "")
				path.push(parents[node]);
			else
				break;
			node = parents[node];
		}
		path.reverse();
	}
	
}