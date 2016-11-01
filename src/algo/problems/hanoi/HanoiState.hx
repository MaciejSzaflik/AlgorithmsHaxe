package algo.problems.hanoi;
import algo.Pair;
import haxe.Constraints.Function;

/**
 * ...
 * @author 
 */
class HanoiState
{
	public var values : Array<List<Int>>;
	public var discNum : Int;
	public function new(discNum : Int, copy : HanoiState) 
	{
		this.discNum = discNum;
		values = new Array<List<Int>>();
		
		if (copy == null)
			return;
			
		for (i in 0 ... copy.values.length)
		{
			values[i] = new List<Int>();
			for (value in copy.values[i])
			{
				values[i].add(value);
			}
		}
	}
	
	public function firstPeg(peg:Int):Null<Int>
	{
		return values[peg].first();
	}
	
	public function changeState(move : Pair)
	{
		var value = values[move.x].pop();
		values[move.y].push(value);
	}
	
	public static function createStart(pegs:Int, disc:Int):HanoiState
	{
		var state = new HanoiState(disc,null);
		for (i in 0 ... pegs)
			state.values.push(new List<Int>());
			
		for (i in -disc ... 0)
			state.values[0].push( -i);
		state.discNum = disc;
		return state;
	}
	
	public function generateStateId():String
	{
		var id = new Array<Int>();
		for (i in 0 ... values.length)
		{
			for (disc in values[i])
			{
				id[disc - 1] = i;
			}
		}
		return Std.string(id);
	}
	
	public static function equals(a : HanoiState, b : HanoiState):Bool
	{
		return a.generateStateId() == b.generateStateId();
	}
}