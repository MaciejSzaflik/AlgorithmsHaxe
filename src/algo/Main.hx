package algo;

import algo.problems.knapsack.BinaryKnapsack;
import algo.problems.knapsack.DPKnapsack;
import js.Lib;
import js.Browser;
import js.html.HTMLCollection;
/**
 * ...
 * @author 
 */
class Main 
{
	static function main() 
	{
		
		if (Browser.location.pathname.indexOf("index") != -1)
			var browserElements = new BrowserElementsKnapsack();
		else
			var browserElements = new BrowserHanoi();
	}
	
}