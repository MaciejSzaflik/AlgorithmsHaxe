package algo;
import haxe.ds.Vector;
/**
 * ...
 * @author 
 */
class Utils
{
	public static function copyVec(items:Vector<Bool>):Vector<Bool>
	{
		var toReturn = new Vector<Bool>(items.length);
		var index = 0;
		for (item in items)
		{
			toReturn[index] = item;
			index++;
		}
		return toReturn;
	}
	
}