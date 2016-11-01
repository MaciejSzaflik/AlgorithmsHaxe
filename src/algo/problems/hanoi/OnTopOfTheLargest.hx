package algo.problems.hanoi;

/**
 * ...
 * @author 
 */
class OnTopOfTheLargest extends HanoiEvaluator
{
	override public function evaluate(state:HanoiState):Int
	{
		for (peg in state.values)
		{
			for (value in peg)
			{
				if (value == state.discNum)
					return peg.length - 1;
			}
		}
		return 0;
	}
}