package algo.problems.knapsack;
import algo.problems.knapsack.BinaryKnapsack;
import algo.problems.knapsack.ProblemSolver;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class RandomSearch extends ProblemSolver
{
	public var iterations:Int; 
	public function new(iterations:Int,knapsack:BinaryKnapsack)
	{
		super();
		this.knapsack = knapsack;
		this.iterations = iterations;
	}
	public override function solve(withHistory:Bool):Result
	{
		this.history = new Array<Int>();
		var bestResult = knapsack.generateRandomSolution();
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