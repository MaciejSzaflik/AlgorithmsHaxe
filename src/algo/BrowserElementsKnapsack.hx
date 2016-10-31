package algo;
import algo.problems.BinaryKnapsack;
import algo.problems.DPKnapsack;
import algo.problems.GeneticAlgorithm;
import algo.problems.ProblemSolver;
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
class BrowserElementsKnapsack
{
	var weightPara:ParagraphElement;
	var valuePara:ParagraphElement;
	var resultPara:ParagraphElement;
	
	var testOnePara:ParagraphElement;
	
	var weightInput:InputElement;
	var valueInput:InputElement;
	var capacityInput:InputElement;
	var countInput:InputElement;
	var iterationInput:InputElement;
	var populationInput:InputElement;
	var mutatorInput:InputElement;
	var reconbinatorInput:InputElement;
	var terminatorInput:InputElement;
	
	var instance:BinaryKnapsack;
	var checkboxGenerate:InputElement;
	var keepCreated:InputElement;
	public function new() 
	{
		Utils.addButton("hanoi", function(event) {
			Browser.location.assign("/hanoi.html");
        });
		
		Utils.addParagraph("DP Binary Knapsack Solver");
		Utils.addParagraph("Weights Input:");
		weightInput = Utils.addInputElement("70, 73, 77, 80, 82, 87, 90, 94, 98, 106, 110, 113, 115, 118, 120");
		Utils.addParagraph("Values Input:");
		valueInput = Utils.addInputElement("135, 139, 149, 150, 156, 163, 173, 184, 192, 201, 210, 214, 221, 229, 240");
		Utils.addParagraph("Capacity Input:");
		capacityInput = Utils.addInputElement("750");
		Utils.addParagraph("Elements Count (only for generation):");
		countInput = Utils.addInputElement("5");
		Utils.addParagraph("Iteration counter (only for meta):");
		iterationInput = Utils.addInputElement("2000", 40);
		populationInput = Utils.addInputElement("50",20);
		mutatorInput = Utils.addInputElement("1.0",20);
		reconbinatorInput = Utils.addInputElement("0.7",20);
		terminatorInput = Utils.addInputElement("5",20);
		
		Browser.document.body.appendChild(Browser.document.createHRElement());
		Utils.addButton("calculate DP", function(event) {
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
		
		Utils.addButton("test", function(event) {
			creationDecide();
			generateOneAndPrint();
        });
		Utils.addButton("random search", function(event) {
			creationDecide();
			var iterations = Std.parseInt(iterationInput.value);
			var randomSearch = new RandomSearch(iterations,instance);
			problemSolverStart("rand", randomSearch);
        });
		Utils.addButton("sa", function(event) {
			creationDecide();
			var iterations = Std.parseInt(iterationInput.value);
			var mut = Std.parseInt(populationInput.value);
			var sa = new SimulatedAnnaling(iterations,mut,instance);
			problemSolverStart("sa", sa);
        });
		
		Utils.addButton("genetic", function(event) {
			creationDecide();
			
			var pop = Std.parseInt(populationInput.value);
			var mut = Std.parseFloat(mutatorInput.value);
			var recon = Std.parseFloat(reconbinatorInput.value);
			var ter = Std.parseInt(terminatorInput.value);
			
			var genetic = new GeneticAlgorithm(instance,pop,mut,recon,ter);
			problemSolverStart("gen", genetic);
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
	
	public function problemSolverStart(id:String,solver:ProblemSolver)
	{
		var result = solver.solve(true);
		var para = Utils.addParagraph();
		Browser.document.body.appendChild(Browser.document.createHRElement());
		
		para.textContent = "Solver: " + id + ": " + result.value  + " || I: " + result.resultVector + " || W:" + result.weight;
		fillGraphWithHistory(solver.history);
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
			testOnePara = Utils.addParagraph();
			Browser.document.body.appendChild(Browser.document.createHRElement());
		}
		var v = instance.generateRandomSolution();
		testOnePara.textContent = "R: "+ v.value + "|| I: " + v.resultVector + " || W:" + v.weight;
	}
	
	private function solveAndPrint(instance:BinaryKnapsack)
	{
		if (weightPara == null)
		{
			resultPara = Utils.addParagraph();
			weightPara = Utils.addParagraph();
			valuePara = Utils.addParagraph();
			Browser.document.body.appendChild(Browser.document.createHRElement());
		}
		
		var result = DPKnapsack.solve(instance);
		resultPara.textContent = "Result: " + result.value + " || " + result.resultVector;
		weightPara.textContent = "Weights: " + instance.getWeightDebug();
		valuePara.textContent = "Values: " + instance.getValuesDebug();
	}
	
	
}