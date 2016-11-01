package algo.problems.hanoi;

/**
 * ...
 * @author 
 */
class LargestMisplacedPower extends LargestMisplaced
{
	override public function evaluate(state:HanoiState):Int
	{
		var max = findLargestMisplaced(state);
		return  Std.int(Math.pow(2, max - 1));
	}
}