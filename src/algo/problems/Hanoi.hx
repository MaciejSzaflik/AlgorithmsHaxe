package algo.problems;

/**
 * ...
 * @author 
 */
class Hanoi
{
	public var rodNum:Int;
	public var discNum:Int;
	
	public var state:Array<List<Int>>;
	public var iteraivCounter = 0;
	public function new(rodNum:Int,discNum) 
	{
		this.rodNum = rodNum;
		this.discNum = discNum;
		this.state = new Array<List<Int>>();
		for (i in 0 ... rodNum)
			this.state.push(new List<Int>());
			
		for (i in -discNum ... 0)
			this.state[0].push(-i);
	}
	
	public function simpleIterativ()
	{
		var source = 0;
		var aux = discNum % 2 == 0? 1 : 2;
		var dest = discNum % 2 == 0? 2: 1;
		if (iteraivCounter % 3 == 0)
		{
			if (!changeRod(source, aux))
				changeRod(aux, source);
		}
		if (iteraivCounter % 3 == 1)
		{
			if (!changeRod(source, dest))
				changeRod(dest, source);
		}
		if (iteraivCounter % 3 == 2)
		{
			if (!changeRod(aux, dest))
				changeRod(dest, aux);
		}
		iteraivCounter++;
	}
	
	
	public function changeRod(sourceR:Int, destinationR:Int):Bool
	{
		if (state[sourceR].first() == null || sourceR == destinationR)
			return false;
		
		if (state[destinationR].first() != null)
		{
			if (state[sourceR].first() > state[destinationR].first())
				return false;
		}
		
		var value = state[sourceR].pop();
		state[destinationR].push(value);
		return true;
	}
	
}