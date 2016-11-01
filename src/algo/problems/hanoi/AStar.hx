package algo.problems.hanoi;

/**
 * ...
 * @author 
 */
class AStar
{
	var hanoi : Hanoi;
	var evaluator : HanoiEvaluator;
	public var counter : Int;
	public function new(hanoi : Hanoi, evaluator : HanoiEvaluator)
	{
		this.hanoi = Hanoi.createCopy(hanoi);
		this.evaluator = evaluator;
	}
	
	public function solve(endstate:String):Array<String>
	{
		counter = 0;
		var closetSet = new Map<String,HanoiState>();
		var openSet = new Map<String,HanoiState>();
		var fScore = new Map<String,Int>();
		var gScore = new Map<String,Int>();
		var idToState = new Map<String,HanoiState>();
		var cameFrom = new Map<String,String>();
		
		var firstId = hanoi.state.generateStateId();
		
		cameFrom[firstId] = "";
		openSet[firstId]  = new HanoiState(hanoi.discNum, hanoi.state);
		idToState[firstId] = openSet[firstId];
		fScore[firstId] = evaluator.evaluate(hanoi.state);
		gScore[firstId] = 0;
		
		while (mapCounterItem(openSet) > 0)
		{
			var currentId = findMin(openSet,fScore);
			if (currentId == endstate)
				return getPath(cameFrom,endstate);
				
			openSet.remove(currentId);
			closetSet[currentId] = idToState[currentId];
			
			hanoi.state = idToState[currentId];
			for (item in hanoi.generatePosibleStates())
			{
				var itemid = item.generateStateId();
				if (closetSet.exists(itemid))
					continue;
					
				var t_gScore = gScore[currentId] + 1;
				if (!openSet.exists(itemid))
				{
					openSet[itemid] = item;
					idToState[itemid] = item;
					counter++;
				}
				else if (t_gScore >= gScore[itemid])
					continue;
					
				cameFrom[itemid] = currentId;
				gScore[itemid] = t_gScore;
				fScore[itemid] = t_gScore + evaluator.evaluate(item);
			}
		}
		return null;
	}
	
	private function getPath(cameFrom : Map<String,String>,endState) : Array<String>
	{
		var path = new Array<String>();
		var node = endState;
		path.push(endState);
		while (true)
		{
			if (cameFrom[node] != "")
			{
				node = cameFrom[node];
				path.push(node);
			}
			else
			{
				path.reverse();
				return path;
			}
		}
	}
	
	private function mapCounterItem(map:Map<String,HanoiState>):Int { 
	   var ret = 0; 
	   for (_ in map.keys()) ret++; 
	   return ret; 
	} 

	
	public function findMin(toIter :Map<String,HanoiState>,values : Map<String,Int>):String
	{
		var min = 100000000;
		var minKey = "";
		for (item in toIter.keys())
		{
			if (values[item] < min)
			{
				minKey = item;
				min = values[item] ;
			}
		}
		return minKey;
	}
	
	
	
	
}