package algo.problems;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class SimulatedAnnaling extends ProblemSolver
{
	public var iterations:Int;
	public function new(iterations:Int,knapsack:BinaryKnapsack)
	{
		super();
		this.iterations = iterations;
		this.knapsack = knapsack;
	}
	
	public override function solve(withHistory:Bool):Result
	{
		this.history = new Array<Int>();
		var T = 1.0;
		var T_min = 0.00001;
		var alpha = 0.9;
		var currentResult = knapsack.generateRandomSolution();
		var bestResult = new Result(new Vector<Bool>(1), -1);
		var avergeValue = knapsack.averageItemValue();
		while (T > T_min)
		{
			var index = 0;
			while (index < iterations)
			{
				var tryV = knapsack.generateNeighbour(currentResult.resultVector);
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
		}
		return bestResult;
	}
	public function acceptancePropability(avarageValue:Float,newCost:Float, oldCost:Float, T:Float)
	{
		return ((oldCost - newCost)/avarageValue)*T;
	}
	
}