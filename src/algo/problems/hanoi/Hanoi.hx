package algo.problems.hanoi;
import algo.Pair;
import haxe.ds.Vector;

/**
 * ...
 * @author 
 */
class Hanoi
{
	public var rodNum:Int;
	public var discNum:Int;
	
	public var state:HanoiState;
	public var iteraivCounter = 0;
	public function new(rodNum:Int,discNum) 
	{
		this.rodNum = rodNum;
		this.discNum = discNum;
		this.state = HanoiState.createStart(rodNum, discNum);
	}
	
	public static function createCopy(hanoi:Hanoi):Hanoi
	{
		var copy = new Hanoi(hanoi.rodNum, hanoi.discNum);
		copy.state = new HanoiState(hanoi.discNum,hanoi.state);
		return copy;
	}
	
	public function generateValidMoves():Array<Pair>
	{
		var pairs = new Array<Pair>();
		for (i in 0 ... rodNum)
		{
			for (j in 0 ... rodNum)
			{
				if (checkChangeRod(state.values, i, j))
					pairs.push(new Pair(i,j));
			}
		}
		return pairs;
	}
	
	public function generatePosibleStates():Array<HanoiState>
	{
		var pairs = generateValidMoves();
		var states = new Array<HanoiState>();
		for (pair in pairs)
		{
			var copy = new HanoiState(discNum,state);
			copy.changeState(pair);
			states.push(copy);
		}
		return states;
	}
	
	
	public function generateEndStateId():String
	{
		var vec = new Vector<Int>(discNum);
		for (i in 0 ... discNum)
			vec[i] = rodNum - 1;
		return Std.string(vec);
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
	
	public static function checkChangeRod(checkedState:Array<List<Int>>, sourceR:Int, destinationR:Int):Bool
	{
		if (checkedState[sourceR].first() == null || sourceR == destinationR)
			return false;
		
		if (checkedState[destinationR].first() != null)
		{
			if (checkedState[sourceR].first() > checkedState[destinationR].first())
				return false;
		}
		return true;
	}
	
	
	public function changeRod(sourceR:Int, destinationR:Int):Bool
	{
		if (state.firstPeg(sourceR) == null || sourceR == destinationR)
			return false;
		
		if (state.firstPeg(destinationR) != null)
		{
			if (state.firstPeg(sourceR) > state.firstPeg(destinationR))
				return false;
		}
		
		state.changeState(new Pair(sourceR, destinationR));
		return true;
	}
	
}