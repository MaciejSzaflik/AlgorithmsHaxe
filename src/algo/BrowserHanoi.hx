package algo;
import algo.problems.hanoi.AStar;
import algo.problems.hanoi.BFS;
import algo.problems.hanoi.DFS;
import algo.problems.hanoi.Hanoi;
import algo.problems.hanoi.LargestMisplaced;
import algo.problems.hanoi.LargestMisplacedPower;
import algo.problems.hanoi.OnTopOfTheLargest;
import algo.problems.hanoi.OtherThenLast;
import haxe.ds.HashMap;
import js.Browser;
import js.html.ButtonElement;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.InputElement;
import js.html.ParagraphElement;
import js.html.ParamElement;
import js.html.RGBColor;

/**
 * ...
 * @author 
 */
class BrowserHanoi
{
	var ctx:CanvasRenderingContext2D;
	var canvas:CanvasElement;
	var hanoi:Hanoi;
	var colorsToDisc : Map<Int,String>;
	var hanoiButtons : Array<ButtonElement>;
	var taken : Int;
	var statePar : ParagraphElement;
	
	var bfsPar : ParagraphElement;
	var bfsParAdditional : ParagraphElement;
	
	var dfsPar : ParagraphElement;
	var dfsParAdditional : ParagraphElement;
	
	var hanoiSizeInput : InputElement;
	var hanoiRodsCountInput : InputElement;
	
	var eval1 : ParagraphElement;
	var eval2 : ParagraphElement;
	var eval3 : ParagraphElement;
	var eval4 : ParagraphElement;
	
	var eval1List : Array<Int>;
	var eval2List : Array<Int>;
	var eval3List : Array<Int>;
	var eval4List : Array<Int>;
	
	var astar_1 : ParagraphElement;
	var astar_2 : ParagraphElement;
	var astar_3 : ParagraphElement;
	var astar_4 : ParagraphElement;
	
	public function new() 
	{
		taken = -1;
		
		Utils.addParagraph("Disc count:");
		hanoiSizeInput = Utils.addInputElement("5", 20);
		hanoiRodsCountInput = Utils.addInputElement("5",20);
		var createBut  = Utils.addButton("Create hanoi", function(event) {
			createHanoi(Std.parseInt(hanoiSizeInput.value),Std.parseInt(hanoiRodsCountInput.value));
			createHanoiButtons();
			Utils.addParagraph(hanoi.generateEndStateId());
			statePar = Utils.addParagraph(hanoi.state.generateStateId() + " " + Std.string(hanoi.generateValidMoves()));
        });
		
		Utils.addButton("knapsack", function(event) {
			Browser.location.assign("/index.html");
        });
		Utils.addButton("iterativ", function(event) {
			hanoi.simpleIterativ();
			redrawState();
        });
		Utils.addButton("print evals", function(event) {
			trace(eval1List.toString());
			trace(eval2List.toString());
			trace(eval3List.toString());
			trace(eval4List.toString());
        });
		
		
		Utils.addButton("iterativ-toEnd", function(event) {
			while (hanoi.state.generateStateId() != hanoi.generateEndStateId())
			{
				hanoi.simpleIterativ();
				redrawState();
			}
        });
		Utils.addButton("bfs", function(event) {
			var bfs = new BFS(Hanoi.createCopy(hanoi));
			
			if (bfsPar == null)
				bfsPar = Utils.addParagraph();
			if (bfsParAdditional == null)
				bfsParAdditional = Utils.addParagraph();
			
			var path = bfs.findState(hanoi.generateEndStateId());
			bfsPar.textContent = "BFS: " + " len:" + path.length;
			bfsParAdditional.textContent = "BFS Nodes dicovered: " + bfs.counter;
        });
		
		Utils.addButton("dfs", function(event) {
			var dfs = new DFS(Hanoi.createCopy(hanoi));
			
			if (dfsPar == null)
				dfsPar = Utils.addParagraph();
			if (dfsParAdditional == null)
				dfsParAdditional = Utils.addParagraph();
			
			var path = dfs.findState(hanoi.generateEndStateId());
			dfsPar.textContent = "DFS: " + " len:" + path.length;
			dfsParAdditional.textContent = "DFS Nodes dicovered: " + dfs.counter;
        });
		
		addAStarButton();
		
		
		Browser.document.body.appendChild(Browser.document.createHRElement());
		
		createCanvas();
	}
	
