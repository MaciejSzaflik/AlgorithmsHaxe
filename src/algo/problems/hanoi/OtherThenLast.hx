package algo.problems.hanoi;
import algo.problems.hanoi.HanoiState;

/**
 * ...
 * @author 
 */
class OtherThenLast extends HanoiEvaluator
{
	override public function evaluate(state:HanoiState):Int
	{
		return state.discNum - state.values[state.values.length - 1].length;
	}
}