package algo.problems;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class RandomSearch
{
	var knapsack:BinaryKnapsack;
	public var history:Array<Int>;
	public function new(knapsack:BinaryKnapsack)
	{
		this.knapsack = knapsack;
		
	}
	
	public function solve(iterations:Int, withHistory:Bool):Result
	{
		this.history = new Array<Int>();
		var bestResult = new Result(new Vector<Bool>(1),-1);
		var index = 0;
		while (index < iterations)
		{
			var tryV = knapsack.generateRandomSolution();
			if (tryV.value > bestResult.value)
			{
				bestResult = tryV;
			}
			index++;
			if (withHistory)
				history.push(bestResult.value);
		}
		return bestResult;
	}
	
}