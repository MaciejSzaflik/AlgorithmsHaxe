package algo;
import algo.problems.BinaryKnapsack;
import algo.problems.DPKnapsack;
import haxe.Constraints.Function;
import js.Browser;
import js.html.ButtonElement;
import js.html.InputElement;
import js.html.ParagraphElement;

/**
 * ...
 * @author 
 */
class BrowserElements
{
	var weightPara:ParagraphElement;
	var valuePara:ParagraphElement;
	var resultPara:ParagraphElement;
	
	var weightInput:InputElement;
	var valueInput:InputElement;
	var capacityInput:InputElement;
	var countInput:InputElement;
	
	public function new() 
	{
		addParagraph("DP Binary Knapsack Solver");
		addParagraph("Weights Input:");
		weightInput = addInputElement("70, 73, 77, 80, 82, 87, 90, 94, 98, 106, 110, 113, 115, 118, 120");
		addParagraph("Values Input:");
		valueInput = addInputElement("135, 139, 149, 150, 156, 163, 173, 184, 192, 201, 210, 214, 221, 229, 240");
		addParagraph("Capacity Input:");
		capacityInput = addInputElement("750");
		addParagraph("Elements Count (only for generation):");
		countInput = addInputElement("5");
		
		Browser.document.body.appendChild(Browser.document.createHRElement());
		addButton("calculate",function(event) {
			calculate();
        });
		addButton("generate",function(event) {
			generate();
        });
	}
	public function generate()
	{
		var randsW = weightInput.value.split(",").map(function(f) return Std.parseInt(f));
		var randsV = weightInput.value.split(",").map(function(f) return Std.parseInt(f));
		var capacity = Std.parseInt(capacityInput.value);
		var count = Std.parseInt(countInput.value);
		
		var instance = BinaryKnapsack.generateInstance(capacity, count, randsW[0], randsW[1], randsV[0], randsV[1]);
		solveAndPrint(instance);
	}
	
	public function calculate()
	{
		var weights = weightInput.value.split(",").map(function(f) return Std.parseInt(f));
		var values = valueInput.value.split(",").map(function(f) return Std.parseInt(f));
		var capacity = Std.parseInt(capacityInput.value);
		
		if (capacity == null || weights == null || values == null || weights.length != values.length)
		{
			Browser.alert("Bad arguments");
			return;
		}
		var instance = BinaryKnapsack.initInstance(capacity, values, weights);
		solveAndPrint(instance);
	}
	
	private function solveAndPrint(instance:BinaryKnapsack)
	{
		weightPara = addParagraph("Weights: " + instance.getWeightDebug());
		valuePara = addParagraph("Values: " + instance.getValuesDebug());
		var result = DPKnapsack.solve(instance);
		resultPara = addParagraph("Result: "+ DPKnapsack.solve(instance) + " || " + instance.evaluateValue(result));
	}
	
	public function addButton(text:String,listener:Function):ButtonElement
	{
		var button = Browser.document.createButtonElement();
        button.textContent = text;
        button.onclick = listener;
        Browser.document.body.appendChild(button);
		return button;
	}
	
	public function addInputElement(initial:String = "hello"):InputElement
	{
		var input = Browser.document.createInputElement();
		input.size = 160;
		input.value = initial;
		Browser.document.body.appendChild(input);
		return input;
	}
	
	public function addParagraph(text:String):ParagraphElement
	{
		var paragraph = Browser.document.createParagraphElement();
		paragraph.textContent = text;
		Browser.document.body.appendChild(paragraph);
		return paragraph;
	}
	
}