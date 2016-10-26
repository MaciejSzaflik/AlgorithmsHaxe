package algo;
import algo.problems.BinaryKnapsack;
import algo.problems.DPKnapsack;
import algo.problems.RandomSearch;
import algo.problems.SimulatedAnnaling;
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
	
	var testOnePara:ParagraphElement;
	var randomSearchPara:ParagraphElement;
	var saPara:ParagraphElement;
	
	var weightInput:InputElement;
	var valueInput:InputElement;
	var capacityInput:InputElement;
	var countInput:InputElement;
	var iterationInput:InputElement;
	
	var instance:BinaryKnapsack;
	var checkboxGenerate:InputElement;
	var keepCreated:InputElement;
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
		addParagraph("Iteration counter (only for meta):");
		iterationInput = addInputElement("2000");
		
		
		Browser.document.body.appendChild(Browser.document.createHRElement());
		addButton("calculate DP", function(event) {
			creationDecide();
			calculate();
        });
		checkboxGenerate = Browser.document.createInputElement();
		checkboxGenerate.type = "checkbox";
		checkboxGenerate.title = "generate";
		Browser.document.body.appendChild(checkboxGenerate);
		
		keepCreated = Browser.document.createInputElement();
		keepCreated.type = "checkbox";
		keepCreated.title = "keep";
		Browser.document.body.appendChild(keepCreated);
		
		addButton("test", function(event) {
			creationDecide();
			generateOneAndPrint();
        });
		addButton("random search", function(event) {
			creationDecide();
			randomSearchInput();
        });
		addButton("sa", function(event) {
			creationDecide();
			saInput();
        });
	}
	
	private function creationDecide()
	{
		if (keepCreated.checked && instance != null)
			return;
		if (checkboxGenerate.checked)
			parseAndRandom();
		else
			parseAndFromValues();
	}
	
	public function randomSearchInput()
	{
		var iterations = Std.parseInt(iterationInput.value);
		var randomSearch = new RandomSearch(instance);
		var result = randomSearch.solve(iterations,true);
		if (randomSearchPara == null)
		{
			randomSearchPara = addParagraph();
			Browser.document.body.appendChild(Browser.document.createHRElement());
		}
		randomSearchPara.textContent = "Random Search: " + result.value  + " || I: " + result.resultVector + " || W:" + result.weight;
		fillGraphWithHistory(randomSearch.history);
	}
	public function saInput()
	{
		var iterations = Std.parseInt(iterationInput.value);
		var sa = new SimulatedAnnaling(instance);
		var result = sa.solve(iterations,true);
		if (randomSearchPara == null)
		{
			saPara = addParagraph();
			Browser.document.body.appendChild(Browser.document.createHRElement());
		}
		randomSearchPara.textContent = "SA: " + result.value  + " || I: " + result.resultVector + " || W:" + result.weight;
		fillGraphWithHistory(sa.history);
	}
	
	private function fillGraphWithHistory(history:Array<Int>)
	{
		var h = Reflect.field(Browser.window, "data");
		
		var strings = new Array<String>();
		var index = 1;
		for (value in history)
		{
			strings.push(index + "");
			index++;
		}
		h.labels = strings;
		h.series[0] = history;
		untyped __js__("init()");
	}
	
	
	public function parseAndRandom()
	{
		var randsW = weightInput.value.split(",").map(function(f) return Std.parseInt(f));
		var randsV = valueInput.value.split(",").map(function(f) return Std.parseInt(f));
		var capacity = Std.parseInt(capacityInput.value);
		var count = Std.parseInt(countInput.value);
		if (randsW[0] > capacity)
		{
			Browser.alert("cannot create such instance");
			return;
		}
		instance = BinaryKnapsack.generateInstance(capacity, count, randsW[0], randsW[1], randsV[0], randsV[1]);
	}
	
	public function parseAndFromValues()
	{
		var weights = weightInput.value.split(",").map(function(f) return Std.parseInt(f));
		var values = valueInput.value.split(",").map(function(f) return Std.parseInt(f));
		var capacity = Std.parseInt(capacityInput.value);
		
		if (capacity == null || weights == null || values == null || weights.length != values.length)
		{
			Browser.alert("Bad arguments");
			return;
		}
		instance = BinaryKnapsack.initInstance(capacity, values, weights);
	}
	
	public function calculate()
	{
		if (instance == null)
			return;
		solveAndPrint(instance);
	}
	
	private function generateOneAndPrint()
	{
		if (testOnePara == null)
		{
			testOnePara = addParagraph();
			Browser.document.body.appendChild(Browser.document.createHRElement());
		}
		var v = instance.generateRandomSolution();
		testOnePara.textContent = "R: "+ v.value + "|| I: " + v.resultVector + " || W:" + v.weight;
	}
	
	private function solveAndPrint(instance:BinaryKnapsack)
	{
		if (weightPara == null)
		{
			resultPara = addParagraph();
			weightPara = addParagraph();
			valuePara = addParagraph();
			Browser.document.body.appendChild(Browser.document.createHRElement());
		}
		
		var result = DPKnapsack.solve(instance);
		resultPara.textContent = "Result: " + result.value + " || " + result.resultVector;
		weightPara.textContent = "Weights: " + instance.getWeightDebug();
		valuePara.textContent = "Values: " + instance.getValuesDebug();
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
	
	public function addParagraph(text:String = "yo"):ParagraphElement
	{
		var paragraph = Browser.document.createParagraphElement();
		paragraph.textContent = text;
		Browser.document.body.appendChild(paragraph);
		return paragraph;
	}
	
}