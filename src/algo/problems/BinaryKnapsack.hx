package algo.problems;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class BinaryKnapsack
{
	public var values:Array<Int>;
	public var weights:Array<Int>;
	public var capacity:Int;
	
	public function new() 
	{
		
	}
	
	public static function initInstance(capacity:Int, values:Array<Int>, weights:Array<Int>)
	{
		var knapsack = new BinaryKnapsack();
		knapsack.capacity = capacity;
		knapsack.values = values;
		knapsack.weights = weights;
		return knapsack;
	}
	
	public static function generateInstance(capacity:Int, numberOfItems:Int, weightBottom:Int, weightTop:Int, valueBottom:Int, valueTop:Int):BinaryKnapsack
	{
		var knapsack = new BinaryKnapsack();
		knapsack.capacity = capacity;
		knapsack.values = new Array<Int>();
		knapsack.weights = new Array<Int>();
		var index = 0;
		while (index < numberOfItems)
		{
			knapsack.values.push(Random.int(valueBottom, valueTop));
			knapsack.weights.push(Random.int(weightBottom, weightTop));
			index++;
		}
		return knapsack;
	}
	
	public function toBinaryVector(items:Array<Int>):Array<Bool>
	{
		var binary = new Array<Bool>();
		var index = 0;
		while (index < values.length)
		{
			binary[index] = (values.indexOf(items[index]) != -1);
			index++;
		}
		return binary;
	}
	
	public function evaluateValue(items:Vector<Bool>):Int
	{
		var sum = 0;
		var index = 0;
		for (item in items)
		{
			if (item)
			{
				sum += values[index];
			}
			index++;
		}
		return sum;
	}
	
	public function getValuesDebug():String
	{
		var sb = new StringBuf();
		for (value in values)
		{
			sb.add(value);
			sb.add(" ");
		}
		return sb.toString();
	}
	
	public function getWeightDebug():String
	{
		var sb = new StringBuf();
		for (value in weights)
		{
			sb.add(value);
			sb.add(" ");
		}
		return sb.toString();
	}
	
}