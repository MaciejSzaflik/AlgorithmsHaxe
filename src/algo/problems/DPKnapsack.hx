package algo.problems;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class DPKnapsack
{

	public static function solve(knapsack:BinaryKnapsack):Result
	{
		var n = knapsack.values.length;
		var W = knapsack.capacity;
		var rows = new Vector<Vector<Int>>(n+1);
		var i = 0;
		while (i <= n)
		{
			rows[i] = new Vector<Int>(W + 1);
			
			var j = 0;
			while (j <= W)
			{
				rows[i][j] = 0;
				j++;
			}
			i++;
		}
		
		i = 1;
		while (i <= n)
		{
			var w = 0;
			while (w <= W)
			{
				var wi = knapsack.weights[i - 1];
				var bi = knapsack.values[i - 1];
				if (wi <= w)
				{
					if (bi + rows[i - 1][w - wi] > rows[i - 1][w])
						rows[i][w] = bi + rows[i - 1][w - wi];
					else
						rows[i][w] = rows[i-1][w];
				}
				else
				{
					rows[i][w] = rows[i - 1][w];
				}
				w++;
			}
			i++;
		}
		var vector = traceResult(knapsack, rows);
		return new Result(vector, knapsack.evaluateValue(vector));
	}
	
	public static function traceResult(knapsack:BinaryKnapsack,table:Vector<Vector<Int>>):Vector<Bool>
	{
		var v = new Vector<Bool>(knapsack.values.length);
		var j = 0;
		while (j < knapsack.values.length)
		{
			v[j] = false;
			j++;
		}
		
		var n = knapsack.values.length;
		var W = knapsack.capacity;
		var i = n;
		var k = W;
		while (i > 0 && k > 0)
		{
				if (table[i][k] != table[i - 1][k])
				{
					v[i-1] = true;
					k = k - knapsack.weights[i - 1];
					i = i - 1;
				}
				else
					i = i - 1;
		}
		return v;
	}
	
	
}