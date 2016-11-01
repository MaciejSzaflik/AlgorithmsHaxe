package algo;
import algo.problems.hanoi.BFS;
import algo.problems.hanoi.Hanoi;
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
	var hanoiSizeInput : InputElement;
	public function new() 
	{
		taken = -1;
		
		Utils.addParagraph("Disc count:");
		hanoiSizeInput = Utils.addInputElement("5");
		var createBut  = Utils.addButton("Create hanoi", function(event) {
			createHanoi(Std.parseInt(hanoiSizeInput.value));
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
		Utils.addButton("bfs", function(event) {
			var bfs = new BFS(Hanoi.createCopy(hanoi));
			
			if (bfsPar == null)
				bfsPar = Utils.addParagraph();
			if (bfsParAdditional == null)
				bfsParAdditional = Utils.addParagraph();
			
			bfsPar.textContent = "BFS: " + Std.string(bfs.findState(hanoi.generateEndStateId()));
			bfsParAdditional.textContent = "BFS Nodes dicovered: " + bfs.counter;
        });
		Browser.document.body.appendChild(Browser.document.createHRElement());
		
		createCanvas();
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
		canvas.width = 600;
		ctx = canvas.getContext2d();
		Browser.document.body.appendChild(canvas);
	}
	
	private function createHanoi(numberOfDisc : Int)
	{
		colorsToDisc = new Map<Int,String>();
		hanoi = new Hanoi(3, numberOfDisc);
		drawState(hanoi.state.values);
		Browser.document.body.appendChild(Browser.document.createHRElement());
	}
	
	
	private function redrawState()
	{
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		drawState(hanoi.state.values);
		statePar.textContent = hanoi.state.generateStateId() + " " + Std.string(hanoi.generateValidMoves());
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