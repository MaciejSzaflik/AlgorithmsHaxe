package algo.problems.knapsack;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class Result
{
	public var resultVector:Vector<Bool>;
	public var value:Int;
	public var weight:Int;
	public function new(resultVector:Vector<Bool>, value:Int, weight:Int = 0) 
	{
		this.resultVector = resultVector;
		this.value = value;
		this.weight = weight;
	}
	
}