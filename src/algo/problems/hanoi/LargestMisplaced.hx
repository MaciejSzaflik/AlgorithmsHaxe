package algo.problems.hanoi;

/**
 * ...
 * @author 
 */
class LargestMisplaced extends HanoiEvaluator
{

	override public function evaluate(state:HanoiState):Int
	{
		var max = findLargestMisplaced(state);
		return  Std.int(Math.pow(2, max) - 1);
	}
	
	public function findLargestMisplaced(state:HanoiState):Int
	{
		var max = 0;
		for (i in 0 ... state.values.length - 2)
		{
			for (value in state.values[i])
			{
				if (value > max)
					max = value;
			}
		}
		return max;
	}
}