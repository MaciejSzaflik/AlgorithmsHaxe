package algo;
import haxe.Constraints.Function;
import haxe.ds.Vector;
import js.Browser;
import js.html.ButtonElement;
import js.html.InputElement;
import js.html.ParagraphElement;
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
	
	public static function addButton(text:String,listener:Function):ButtonElement
	{
		var button = Browser.document.createButtonElement();
        button.textContent = text;
        button.onclick = listener;
        Browser.document.body.appendChild(button);
		return button;
	}
	
	public static function addInputElement(initial:String = "hello",size:Int = 160):InputElement
	{
		var input = Browser.document.createInputElement();
		input.size = size;
		input.value = initial;
		Browser.document.body.appendChild(input);
		return input;
	}
	
	public static function addParagraph(text:String = "yo"):ParagraphElement
	{
		var paragraph = Browser.document.createParagraphElement();
		paragraph.textContent = text;
		Browser.document.body.appendChild(paragraph);
		return paragraph;
	}
	
	
}