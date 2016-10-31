package algo;
import algo.problems.Hanoi;
import haxe.ds.HashMap;
import js.Browser;
import js.html.ButtonElement;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
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
	public function new() 
	{
		taken = -1;
		Utils.addButton("knapsack", function(event) {
			Browser.location.assign("/index.html");
        });
		Utils.addButton("iterativ", function(event) {
			hanoi.simpleIterativ();
			redrawState();
        });
		Browser.document.body.appendChild(Browser.document.createHRElement());
		
		createCanvas();
		createHanoi();
		createHanoiButtons();
	}
	
	private function createHanoiButtons()
	{
		hanoiButtons = new Array<ButtonElement>();
		var index = 0;
		for (item in hanoi.state)
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
	
	private function createHanoi()
	{
		colorsToDisc = new Map<Int,String>();
		hanoi = new Hanoi(3, 4);
		drawState(hanoi.state);
		Browser.document.body.appendChild(Browser.document.createHRElement());
	}
	
	
	private function redrawState()
	{
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		drawState(hanoi.state);
	}
	
	
	public function drawState(state : Array<List<Int>>)
	{
		var height = canvas.height;
		var widthStep = canvas.width / hanoi.state.length;
		for (i in 0 ... hanoi.state.length)
		{
			drawRect(widthStep * i + widthStep / 2, height - height*0.8, height*0.8, 20, '#000000');
			var j = 0;
			for (item in hanoi.state[i])
			{
				var color =  colorsToDisc.exists(item) ? colorsToDisc.get(item):  '#' + StringTools.hex(getColor(), 6);
				var itemW = item * 16 + 40;
				colorsToDisc.set(item, color);
				var yPos = hanoi.state[i].length - j;
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