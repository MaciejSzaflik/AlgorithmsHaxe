package algo.problems.knapsack;
import algo.problems.knapsack.BinaryKnapsack;
import algo.problems.knapsack.ProblemSolver;
import algo.problems.knapsack.Result;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class SimulatedAnnaling extends ProblemSolver
{
	public var iterations:Int;
	public var neighourChanges:Int;
	public var alpha:Float;
	public function new(iterations:Int,neighourChanges:Int,knapsack:BinaryKnapsack,alpha:Float = 0.9)
	{
		super();
		this.iterations = iterations;
		this.neighourChanges = neighourChanges;
		this.knapsack = knapsack;
		this.alpha = alpha;
	}
	
	public override function solve(withHistory:Bool):Result
	{
		this.history = new Array<Int>();
		var T = 1.0;
		var T_min = 0.00001;
		var currentResult = knapsack.generateRandomSolution();
		var bestResult = new Result(new Vector<Bool>(1), -1);
		var avergeValue = knapsack.averageItemValue();
		while (T > T_min)
		{
			var index = 0;
			while (index < iterations)
			{
				var tryV = knapsack.generateNeighbour(currentResult.resultVector,neighourChanges);
				var ap = acceptancePropability(avergeValue, tryV.value, currentResult.value, T);
				if (tryV.value > currentResult.value ||  ap > Math.random())
				{
					currentResult = tryV;
					if (currentResult.value > bestResult.value)
						bestResult = currentResult;
				}
				index++;
				if (withHistory)
					history.push(currentResult.value);
			}
			T = T * alpha;
			trace(T);
		}
		return bestResult;
	}
	public function acceptancePropability(avarageValue:Float,newCost:Float, oldCost:Float, T:Float)
	{
		return ((oldCost - newCost)/avarageValue)*T;
	}
	
}