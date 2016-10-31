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
	
	public function averageItemValue ()
	{
		var sum = 0;
		for (valye in values)
		{
			sum += valye;
		}
		return sum / values.length;
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
	
	public function generateRandomSolution():Result
	{
		var v = new Vector<Bool>(values.length);
		var index = 0;
		var sum = 0;
		var valueSum = 0;
		while (index < v.length)
		{
			var result = Random.bool();
			if (result)
			{
				v[index] = (weights[index] + sum <= capacity);
				if (v[index])
				{
					sum += weights[index];
					valueSum += values[index];
				}
			}
			else
				v[index] = false;
			index++;
		}
		return new Result(v,valueSum,sum);
	}
	
	public function generateNeighbour(current:Vector<Bool>,number:Int):Result
	{
		var copyV = Utils.copyVec(current);
		var result = null;
		
		var index = 0;
		while (index < number)
		{
			var indexToChange = Random.int(0, current.length - 1);
			copyV[indexToChange] = !copyV[indexToChange];
			index++;
		}
		result = fillResult(copyV);
		return recalculateResult(result);
	}
	
	public function fillResult(items:Vector<Bool>):Result
	{
		var sumV = 0;
		var sumW = 0;
		var index = 0;
		for (item in items)
		{
			if (item)
			{
				sumW += weights[index];
				sumV += values[index];
			}
			index++;
		}
		return new Result(items, sumV, sumW);
	}
	
	public function recalculateResult(child:Result):Result
	{
		var index = 0;
		var valueSum = 0;
		var weightSum = 0;
		while (index < child.resultVector.length)
		{
			if (child.resultVector[index])
			{
				if (weightSum + weights[index] > capacity)
				{
					child.resultVector[index] = false;
				}
				else
				{
					weightSum += weights[index];
					valueSum += values[index];
				}
			}
			index++;
		}
		child.weight = weightSum;
		child.value = valueSum;
		return child;
	}
	
	
	public function evaluateWeight(items:Vector<Bool>):Int
	{
		var sum = 0;
		var index = 0;
		for (item in items)
		{
			if (item)
			{
				sum += weights[index];
			}
			index++;
		}
		return sum;
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