	private function addAStarButton()
	{
		Utils.addButton("A Star 1", function(event) {
			var eval_0 = new OtherThenLast();
			var astar_0_alg = new AStar(hanoi, eval_0);
			if (astar_1 == null)
				astar_1 = Utils.addParagraph();
			
			var path0 = astar_0_alg.solve(hanoi.generateEndStateId());
			astar_1.textContent = "OtherThenLast: " +  astar_0_alg.counter + " path: "  + " len:" + path0.length;
		});
		
		Utils.addButton("A Star 2", function(event) {
			var eval_1 = new OnTopOfTheLargest();
			var astar_1_alg = new AStar(hanoi, eval_1);
			if (astar_2 == null)
				astar_2 = Utils.addParagraph();
			
			var path1 = astar_1_alg.solve(hanoi.generateEndStateId());
			astar_2.textContent = "OnTopOfTheLargest: " +  astar_1_alg.counter + " path: "  + " len:" + path1.length;
		});
		Utils.addButton("A Star 3", function(event) {
			var eval_2 = new LargestMisplaced();
			var astar_2_alg = new AStar(hanoi, eval_2);
			if (astar_3 == null)
				astar_3 = Utils.addParagraph();
			
			var path2 = astar_2_alg.solve(hanoi.generateEndStateId());
			astar_3.textContent = "LargestMisplaced: " +  astar_2_alg.counter + " path: "  + " len:" + path2.length;
		});
		Utils.addButton("A Star 4", function(event) {
			
			var eval_3 = new LargestMisplacedPower();
			var astar_3_alg = new AStar(hanoi, eval_3);
			if (astar_4 == null)
				astar_4 = Utils.addParagraph();
				
			var path3 = astar_3_alg.solve(hanoi.generateEndStateId());
			astar_4.textContent = "LargestMisplacedPower: " +  astar_3_alg.counter + " path: " + " len:" + path3.length;
        });
	}
	
	
	private function addAndUpdateEvaluators()
	{
		if (eval1 == null)
		{
			Browser.document.body.appendChild(Browser.document.createHRElement());
			eval1 = Utils.addParagraph();
			eval2 = Utils.addParagraph();
			eval3 = Utils.addParagraph();
			eval4 = Utils.addParagraph();
			Browser.document.body.appendChild(Browser.document.createHRElement());
			eval1List = new Array<Int>();
			eval2List = new Array<Int>();
			eval3List = new Array<Int>();
			eval4List = new Array<Int>();
		}
		var eval_0 = new OtherThenLast();
		var eval_1 = new OnTopOfTheLargest();
		var eval_2 = new LargestMisplaced();
		var eval_3 = new LargestMisplacedPower();
		
		var value0 = eval_0.evaluate(hanoi.state);
		var value1 = eval_1.evaluate(hanoi.state);
		var value2 = eval_2.evaluate(hanoi.state);
		var value3 = eval_3.evaluate(hanoi.state);
		eval1.textContent = "OTL: " + value0;
		eval2.textContent = "OnTL: " + value1;
		eval3.textContent = "LM: " + value2;
		eval4.textContent = "LMP: " + value3;
		
		eval1List.push(value0);
		eval2List.push(value1);
		eval3List.push(value2);
		eval4List.push(value3);

	}
	
	private function createHanoiButtons()
	{
		hanoiButtons = new Array<ButtonElement>();
		var index = 0;
		for (item in hanoi.state.values)
		{
			var realI = index;
			var button = Utils.addButton("Take:" + index, function(event) {
					if (taken == -1)
						taken = realI;
					else
					{
						hanoi.changeRod(taken, realI);
						taken = -1;
						redrawState();
					}
					changeButtonText();
			});
			hanoiButtons.push(button);
			index++;
		}
	}
	
	private function changeButtonText()
	{
		for (i in 0 ... hanoiButtons.length)
			hanoiButtons[i].textContent = taken == -1 ? "Take:" + i : "Put:" + i;
	}
	
	private function createCanvas()
	{
		canvas = Browser.document.createCanvasElement();
		canvas.height = 300;
		canvas.width = 1200;
		ctx = canvas.getContext2d();
		Browser.document.body.appendChild(canvas);
	}
	
	private function createHanoi(numberOfDisc : Int, numberOfRods : Int)
	{
		colorsToDisc = new Map<Int,String>();
		hanoi = new Hanoi(numberOfRods, numberOfDisc);
		drawState(hanoi.state.values);
		Browser.document.body.appendChild(Browser.document.createHRElement());
	}
	
	
	private function redrawState()
	{
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		drawState(hanoi.state.values);
		statePar.textContent = hanoi.state.generateStateId() + " " + Std.string(hanoi.generateValidMoves());
		addAndUpdateEvaluators();
	}
	
	
	public function drawState(state : Array<List<Int>>)
	{
		var height = canvas.height;
		var widthStep = canvas.width / hanoi.state.values.length;
		for (i in 0 ... hanoi.state.values.length)
		{
			drawRect(widthStep * i + widthStep / 2, height - height*0.8, height*0.8, 20, '#000000');
			var j = 0;
			for (item in hanoi.state.values[i])
			{
				var color =  colorsToDisc.exists(item) ? colorsToDisc.get(item):  '#' + StringTools.hex(getColor(), 6);
				var itemW = item * 16 + 40;
				colorsToDisc.set(item, color);
				var yPos = hanoi.state.values[i].length - j;
				drawRect(widthStep * i + widthStep / 2 - itemW/2 + 10,  height - (yPos)*20, 20,itemW,color);
				j++;
			}
		}
	}
	
	private function getColor()
	{
		var red = Math.floor(Math.random()*255);
		var green = Math.floor(Math.random()*255);
		var blue = Math.floor(Math.random()*255);
		var color = red << 16 | green << 8 | blue;
		return  color;
	}
	
	public function drawRect( x: Float, y: Float, height: Float, width: Float, color : String = '#ff0000')
    {
        ctx.fillStyle = color;
		ctx.fillRect(x, y, width, height);
    }
	
	public function drawCircle( x: Float, y: Float, radius: Float )
    {
        ctx.strokeStyle = '#000000';
        ctx.lineWidth = 1;
        ctx.fillStyle = '#ff0000';
        ctx.beginPath();
        ctx.arc( x + radius, y + radius, radius, 0, 2*Math.PI, false );
        ctx.stroke();
        ctx.closePath();
        ctx.fill();
    }
	
}