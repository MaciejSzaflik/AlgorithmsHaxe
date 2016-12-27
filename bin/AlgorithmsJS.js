(function (console) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Lambda = function() { };
Lambda.__name__ = true;
Lambda.array = function(it) {
	var a = [];
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var i = $it0.next();
		a.push(i);
	}
	return a;
};
var List = function() {
	this.length = 0;
};
List.__name__ = true;
List.prototype = {
	add: function(item) {
		var x = [item];
		if(this.h == null) this.h = x; else this.q[1] = x;
		this.q = x;
		this.length++;
	}
	,push: function(item) {
		var x = [item,this.h];
		this.h = x;
		if(this.q == null) this.q = x;
		this.length++;
	}
	,first: function() {
		if(this.h == null) return null; else return this.h[0];
	}
	,pop: function() {
		if(this.h == null) return null;
		var x = this.h[0];
		this.h = this.h[1];
		if(this.h == null) this.q = null;
		this.length--;
		return x;
	}
};
Math.__name__ = true;
var Random = function() { };
Random.__name__ = true;
Random.bool = function() {
	return Math.random() < 0.5;
};
Random["int"] = function(from,to) {
	return from + Math.floor((to - from + 1) * Math.random());
};
Random["float"] = function(from,to) {
	return from + (to - from) * Math.random();
};
Random.string = function(length,charactersToUse) {
	if(charactersToUse == null) charactersToUse = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	var str = "";
	var _g = 0;
	while(_g < length) {
		var i = _g++;
		str += charactersToUse.charAt(Math.floor((charactersToUse.length - 1 + 1) * Math.random()));
	}
	return str;
};
Random.date = function(earliest,latest) {
	var t = Random["float"](earliest.getTime(),latest.getTime());
	var d = new Date();
	d.setTime(t);
	return d;
};
Random.fromArray = function(arr) {
	if(arr != null && arr.length > 0) return arr[Math.floor((arr.length - 1 + 1) * Math.random())]; else return null;
};
Random.shuffle = function(arr) {
	if(arr != null) {
		var _g1 = 0;
		var _g = arr.length;
		while(_g1 < _g) {
			var i = _g1++;
			var j = Math.floor((arr.length - 1 + 1) * Math.random());
			var a = arr[i];
			var b = arr[j];
			arr[i] = b;
			arr[j] = a;
		}
	}
	return arr;
};
Random.fromIterable = function(it) {
	if(it != null) return Random.fromArray(Lambda.array(it)); else return null;
};
Random.enumConstructor = function(e) {
	if(e != null) return Random.fromArray(Type.allEnums(e)); else return null;
};
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		if (e instanceof js__$Boot_HaxeError) e = e.val;
		return null;
	}
};
Reflect.callMethod = function(o,func,args) {
	return func.apply(o,args);
};
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && !(f.__name__ || f.__ename__);
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std["int"] = function(x) {
	return x | 0;
};
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.hex = function(n,digits) {
	var s = "";
	var hexChars = "0123456789ABCDEF";
	do {
		s = hexChars.charAt(n & 15) + s;
		n >>>= 4;
	} while(n > 0);
	if(digits != null) while(s.length < digits) s = "0" + s;
	return s;
};
var Type = function() { };
Type.__name__ = true;
Type.createEnum = function(e,constr,params) {
	var f = Reflect.field(e,constr);
	if(f == null) throw new js__$Boot_HaxeError("No such constructor " + constr);
	if(Reflect.isFunction(f)) {
		if(params == null) throw new js__$Boot_HaxeError("Constructor " + constr + " need parameters");
		return Reflect.callMethod(e,f,params);
	}
	if(params != null && params.length != 0) throw new js__$Boot_HaxeError("Constructor " + constr + " does not need parameters");
	return f;
};
Type.allEnums = function(e) {
	return e.__empty_constructs__;
};
var algo_BrowserElementsKnapsack = function() {
	var _g = this;
	algo_Utils.addButton("hanoi",function(event) {
		window.location.assign("/hanoi.html");
	});
	algo_Utils.addParagraph("DP Binary Knapsack Solver");
	algo_Utils.addParagraph("Weights Input:");
	this.weightInput = algo_Utils.addInputElement("70, 73, 77, 80, 82, 87, 90, 94, 98, 106, 110, 113, 115, 118, 120");
	algo_Utils.addParagraph("Values Input:");
	this.valueInput = algo_Utils.addInputElement("135, 139, 149, 150, 156, 163, 173, 184, 192, 201, 210, 214, 221, 229, 240");
	algo_Utils.addParagraph("Capacity Input:");
	this.capacityInput = algo_Utils.addInputElement("750");
	algo_Utils.addParagraph("Elements Count (only for generation):");
	this.countInput = algo_Utils.addInputElement("5");
	algo_Utils.addParagraph("Iterations:");
	this.iterationInput = algo_Utils.addInputElement("2000",40);
	algo_Utils.addParagraph("Population/Neighors:");
	this.populationInput = algo_Utils.addInputElement("50",20);
	algo_Utils.addParagraph("Mutator/Start temperature:");
	this.mutatorInput = algo_Utils.addInputElement("0.99",20);
	algo_Utils.addParagraph("Reconbinator:");
	this.reconbinatorInput = algo_Utils.addInputElement("0.7",20);
	algo_Utils.addParagraph("Terminator:");
	this.terminatorInput = algo_Utils.addInputElement("5",20);
	var _this = window.document;
	this.selectionCheckbox = _this.createElement("input");
	this.selectionCheckbox.type = "checkbox";
	this.selectionCheckbox.title = "selectionCheckbox";
	window.document.body.appendChild(this.selectionCheckbox);
	this.crossingCheckBox = algo_Utils.addInputElement("Uniform",20);
	this.crossingCheckBox.title = "crossingCheckBox";
	window.document.body.appendChild(this.crossingCheckBox);
	window.document.body.appendChild((function($this) {
		var $r;
		var _this1 = window.document;
		$r = _this1.createElement("hr");
		return $r;
	}(this)));
	algo_Utils.addButton("calculate DP",function(event1) {
		_g.creationDecide();
		_g.calculate();
	});
	var _this2 = window.document;
	this.checkboxGenerate = _this2.createElement("input");
	this.checkboxGenerate.type = "checkbox";
	this.checkboxGenerate.title = "generate";
	window.document.body.appendChild(this.checkboxGenerate);
	var _this3 = window.document;
	this.keepCreated = _this3.createElement("input");
	this.keepCreated.type = "checkbox";
	this.keepCreated.title = "keep";
	window.document.body.appendChild(this.keepCreated);
	algo_Utils.addButton("test",function(event2) {
		_g.creationDecide();
		_g.generateOneAndPrint();
	});
	algo_Utils.addButton("random search",function(event3) {
		_g.creationDecide();
		var iterations = Std.parseInt(_g.iterationInput.value);
		var randomSearch = new algo_problems_knapsack_RandomSearch(iterations,_g.instance);
		_g.problemSolverStart("rand",randomSearch);
	});
	algo_Utils.addButton("sa",function(event4) {
		_g.creationDecide();
		var iterations1 = Std.parseInt(_g.iterationInput.value);
		var mut = Std.parseInt(_g.populationInput.value);
		var b = parseFloat(_g.mutatorInput.value);
		var sa = new algo_problems_knapsack_SimulatedAnnaling(iterations1,mut,_g.instance,b);
		_g.problemSolverStart("sa",sa);
	});
	algo_Utils.addButton("genetic",function(event5) {
		_g.creationDecide();
		var pop = Std.parseInt(_g.populationInput.value);
		var mut1 = parseFloat(_g.mutatorInput.value);
		var recon = parseFloat(_g.reconbinatorInput.value);
		var ter = Std.parseInt(_g.terminatorInput.value);
		var selection;
		if(_g.selectionCheckbox.checked) selection = algo_problems_knapsack_SelectionType.Roulette; else selection = algo_problems_knapsack_SelectionType.SimpleTournament;
		var crossing = Type.createEnum(algo_problems_knapsack_CrossingType,_g.crossingCheckBox.value);
		console.log(selection);
		console.log(crossing);
		var genetic = new algo_problems_knapsack_GeneticAlgorithm(_g.instance,pop,mut1,recon,ter,crossing,selection);
		_g.problemSolverStart("gen",genetic);
	});
	algo_Utils.addButton("test sa",function(event6) {
		_g.creationDecide();
		var sum = algo_problems_knapsack_DPKnapsack.solve(_g.instance).value;
		var sumHeu = 0.0;
		var sumTime = 0.0;
		var iterations2 = Std.parseInt(_g.iterationInput.value);
		var a = Std.parseInt(_g.populationInput.value);
		var b1 = parseFloat(_g.mutatorInput.value);
		var stamp = haxe_Timer.stamp();
		var sa1 = new algo_problems_knapsack_SimulatedAnnaling(iterations2,a,_g.instance,b1);
		var heurResult = sa1.solve(false);
		console.log(sum + ";" + heurResult.value + ";" + (haxe_Timer.stamp() - stamp) + ";" + heurResult.value / sum);
	});
};
algo_BrowserElementsKnapsack.__name__ = true;
algo_BrowserElementsKnapsack.prototype = {
	creationDecide: function() {
		if(this.keepCreated.checked && this.instance != null) return;
		if(this.checkboxGenerate.checked) this.parseAndRandom(); else this.parseAndFromValues();
	}
	,problemSolverStart: function(id,solver) {
		var result = solver.solve(true);
		var para = algo_Utils.addParagraph();
		window.document.body.appendChild((function($this) {
			var $r;
			var _this = window.document;
			$r = _this.createElement("hr");
			return $r;
		}(this)));
		para.textContent = "Solver: " + id + ": " + result.value + " || I: " + Std.string(result.resultVector) + " || W:" + result.weight;
		this.fillGraphWithHistory(solver.history);
	}
	,fillGraphWithHistory: function(history) {
		var h = Reflect.field(window,"data");
		var strings = [];
		var index = 1;
		var _g = 0;
		while(_g < history.length) {
			var value = history[_g];
			++_g;
			strings.push(index + "");
			index++;
		}
		h.labels = strings;
		h.series[0] = history;
		init();
	}
	,parseAndRandom: function() {
		var randsW = this.weightInput.value.split(",").map(function(f) {
			return Std.parseInt(f);
		});
		var randsV = this.valueInput.value.split(",").map(function(f1) {
			return Std.parseInt(f1);
		});
		var capacity = Std.parseInt(this.capacityInput.value);
		var count = Std.parseInt(this.countInput.value);
		if(randsW[0] > capacity) {
			js_Browser.alert("cannot create such instance");
			return;
		}
		this.instance = algo_problems_knapsack_BinaryKnapsack.generateInstance(capacity,count,randsW[0],randsW[1],randsV[0],randsV[1]);
	}
	,parseAndFromValues: function() {
		var weights = this.weightInput.value.split(",").map(function(f) {
			return Std.parseInt(f);
		});
		var values = this.valueInput.value.split(",").map(function(f1) {
			return Std.parseInt(f1);
		});
		var capacity = Std.parseInt(this.capacityInput.value);
		if(capacity == null || weights == null || values == null || weights.length != values.length) {
			js_Browser.alert("Bad arguments");
			return;
		}
		this.instance = algo_problems_knapsack_BinaryKnapsack.initInstance(capacity,values,weights);
	}
	,calculate: function() {
		if(this.instance == null) return;
		this.solveAndPrint(this.instance);
	}
	,generateOneAndPrint: function() {
		if(this.testOnePara == null) {
			this.testOnePara = algo_Utils.addParagraph();
			window.document.body.appendChild((function($this) {
				var $r;
				var _this = window.document;
				$r = _this.createElement("hr");
				return $r;
			}(this)));
		}
		var v = this.instance.generateRandomSolution();
		this.testOnePara.textContent = "R: " + v.value + "|| I: " + Std.string(v.resultVector) + " || W:" + v.weight;
	}
	,solveAndPrint: function(instance) {
		if(this.weightPara == null) {
			this.resultPara = algo_Utils.addParagraph();
			this.weightPara = algo_Utils.addParagraph();
			this.valuePara = algo_Utils.addParagraph();
			window.document.body.appendChild((function($this) {
				var $r;
				var _this = window.document;
				$r = _this.createElement("hr");
				return $r;
			}(this)));
		}
		var result = algo_problems_knapsack_DPKnapsack.solve(instance);
		this.resultPara.textContent = "Result: " + result.value + " || " + Std.string(result.resultVector);
		this.weightPara.textContent = "Weights: " + instance.getWeightDebug();
		this.valuePara.textContent = "Values: " + instance.getValuesDebug();
	}
};
var algo_BrowserHanoi = function() {
	var _g = this;
	this.taken = -1;
	algo_Utils.addParagraph("Disc count:");
	this.hanoiSizeInput = algo_Utils.addInputElement("5",20);
	this.hanoiRodsCountInput = algo_Utils.addInputElement("5",20);
	var createBut = algo_Utils.addButton("Create hanoi",function(event) {
		_g.createHanoi(Std.parseInt(_g.hanoiSizeInput.value),Std.parseInt(_g.hanoiRodsCountInput.value));
		_g.createHanoiButtons();
		algo_Utils.addParagraph(_g.hanoi.generateEndStateId());
		_g.statePar = algo_Utils.addParagraph(_g.hanoi.state.generateStateId() + " " + Std.string(_g.hanoi.generateValidMoves()));
	});
	algo_Utils.addButton("knapsack",function(event1) {
		window.location.assign("/index.html");
	});
	algo_Utils.addButton("iterativ",function(event2) {
		_g.hanoi.simpleIterativ();
		_g.redrawState();
	});
	algo_Utils.addButton("print evals",function(event3) {
		console.log(_g.eval1List.toString());
		console.log(_g.eval2List.toString());
		console.log(_g.eval3List.toString());
		console.log(_g.eval4List.toString());
	});
	algo_Utils.addButton("iterativ-toEnd",function(event4) {
		while(_g.hanoi.state.generateStateId() != _g.hanoi.generateEndStateId()) {
			_g.hanoi.simpleIterativ();
			_g.redrawState();
		}
	});
	algo_Utils.addButton("bfs",function(event5) {
		var bfs = new algo_problems_hanoi_BFS(algo_problems_hanoi_Hanoi.createCopy(_g.hanoi));
		if(_g.bfsPar == null) _g.bfsPar = algo_Utils.addParagraph();
		if(_g.bfsParAdditional == null) _g.bfsParAdditional = algo_Utils.addParagraph();
		var path = bfs.findState(_g.hanoi.generateEndStateId());
		_g.bfsPar.textContent = "BFS: " + " len:" + path.length;
		_g.bfsParAdditional.textContent = "BFS Nodes dicovered: " + bfs.counter;
	});
	algo_Utils.addButton("dfs",function(event6) {
		var dfs = new algo_problems_hanoi_DFS(algo_problems_hanoi_Hanoi.createCopy(_g.hanoi));
		if(_g.dfsPar == null) _g.dfsPar = algo_Utils.addParagraph();
		if(_g.dfsParAdditional == null) _g.dfsParAdditional = algo_Utils.addParagraph();
		var path1 = dfs.findState(_g.hanoi.generateEndStateId());
		_g.dfsPar.textContent = "DFS: " + " len:" + path1.length;
		_g.dfsParAdditional.textContent = "DFS Nodes dicovered: " + dfs.counter;
	});
	this.addAStarButton();
	window.document.body.appendChild((function($this) {
		var $r;
		var _this = window.document;
		$r = _this.createElement("hr");
		return $r;
	}(this)));
	this.createCanvas();
};
algo_BrowserHanoi.__name__ = true;
algo_BrowserHanoi.prototype = {
	addAStarButton: function() {
		var _g = this;
		algo_Utils.addButton("A Star 1",function(event) {
			var eval_0 = new algo_problems_hanoi_OtherThenLast();
			var astar_0_alg = new algo_problems_hanoi_AStar(_g.hanoi,eval_0);
			if(_g.astar_1 == null) _g.astar_1 = algo_Utils.addParagraph();
			var path0 = astar_0_alg.solve(_g.hanoi.generateEndStateId());
			_g.astar_1.textContent = "OtherThenLast: " + astar_0_alg.counter + " path: " + " len:" + path0.length;
		});
		algo_Utils.addButton("A Star 2",function(event1) {
			var eval_1 = new algo_problems_hanoi_OnTopOfTheLargest();
			var astar_1_alg = new algo_problems_hanoi_AStar(_g.hanoi,eval_1);
			if(_g.astar_2 == null) _g.astar_2 = algo_Utils.addParagraph();
			var path1 = astar_1_alg.solve(_g.hanoi.generateEndStateId());
			_g.astar_2.textContent = "OnTopOfTheLargest: " + astar_1_alg.counter + " path: " + " len:" + path1.length;
		});
		algo_Utils.addButton("A Star 3",function(event2) {
			var eval_2 = new algo_problems_hanoi_LargestMisplaced();
			var astar_2_alg = new algo_problems_hanoi_AStar(_g.hanoi,eval_2);
			if(_g.astar_3 == null) _g.astar_3 = algo_Utils.addParagraph();
			var path2 = astar_2_alg.solve(_g.hanoi.generateEndStateId());
			_g.astar_3.textContent = "LargestMisplaced: " + astar_2_alg.counter + " path: " + " len:" + path2.length;
		});
		algo_Utils.addButton("A Star 4",function(event3) {
			var eval_3 = new algo_problems_hanoi_LargestMisplacedPower();
			var astar_3_alg = new algo_problems_hanoi_AStar(_g.hanoi,eval_3);
			if(_g.astar_4 == null) _g.astar_4 = algo_Utils.addParagraph();
			var path3 = astar_3_alg.solve(_g.hanoi.generateEndStateId());
			_g.astar_4.textContent = "LargestMisplacedPower: " + astar_3_alg.counter + " path: " + " len:" + path3.length;
		});
	}
	,addAndUpdateEvaluators: function() {
		if(this.eval1 == null) {
			window.document.body.appendChild((function($this) {
				var $r;
				var _this = window.document;
				$r = _this.createElement("hr");
				return $r;
			}(this)));
			this.eval1 = algo_Utils.addParagraph();
			this.eval2 = algo_Utils.addParagraph();
			this.eval3 = algo_Utils.addParagraph();
			this.eval4 = algo_Utils.addParagraph();
			window.document.body.appendChild((function($this) {
				var $r;
				var _this1 = window.document;
				$r = _this1.createElement("hr");
				return $r;
			}(this)));
			this.eval1List = [];
			this.eval2List = [];
			this.eval3List = [];
			this.eval4List = [];
		}
		var eval_0 = new algo_problems_hanoi_OtherThenLast();
		var eval_1 = new algo_problems_hanoi_OnTopOfTheLargest();
		var eval_2 = new algo_problems_hanoi_LargestMisplaced();
		var eval_3 = new algo_problems_hanoi_LargestMisplacedPower();
		var value0 = eval_0.evaluate(this.hanoi.state);
		var value1 = eval_1.evaluate(this.hanoi.state);
		var value2 = eval_2.evaluate(this.hanoi.state);
		var value3 = eval_3.evaluate(this.hanoi.state);
		this.eval1.textContent = "OTL: " + value0;
		this.eval2.textContent = "OnTL: " + value1;
		this.eval3.textContent = "LM: " + value2;
		this.eval4.textContent = "LMP: " + value3;
		this.eval1List.push(value0);
		this.eval2List.push(value1);
		this.eval3List.push(value2);
		this.eval4List.push(value3);
	}
	,createHanoiButtons: function() {
		var _g2 = this;
		this.hanoiButtons = [];
		var index = 0;
		var _g = 0;
		var _g1 = this.hanoi.state.values;
		while(_g < _g1.length) {
			var item = _g1[_g];
			++_g;
			var realI = [index];
			var button = algo_Utils.addButton("Take:" + index,(function(realI) {
				return function(event) {
					if(_g2.taken == -1) _g2.taken = realI[0]; else {
						_g2.hanoi.changeRod(_g2.taken,realI[0]);
						_g2.taken = -1;
						_g2.redrawState();
					}
					_g2.changeButtonText();
				};
			})(realI));
			this.hanoiButtons.push(button);
			index++;
		}
	}
	,changeButtonText: function() {
		var _g1 = 0;
		var _g = this.hanoiButtons.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.taken == -1) this.hanoiButtons[i].textContent = "Take:" + i; else this.hanoiButtons[i].textContent = "Put:" + i;
		}
	}
	,createCanvas: function() {
		var _this = window.document;
		this.canvas = _this.createElement("canvas");
		this.canvas.height = 300;
		this.canvas.width = 1200;
		this.ctx = this.canvas.getContext("2d",null);
		window.document.body.appendChild(this.canvas);
	}
	,createHanoi: function(numberOfDisc,numberOfRods) {
		this.colorsToDisc = new haxe_ds_IntMap();
		this.hanoi = new algo_problems_hanoi_Hanoi(numberOfRods,numberOfDisc);
		this.drawState(this.hanoi.state.values);
		window.document.body.appendChild((function($this) {
			var $r;
			var _this = window.document;
			$r = _this.createElement("hr");
			return $r;
		}(this)));
	}
	,redrawState: function() {
		this.ctx.clearRect(0,0,this.canvas.width,this.canvas.height);
		this.drawState(this.hanoi.state.values);
		this.statePar.textContent = this.hanoi.state.generateStateId() + " " + Std.string(this.hanoi.generateValidMoves());
		this.addAndUpdateEvaluators();
	}
	,drawState: function(state) {
		var height = this.canvas.height;
		var widthStep = this.canvas.width / this.hanoi.state.values.length;
		var _g1 = 0;
		var _g = this.hanoi.state.values.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.drawRect(widthStep * i + widthStep / 2,height - height * 0.8,height * 0.8,20,"#000000");
			var j = 0;
			var _g2_head = this.hanoi.state.values[i].h;
			var _g2_val = null;
			while(_g2_head != null) {
				var item;
				item = (function($this) {
					var $r;
					_g2_val = _g2_head[0];
					_g2_head = _g2_head[1];
					$r = _g2_val;
					return $r;
				}(this));
				var color;
				if(this.colorsToDisc.h.hasOwnProperty(item)) color = this.colorsToDisc.h[item]; else color = "#" + StringTools.hex(this.getColor(),6);
				var itemW = item * 16 + 40;
				this.colorsToDisc.h[item] = color;
				var yPos = this.hanoi.state.values[i].length - j;
				this.drawRect(widthStep * i + widthStep / 2 - itemW / 2 + 10,height - yPos * 20,20,itemW,color);
				j++;
			}
		}
	}
	,getColor: function() {
		var red = Math.floor(Math.random() * 255);
		var green = Math.floor(Math.random() * 255);
		var blue = Math.floor(Math.random() * 255);
		var color = red << 16 | green << 8 | blue;
		return color;
	}
	,drawRect: function(x,y,height,width,color) {
		if(color == null) color = "#ff0000";
		this.ctx.fillStyle = color;
		this.ctx.fillRect(x,y,width,height);
	}
	,drawCircle: function(x,y,radius) {
		this.ctx.strokeStyle = "#000000";
		this.ctx.lineWidth = 1;
		this.ctx.fillStyle = "#ff0000";
		this.ctx.beginPath();
		this.ctx.arc(x + radius,y + radius,radius,0,2 * Math.PI,false);
		this.ctx.stroke();
		this.ctx.closePath();
		this.ctx.fill();
	}
};
var algo_Main = function() { };
algo_Main.__name__ = true;
algo_Main.main = function() {
	if(window.location.pathname.indexOf("index") != -1) {
		var browserElements = new algo_BrowserElementsKnapsack();
	} else {
		var browserElements1 = new algo_BrowserHanoi();
	}
};
var algo_Pair = function(x,y) {
	this.x = x;
	this.y = y;
};
algo_Pair.__name__ = true;
var algo_Utils = function() { };
algo_Utils.__name__ = true;
algo_Utils.copyVec = function(items) {
	var toReturn;
	var this1;
	this1 = new Array(items.length);
	toReturn = this1;
	var index = 0;
	var _g = 0;
	while(_g < items.length) {
		var item = items[_g];
		++_g;
		toReturn[index] = item;
		index++;
	}
	return toReturn;
};
algo_Utils.addButton = function(text,listener) {
	var button;
	var _this = window.document;
	button = _this.createElement("button");
	button.textContent = text;
	button.onclick = listener;
	window.document.body.appendChild(button);
	return button;
};
algo_Utils.addInputElement = function(initial,size) {
	if(size == null) size = 160;
	if(initial == null) initial = "hello";
	var input;
	var _this = window.document;
	input = _this.createElement("input");
	input.size = size;
	input.value = initial;
	window.document.body.appendChild(input);
	return input;
};
algo_Utils.addParagraph = function(text) {
	if(text == null) text = "yo";
	var paragraph;
	var _this = window.document;
	paragraph = _this.createElement("p");
	paragraph.textContent = text;
	window.document.body.appendChild(paragraph);
	return paragraph;
};
var algo_problems_hanoi_AStar = function(hanoi,evaluator) {
	this.hanoi = algo_problems_hanoi_Hanoi.createCopy(hanoi);
	this.evaluator = evaluator;
};
algo_problems_hanoi_AStar.__name__ = true;
algo_problems_hanoi_AStar.prototype = {
	solve: function(endstate) {
		this.counter = 0;
		var closetSet = new haxe_ds_StringMap();
		var openSet = new haxe_ds_StringMap();
		var fScore = new haxe_ds_StringMap();
		var gScore = new haxe_ds_StringMap();
		var idToState = new haxe_ds_StringMap();
		var cameFrom = new haxe_ds_StringMap();
		var firstId = this.hanoi.state.generateStateId();
		{
			if(__map_reserved[firstId] != null) cameFrom.setReserved(firstId,""); else cameFrom.h[firstId] = "";
			"";
		}
		var v = new algo_problems_hanoi_HanoiState(this.hanoi.discNum,this.hanoi.state);
		if(__map_reserved[firstId] != null) openSet.setReserved(firstId,v); else openSet.h[firstId] = v;
		v;
		var v1;
		v1 = __map_reserved[firstId] != null?openSet.getReserved(firstId):openSet.h[firstId];
		if(__map_reserved[firstId] != null) idToState.setReserved(firstId,v1); else idToState.h[firstId] = v1;
		v1;
		var v2 = this.evaluator.evaluate(this.hanoi.state);
		if(__map_reserved[firstId] != null) fScore.setReserved(firstId,v2); else fScore.h[firstId] = v2;
		v2;
		{
			if(__map_reserved[firstId] != null) gScore.setReserved(firstId,0); else gScore.h[firstId] = 0;
			0;
		}
		while(this.mapCounterItem(openSet) > 0) {
			var currentId = this.findMin(openSet,fScore);
			if(currentId == endstate) return this.getPath(cameFrom,endstate);
			openSet.remove(currentId);
			var v3;
			v3 = __map_reserved[currentId] != null?idToState.getReserved(currentId):idToState.h[currentId];
			if(__map_reserved[currentId] != null) closetSet.setReserved(currentId,v3); else closetSet.h[currentId] = v3;
			v3;
			this.hanoi.state = __map_reserved[currentId] != null?idToState.getReserved(currentId):idToState.h[currentId];
			var _g = 0;
			var _g1 = this.hanoi.generatePosibleStates();
			while(_g < _g1.length) {
				var item = _g1[_g];
				++_g;
				var itemid = item.generateStateId();
				if(__map_reserved[itemid] != null?closetSet.existsReserved(itemid):closetSet.h.hasOwnProperty(itemid)) continue;
				var t_gScore;
				t_gScore = (__map_reserved[currentId] != null?gScore.getReserved(currentId):gScore.h[currentId]) + 1;
				if(!(__map_reserved[itemid] != null?openSet.existsReserved(itemid):openSet.h.hasOwnProperty(itemid))) {
					{
						if(__map_reserved[itemid] != null) openSet.setReserved(itemid,item); else openSet.h[itemid] = item;
						item;
					}
					{
						if(__map_reserved[itemid] != null) idToState.setReserved(itemid,item); else idToState.h[itemid] = item;
						item;
					}
					this.counter++;
				} else if(t_gScore >= (__map_reserved[itemid] != null?gScore.getReserved(itemid):gScore.h[itemid])) continue;
				{
					if(__map_reserved[itemid] != null) cameFrom.setReserved(itemid,currentId); else cameFrom.h[itemid] = currentId;
					currentId;
				}
				{
					if(__map_reserved[itemid] != null) gScore.setReserved(itemid,t_gScore); else gScore.h[itemid] = t_gScore;
					t_gScore;
				}
				var v4 = t_gScore + this.evaluator.evaluate(item);
				if(__map_reserved[itemid] != null) fScore.setReserved(itemid,v4); else fScore.h[itemid] = v4;
				v4;
			}
		}
		return null;
	}
	,getPath: function(cameFrom,endState) {
		var path = [];
		var node = endState;
		path.push(endState);
		while(true) if((__map_reserved[node] != null?cameFrom.getReserved(node):cameFrom.h[node]) != "") {
			node = __map_reserved[node] != null?cameFrom.getReserved(node):cameFrom.h[node];
			path.push(node);
		} else {
			path.reverse();
			return path;
		}
	}
	,mapCounterItem: function(map) {
		var ret = 0;
		var $it0 = map.keys();
		while( $it0.hasNext() ) {
			var _ = $it0.next();
			ret++;
		}
		return ret;
	}
	,findMin: function(toIter,values) {
		var min = 100000000;
		var minKey = "";
		var $it0 = toIter.keys();
		while( $it0.hasNext() ) {
			var item = $it0.next();
			if((__map_reserved[item] != null?values.getReserved(item):values.h[item]) < min) {
				minKey = item;
				min = __map_reserved[item] != null?values.getReserved(item):values.h[item];
			}
		}
		return minKey;
	}
};
var algo_problems_hanoi_BFS = function(hanoi) {
	this.hanoi = hanoi;
	this.distance = new haxe_ds_StringMap();
	this.parents = new haxe_ds_StringMap();
};
algo_problems_hanoi_BFS.__name__ = true;
algo_problems_hanoi_BFS.prototype = {
	findState: function(endState) {
		this.counter = 1;
		var Q = new List();
		var path = [];
		var k = this.hanoi.state.generateStateId();
		this.distance.set(k,0);
		0;
		var k1 = this.hanoi.state.generateStateId();
		this.parents.set(k1,"");
		"";
		Q.push(this.hanoi.state);
		var teminator = true;
		while(Q.length > 0 && teminator) {
			var state = Q.pop();
			this.hanoi.state = state;
			var currentId = state.generateStateId();
			var _g = 0;
			var _g1 = this.hanoi.generatePosibleStates();
			while(_g < _g1.length) {
				var item = _g1[_g];
				++_g;
				var id = item.generateStateId();
				if(!this.distance.exists(id)) {
					var v = this.distance.get(currentId) + 1;
					this.distance.set(id,v);
					v;
					{
						this.parents.set(id,currentId);
						currentId;
					}
					Q.add(item);
					this.counter++;
				}
				if(endState == id) {
					teminator = false;
					break;
				}
			}
		}
		if(!teminator) this.tracePath(path,endState);
		return path;
	}
	,tracePath: function(path,endState) {
		var node = endState;
		path.push(node);
		while(true) {
			if(this.parents.get(node) != "") path.push(this.parents.get(node)); else break;
			node = this.parents.get(node);
		}
		path.reverse();
	}
};
var algo_problems_hanoi_DFS = function(hanoi) {
	this.hanoi = hanoi;
	this.distance = new haxe_ds_StringMap();
	this.parents = new haxe_ds_StringMap();
};
algo_problems_hanoi_DFS.__name__ = true;
algo_problems_hanoi_DFS.prototype = {
	findState: function(endState) {
		this.counter = 1;
		var Q = [];
		var path = [];
		var k = this.hanoi.state.generateStateId();
		this.distance.set(k,0);
		0;
		var k1 = this.hanoi.state.generateStateId();
		this.parents.set(k1,"");
		"";
		Q.push(this.hanoi.state);
		var teminator = true;
		while(Q.length > 0 && teminator) {
			var state = Q.pop();
			this.hanoi.state = state;
			var currentId = state.generateStateId();
			var _g = 0;
			var _g1 = this.hanoi.generatePosibleStates();
			while(_g < _g1.length) {
				var item = _g1[_g];
				++_g;
				var id = item.generateStateId();
				if(!this.distance.exists(id)) {
					var v = this.distance.get(currentId) + 1;
					this.distance.set(id,v);
					v;
					{
						this.parents.set(id,currentId);
						currentId;
					}
					Q.push(item);
					this.counter++;
				}
				if(endState == id) {
					teminator = false;
					break;
				}
			}
		}
		if(!teminator) this.tracePath(path,endState);
		return path;
	}
	,tracePath: function(path,endState) {
		var node = endState;
		path.push(node);
		while(true) {
			if(this.parents.get(node) != "") path.push(this.parents.get(node)); else break;
			node = this.parents.get(node);
		}
		path.reverse();
	}
};
var algo_problems_hanoi_Hanoi = function(rodNum,discNum) {
	this.iteraivCounter = 0;
	this.rodNum = rodNum;
	this.discNum = discNum;
	this.state = algo_problems_hanoi_HanoiState.createStart(rodNum,discNum);
};
algo_problems_hanoi_Hanoi.__name__ = true;
algo_problems_hanoi_Hanoi.createCopy = function(hanoi) {
	var copy = new algo_problems_hanoi_Hanoi(hanoi.rodNum,hanoi.discNum);
	copy.state = new algo_problems_hanoi_HanoiState(hanoi.discNum,hanoi.state);
	return copy;
};
algo_problems_hanoi_Hanoi.checkChangeRod = function(checkedState,sourceR,destinationR) {
	if(checkedState[sourceR].first() == null || sourceR == destinationR) return false;
	if(checkedState[destinationR].first() != null) {
		if(checkedState[sourceR].first() > checkedState[destinationR].first()) return false;
	}
	return true;
};
algo_problems_hanoi_Hanoi.prototype = {
	generateValidMoves: function() {
		var pairs = [];
		var _g1 = 0;
		var _g = this.rodNum;
		while(_g1 < _g) {
			var i = _g1++;
			var _g3 = 0;
			var _g2 = this.rodNum;
			while(_g3 < _g2) {
				var j = _g3++;
				if(algo_problems_hanoi_Hanoi.checkChangeRod(this.state.values,i,j)) pairs.push(new algo_Pair(i,j));
			}
		}
		return pairs;
	}
	,generatePosibleStates: function() {
		var pairs = this.generateValidMoves();
		var states = [];
		var _g = 0;
		while(_g < pairs.length) {
			var pair = pairs[_g];
			++_g;
			var copy = new algo_problems_hanoi_HanoiState(this.discNum,this.state);
			copy.changeState(pair);
			states.push(copy);
		}
		return states;
	}
	,generateEndStateId: function() {
		var vec;
		var this1;
		this1 = new Array(this.discNum);
		vec = this1;
		var _g1 = 0;
		var _g = this.discNum;
		while(_g1 < _g) {
			var i = _g1++;
			vec[i] = this.rodNum - 1;
		}
		return Std.string(vec);
	}
	,simpleIterativ: function() {
		var source = 0;
		var aux;
		if(this.discNum % 2 == 0) aux = 1; else aux = 2;
		var dest;
		if(this.discNum % 2 == 0) dest = 2; else dest = 1;
		if(this.iteraivCounter % 3 == 0) {
			if(!this.changeRod(source,aux)) this.changeRod(aux,source);
		}
		if(this.iteraivCounter % 3 == 1) {
			if(!this.changeRod(source,dest)) this.changeRod(dest,source);
		}
		if(this.iteraivCounter % 3 == 2) {
			if(!this.changeRod(aux,dest)) this.changeRod(dest,aux);
		}
		this.iteraivCounter++;
	}
	,changeRod: function(sourceR,destinationR) {
		if(this.state.firstPeg(sourceR) == null || sourceR == destinationR) return false;
		if(this.state.firstPeg(destinationR) != null) {
			if(this.state.firstPeg(sourceR) > this.state.firstPeg(destinationR)) return false;
		}
		this.state.changeState(new algo_Pair(sourceR,destinationR));
		return true;
	}
};
var algo_problems_hanoi_HanoiEvaluator = function() {
};
algo_problems_hanoi_HanoiEvaluator.__name__ = true;
algo_problems_hanoi_HanoiEvaluator.prototype = {
	evaluate: function(state) {
		return 0;
	}
};
var algo_problems_hanoi_HanoiState = function(discNum,copy) {
	this.discNum = discNum;
	this.values = [];
	if(copy == null) return;
	var _g1 = 0;
	var _g = copy.values.length;
	while(_g1 < _g) {
		var i = _g1++;
		this.values[i] = new List();
		var _g2_head = copy.values[i].h;
		var _g2_val = null;
		while(_g2_head != null) {
			var value;
			value = (function($this) {
				var $r;
				_g2_val = _g2_head[0];
				_g2_head = _g2_head[1];
				$r = _g2_val;
				return $r;
			}(this));
			this.values[i].add(value);
		}
	}
};
algo_problems_hanoi_HanoiState.__name__ = true;
algo_problems_hanoi_HanoiState.createStart = function(pegs,disc) {
	var state = new algo_problems_hanoi_HanoiState(disc,null);
	var _g = 0;
	while(_g < pegs) {
		var i = _g++;
		state.values.push(new List());
	}
	var _g1 = -disc;
	while(_g1 < 0) {
		var i1 = _g1++;
		state.values[0].push(-i1);
	}
	state.discNum = disc;
	return state;
};
algo_problems_hanoi_HanoiState.equals = function(a,b) {
	return a.generateStateId() == b.generateStateId();
};
algo_problems_hanoi_HanoiState.prototype = {
	firstPeg: function(peg) {
		return this.values[peg].first();
	}
	,changeState: function(move) {
		var value = this.values[move.x].pop();
		this.values[move.y].push(value);
	}
	,generateStateId: function() {
		var id = [];
		var _g1 = 0;
		var _g = this.values.length;
		while(_g1 < _g) {
			var i = _g1++;
			var _g2_head = this.values[i].h;
			var _g2_val = null;
			while(_g2_head != null) {
				var disc;
				disc = (function($this) {
					var $r;
					_g2_val = _g2_head[0];
					_g2_head = _g2_head[1];
					$r = _g2_val;
					return $r;
				}(this));
				id[disc - 1] = i;
			}
		}
		return Std.string(id);
	}
};
var algo_problems_hanoi_LargestMisplaced = function() {
	algo_problems_hanoi_HanoiEvaluator.call(this);
};
algo_problems_hanoi_LargestMisplaced.__name__ = true;
algo_problems_hanoi_LargestMisplaced.__super__ = algo_problems_hanoi_HanoiEvaluator;
algo_problems_hanoi_LargestMisplaced.prototype = $extend(algo_problems_hanoi_HanoiEvaluator.prototype,{
	evaluate: function(state) {
		var max = this.findLargestMisplaced(state);
		return Std["int"](Math.pow(2,max) - 1);
	}
	,findLargestMisplaced: function(state) {
		var max = 0;
		var _g1 = 0;
		var _g = state.values.length - 2;
		while(_g1 < _g) {
			var i = _g1++;
			var _g2_head = state.values[i].h;
			var _g2_val = null;
			while(_g2_head != null) {
				var value;
				value = (function($this) {
					var $r;
					_g2_val = _g2_head[0];
					_g2_head = _g2_head[1];
					$r = _g2_val;
					return $r;
				}(this));
				if(value > max) max = value;
			}
		}
		return max;
	}
});
var algo_problems_hanoi_LargestMisplacedPower = function() {
	algo_problems_hanoi_LargestMisplaced.call(this);
};
algo_problems_hanoi_LargestMisplacedPower.__name__ = true;
algo_problems_hanoi_LargestMisplacedPower.__super__ = algo_problems_hanoi_LargestMisplaced;
algo_problems_hanoi_LargestMisplacedPower.prototype = $extend(algo_problems_hanoi_LargestMisplaced.prototype,{
	evaluate: function(state) {
		var max = this.findLargestMisplaced(state);
		return Std["int"](Math.pow(2,max - 1));
	}
});
var algo_problems_hanoi_OnTopOfTheLargest = function() {
	algo_problems_hanoi_HanoiEvaluator.call(this);
};
algo_problems_hanoi_OnTopOfTheLargest.__name__ = true;
algo_problems_hanoi_OnTopOfTheLargest.__super__ = algo_problems_hanoi_HanoiEvaluator;
algo_problems_hanoi_OnTopOfTheLargest.prototype = $extend(algo_problems_hanoi_HanoiEvaluator.prototype,{
	evaluate: function(state) {
		var _g = 0;
		var _g1 = state.values;
		while(_g < _g1.length) {
			var peg = _g1[_g];
			++_g;
			var _g2_head = peg.h;
			var _g2_val = null;
			while(_g2_head != null) {
				var value;
				value = (function($this) {
					var $r;
					_g2_val = _g2_head[0];
					_g2_head = _g2_head[1];
					$r = _g2_val;
					return $r;
				}(this));
				if(value == state.discNum) return peg.length - 1;
			}
		}
		return 0;
	}
});
var algo_problems_hanoi_OtherThenLast = function() {
	algo_problems_hanoi_HanoiEvaluator.call(this);
};
algo_problems_hanoi_OtherThenLast.__name__ = true;
algo_problems_hanoi_OtherThenLast.__super__ = algo_problems_hanoi_HanoiEvaluator;
algo_problems_hanoi_OtherThenLast.prototype = $extend(algo_problems_hanoi_HanoiEvaluator.prototype,{
	evaluate: function(state) {
		return state.discNum - state.values[state.values.length - 1].length;
	}
});
var algo_problems_knapsack_BinaryKnapsack = function() {
};
algo_problems_knapsack_BinaryKnapsack.__name__ = true;
algo_problems_knapsack_BinaryKnapsack.initInstance = function(capacity,values,weights) {
	var knapsack = new algo_problems_knapsack_BinaryKnapsack();
	knapsack.capacity = capacity;
	knapsack.values = values;
	knapsack.weights = weights;
	return knapsack;
};
algo_problems_knapsack_BinaryKnapsack.generateInstance = function(capacity,numberOfItems,weightBottom,weightTop,valueBottom,valueTop) {
	var knapsack = new algo_problems_knapsack_BinaryKnapsack();
	knapsack.capacity = capacity;
	knapsack.values = [];
	knapsack.weights = [];
	var index = 0;
	while(index < numberOfItems) {
		knapsack.values.push(valueBottom + Math.floor((valueTop - valueBottom + 1) * Math.random()));
		knapsack.weights.push(weightBottom + Math.floor((weightTop - weightBottom + 1) * Math.random()));
		index++;
	}
	return knapsack;
};
algo_problems_knapsack_BinaryKnapsack.prototype = {
	averageItemValue: function() {
		var sum = 0;
		var _g = 0;
		var _g1 = this.values;
		while(_g < _g1.length) {
			var valye = _g1[_g];
			++_g;
			sum += valye;
		}
		return sum / this.values.length;
	}
	,toBinaryVector: function(items) {
		var binary = [];
		var index = 0;
		while(index < this.values.length) {
			binary[index] = HxOverrides.indexOf(this.values,items[index],0) != -1;
			index++;
		}
		return binary;
	}
	,generateRandomSolution: function() {
		var v;
		var this1;
		this1 = new Array(this.values.length);
		v = this1;
		var index = 0;
		var sum = 0;
		var valueSum = 0;
		while(index < v.length) {
			var result = Math.random() < 0.5;
			if(result) {
				v[index] = this.weights[index] + sum <= this.capacity;
				if(v[index]) {
					sum += this.weights[index];
					valueSum += this.values[index];
				}
			} else v[index] = false;
			index++;
		}
		return new algo_problems_knapsack_Result(v,valueSum,sum);
	}
	,generateNeighbour: function(current,number) {
		var copyV = algo_Utils.copyVec(current);
		var result = null;
		var index = 0;
		while(index < number) {
			var indexToChange = Math.floor((current.length - 1 + 1) * Math.random());
			copyV[indexToChange] = !copyV[indexToChange];
			index++;
		}
		result = this.fillResult(copyV);
		return this.recalculateResult(result);
	}
	,fillResult: function(items) {
		var sumV = 0;
		var sumW = 0;
		var index = 0;
		var _g = 0;
		while(_g < items.length) {
			var item = items[_g];
			++_g;
			if(item) {
				sumW += this.weights[index];
				sumV += this.values[index];
			}
			index++;
		}
		return new algo_problems_knapsack_Result(items,sumV,sumW);
	}
	,recalculateResult: function(child) {
		var index = 0;
		var valueSum = 0;
		var weightSum = 0;
		while(index < child.resultVector.length) {
			if(child.resultVector[index]) {
				if(weightSum + this.weights[index] > this.capacity) child.resultVector[index] = false; else {
					weightSum += this.weights[index];
					valueSum += this.values[index];
				}
			}
			index++;
		}
		child.weight = weightSum;
		child.value = valueSum;
		return child;
	}
	,evaluateWeight: function(items) {
		var sum = 0;
		var index = 0;
		var _g = 0;
		while(_g < items.length) {
			var item = items[_g];
			++_g;
			if(item) sum += this.weights[index];
			index++;
		}
		return sum;
	}
	,evaluateValue: function(items) {
		var sum = 0;
		var index = 0;
		var _g = 0;
		while(_g < items.length) {
			var item = items[_g];
			++_g;
			if(item) sum += this.values[index];
			index++;
		}
		return sum;
	}
	,getValuesDebug: function() {
		var sb_b = "";
		var _g = 0;
		var _g1 = this.values;
		while(_g < _g1.length) {
			var value = _g1[_g];
			++_g;
			if(value == null) sb_b += "null"; else sb_b += "" + value;
			sb_b += " ";
		}
		return sb_b;
	}
	,getWeightDebug: function() {
		var sb_b = "";
		var _g = 0;
		var _g1 = this.weights;
		while(_g < _g1.length) {
			var value = _g1[_g];
			++_g;
			if(value == null) sb_b += "null"; else sb_b += "" + value;
			sb_b += " ";
		}
		return sb_b;
	}
};
var algo_problems_knapsack_DPKnapsack = function() { };
algo_problems_knapsack_DPKnapsack.__name__ = true;
algo_problems_knapsack_DPKnapsack.solve = function(knapsack) {
	var n = knapsack.values.length;
	var W = knapsack.capacity;
	var rows;
	var this1;
	this1 = new Array(n + 1);
	rows = this1;
	var i = 0;
	while(i <= n) {
		var val;
		var this2;
		this2 = new Array(W + 1);
		val = this2;
		rows[i] = val;
		var j = 0;
		while(j <= W) {
			rows[i][j] = 0;
			j++;
		}
		i++;
	}
	i = 1;
	while(i <= n) {
		var w = 0;
		while(w <= W) {
			var wi = knapsack.weights[i - 1];
			var bi = knapsack.values[i - 1];
			if(wi <= w) {
				if(bi + rows[i - 1][w - wi] > rows[i - 1][w]) rows[i][w] = bi + rows[i - 1][w - wi]; else rows[i][w] = rows[i - 1][w];
			} else rows[i][w] = rows[i - 1][w];
			w++;
		}
		i++;
	}
	var vector = algo_problems_knapsack_DPKnapsack.traceResult(knapsack,rows);
	return new algo_problems_knapsack_Result(vector,knapsack.evaluateValue(vector));
};
algo_problems_knapsack_DPKnapsack.traceResult = function(knapsack,table) {
	var v;
	var this1;
	this1 = new Array(knapsack.values.length);
	v = this1;
	var j = 0;
	while(j < knapsack.values.length) {
		v[j] = false;
		j++;
	}
	var n = knapsack.values.length;
	var W = knapsack.capacity;
	var i = n;
	var k = W;
	while(i > 0 && k > 0) if(table[i][k] != table[i - 1][k]) {
		v[i - 1] = true;
		k = k - knapsack.weights[i - 1];
		i = i - 1;
	} else i = i - 1;
	return v;
};
var algo_problems_knapsack_CrossingType = { __ename__ : true, __constructs__ : ["OnePoint","TwoPoint","Uniform"] };
algo_problems_knapsack_CrossingType.OnePoint = ["OnePoint",0];
algo_problems_knapsack_CrossingType.OnePoint.toString = $estr;
algo_problems_knapsack_CrossingType.OnePoint.__enum__ = algo_problems_knapsack_CrossingType;
algo_problems_knapsack_CrossingType.TwoPoint = ["TwoPoint",1];
algo_problems_knapsack_CrossingType.TwoPoint.toString = $estr;
algo_problems_knapsack_CrossingType.TwoPoint.__enum__ = algo_problems_knapsack_CrossingType;
algo_problems_knapsack_CrossingType.Uniform = ["Uniform",2];
algo_problems_knapsack_CrossingType.Uniform.toString = $estr;
algo_problems_knapsack_CrossingType.Uniform.__enum__ = algo_problems_knapsack_CrossingType;
algo_problems_knapsack_CrossingType.__empty_constructs__ = [algo_problems_knapsack_CrossingType.OnePoint,algo_problems_knapsack_CrossingType.TwoPoint,algo_problems_knapsack_CrossingType.Uniform];
var algo_problems_knapsack_SelectionType = { __ename__ : true, __constructs__ : ["SimpleTournament","Roulette"] };
algo_problems_knapsack_SelectionType.SimpleTournament = ["SimpleTournament",0];
algo_problems_knapsack_SelectionType.SimpleTournament.toString = $estr;
algo_problems_knapsack_SelectionType.SimpleTournament.__enum__ = algo_problems_knapsack_SelectionType;
algo_problems_knapsack_SelectionType.Roulette = ["Roulette",1];
algo_problems_knapsack_SelectionType.Roulette.toString = $estr;
algo_problems_knapsack_SelectionType.Roulette.__enum__ = algo_problems_knapsack_SelectionType;
algo_problems_knapsack_SelectionType.__empty_constructs__ = [algo_problems_knapsack_SelectionType.SimpleTournament,algo_problems_knapsack_SelectionType.Roulette];
var algo_problems_knapsack_ProblemSolver = function() {
};
algo_problems_knapsack_ProblemSolver.__name__ = true;
algo_problems_knapsack_ProblemSolver.prototype = {
	solve: function(withHistory) {
		return null;
	}
};
var algo_problems_knapsack_GeneticAlgorithm = function(knapsack,populationSize,mutator,recombinationProbability,termination,crossingType,selectionType) {
	algo_problems_knapsack_ProblemSolver.call(this);
	this.knapsack = knapsack;
	this.populationSize = populationSize;
	this.mutationProbability = 1.0 / knapsack.values.length * mutator;
	this.recombinationProbability = recombinationProbability;
	this.termination = termination;
	this.uselessGenerations = 0;
	this.crossingType = crossingType;
	this.selectionType = selectionType;
};
algo_problems_knapsack_GeneticAlgorithm.__name__ = true;
algo_problems_knapsack_GeneticAlgorithm.__super__ = algo_problems_knapsack_ProblemSolver;
algo_problems_knapsack_GeneticAlgorithm.prototype = $extend(algo_problems_knapsack_ProblemSolver.prototype,{
	solve: function(withHistory) {
		var population = this.generateFirstGeneration();
		this.history = [];
		this.allTimeBest = new algo_problems_knapsack_Result((function($this) {
			var $r;
			var this1;
			this1 = new Array(1);
			$r = this1;
			return $r;
		}(this)),0,0);
		while(this.uselessGenerations < this.termination) {
			var index = 0;
			var newPoulation = [];
			var lastPoulationBest = this.allTimeBest.value;
			while(index < this.populationSize / 2) {
				this.generateChildren(population,newPoulation);
				index++;
			}
			population = newPoulation;
			if(this.allTimeBest.value > lastPoulationBest) this.uselessGenerations = 0; else this.uselessGenerations++;
			this.roulette = null;
		}
		return this.allTimeBest;
	}
	,generateFirstGeneration: function() {
		var index = 0;
		var toReturn = [];
		while(index < this.populationSize) {
			toReturn.push(this.knapsack.generateRandomSolution());
			index++;
		}
		return toReturn;
	}
	,generateChildren: function(population,newPopulation) {
		var parentA = this.chooseParent(population);
		var parentB = this.chooseParent(population);
		if(this.recombinationProbability > Math.random()) {
			newPopulation.push(this.onChildPush(this.crossParents(parentA,parentB)));
			newPopulation.push(this.onChildPush(this.crossParents(parentB,parentA)));
		} else {
			newPopulation.push(this.onChildPush(parentA));
			newPopulation.push(this.onChildPush(parentB));
		}
	}
	,twopointCross: function(parentA,parentB) {
		var len = parentA.resultVector.length;
		var newVector;
		var this1;
		this1 = new Array(len);
		newVector = this1;
		var firstSwapPoint = 1 + Math.floor(((len / 2 - 1 | 0) - 1 + 1) * Math.random());
		var secondSwapPoint = Random["int"](len / 2 + 1 | 0,len - 2);
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			if(i < firstSwapPoint) newVector[i] = parentA.resultVector[i]; else if(i < secondSwapPoint) newVector[i] = parentB.resultVector[i]; else newVector[i] = parentA.resultVector[i];
		}
		return new algo_problems_knapsack_Result(newVector,0,0);
	}
	,uniformCross: function(parentA,parentB) {
		var newVector;
		var this1;
		this1 = new Array(parentA.resultVector.length);
		newVector = this1;
		var _g1 = 0;
		var _g = parentA.resultVector.length;
		while(_g1 < _g) {
			var i = _g1++;
			var val;
			if(Math.random() < 0.5) val = parentA.resultVector[i]; else val = parentB.resultVector[i];
			newVector[i] = val;
		}
		return new algo_problems_knapsack_Result(newVector,0,0);
	}
	,onePointCorss: function(parentA,parentB) {
		var index = 0;
		var newVector;
		var this1;
		this1 = new Array(parentA.resultVector.length);
		newVector = this1;
		while(index < parentA.resultVector.length) {
			if(index < parentA.resultVector.length / 2) newVector[index] = parentA.resultVector[index]; else newVector[index] = parentB.resultVector[index];
			index++;
		}
		return new algo_problems_knapsack_Result(newVector,0,0);
	}
	,crossParents: function(parentA,parentB) {
		var _g = this.crossingType;
		switch(_g[1]) {
		case 0:
			return this.onePointCorss(parentA,parentB);
		case 1:
			return this.twopointCross(parentA,parentB);
		case 2:
			return this.uniformCross(parentA,parentB);
		}
		return null;
	}
	,mutateChild: function(child) {
		var index = 0;
		while(index < child.resultVector.length) {
			if(Math.random() > this.mutationProbability) child.resultVector[index] = !child.resultVector[index];
			index++;
		}
		return child;
	}
	,onChildPush: function(child) {
		child = this.mutateChild(child);
		child = this.knapsack.recalculateResult(child);
		if(child.value > this.allTimeBest.value) {
			console.log(this.allTimeBest.value + " " + child.value);
			this.history.push(child.value);
			this.allTimeBest = new algo_problems_knapsack_Result(child.resultVector,child.value,child.weight);
		}
		return child;
	}
	,simpleRoulette: function(population) {
		if(this.roulette == null) this.roulette = this.createRoulette(population);
		var valueRand = Math.random();
		var _g1 = 0;
		var _g = this.roulette.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(valueRand < this.roulette[i]) return population[i];
		}
		return population[0];
	}
	,createRoulette: function(population) {
		var propabilites = [];
		var populationTotalFintness = 0.0;
		var _g = 0;
		while(_g < population.length) {
			var item = population[_g];
			++_g;
			populationTotalFintness += item.value;
		}
		var currentTotal = 0.0;
		var _g1 = 0;
		while(_g1 < population.length) {
			var item1 = population[_g1];
			++_g1;
			currentTotal += item1.value / populationTotalFintness;
			propabilites.push(currentTotal);
		}
		console.log("--------------------------------");
		return propabilites;
	}
	,simpleTournament: function(population) {
		var firstParentI = Math.floor((population.length - 1 + 1) * Math.random());
		var secParentI = Math.floor((population.length - 1 + 1) * Math.random());
		if(population[firstParentI].value > population[secParentI].value) return population[firstParentI]; else return population[secParentI];
	}
	,chooseParent: function(population) {
		if(this.selectionType == algo_problems_knapsack_SelectionType.SimpleTournament) return this.simpleTournament(population); else return this.simpleRoulette(population);
	}
});
var algo_problems_knapsack_RandomSearch = function(iterations,knapsack) {
	algo_problems_knapsack_ProblemSolver.call(this);
	this.knapsack = knapsack;
	this.iterations = iterations;
};
algo_problems_knapsack_RandomSearch.__name__ = true;
algo_problems_knapsack_RandomSearch.__super__ = algo_problems_knapsack_ProblemSolver;
algo_problems_knapsack_RandomSearch.prototype = $extend(algo_problems_knapsack_ProblemSolver.prototype,{
	solve: function(withHistory) {
		this.history = [];
		var bestResult = this.knapsack.generateRandomSolution();
		var index = 0;
		while(index < this.iterations) {
			var tryV = this.knapsack.generateRandomSolution();
			if(tryV.value > bestResult.value) bestResult = tryV;
			index++;
			if(withHistory) this.history.push(bestResult.value);
		}
		return bestResult;
	}
});
var algo_problems_knapsack_Result = function(resultVector,value,weight) {
	if(weight == null) weight = 0;
	this.resultVector = resultVector;
	this.value = value;
	this.weight = weight;
};
algo_problems_knapsack_Result.__name__ = true;
var algo_problems_knapsack_SimulatedAnnaling = function(iterations,neighourChanges,knapsack,alpha) {
	if(alpha == null) alpha = 0.9;
	algo_problems_knapsack_ProblemSolver.call(this);
	this.iterations = iterations;
	this.neighourChanges = neighourChanges;
	this.knapsack = knapsack;
	this.alpha = alpha;
};
algo_problems_knapsack_SimulatedAnnaling.__name__ = true;
algo_problems_knapsack_SimulatedAnnaling.__super__ = algo_problems_knapsack_ProblemSolver;
algo_problems_knapsack_SimulatedAnnaling.prototype = $extend(algo_problems_knapsack_ProblemSolver.prototype,{
	solve: function(withHistory) {
		this.history = [];
		var T = 1.0;
		var T_min = 0.00001;
		var currentResult = this.knapsack.generateRandomSolution();
		var bestResult = new algo_problems_knapsack_Result((function($this) {
			var $r;
			var this1;
			this1 = new Array(1);
			$r = this1;
			return $r;
		}(this)),-1);
		var avergeValue = this.knapsack.averageItemValue();
		while(T > T_min) {
			var index = 0;
			while(index < this.iterations) {
				var tryV = this.knapsack.generateNeighbour(currentResult.resultVector,this.neighourChanges);
				var ap = this.acceptancePropability(avergeValue,tryV.value,currentResult.value,T);
				if(tryV.value > currentResult.value || ap > Math.random()) {
					currentResult = tryV;
					if(currentResult.value > bestResult.value) bestResult = currentResult;
				}
				index++;
				if(withHistory) this.history.push(currentResult.value);
			}
			T = T * this.alpha;
			console.log(T);
		}
		return bestResult;
	}
	,acceptancePropability: function(avarageValue,newCost,oldCost,T) {
		return (oldCost - newCost) / avarageValue * T;
	}
});
var haxe_IMap = function() { };
haxe_IMap.__name__ = true;
var haxe_Timer = function() { };
haxe_Timer.__name__ = true;
haxe_Timer.stamp = function() {
	return new Date().getTime() / 1000;
};
var haxe_ds_IntMap = function() {
	this.h = { };
};
haxe_ds_IntMap.__name__ = true;
haxe_ds_IntMap.__interfaces__ = [haxe_IMap];
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__name__ = true;
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	set: function(key,value) {
		if(__map_reserved[key] != null) this.setReserved(key,value); else this.h[key] = value;
	}
	,get: function(key) {
		if(__map_reserved[key] != null) return this.getReserved(key);
		return this.h[key];
	}
	,exists: function(key) {
		if(__map_reserved[key] != null) return this.existsReserved(key);
		return this.h.hasOwnProperty(key);
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,existsReserved: function(key) {
		if(this.rh == null) return false;
		return this.rh.hasOwnProperty("$" + key);
	}
	,remove: function(key) {
		if(__map_reserved[key] != null) {
			key = "$" + key;
			if(this.rh == null || !this.rh.hasOwnProperty(key)) return false;
			delete(this.rh[key]);
			return true;
		} else {
			if(!this.h.hasOwnProperty(key)) return false;
			delete(this.h[key]);
			return true;
		}
	}
	,keys: function() {
		var _this = this.arrayKeys();
		return HxOverrides.iter(_this);
	}
	,arrayKeys: function() {
		var out = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) out.push(key);
		}
		if(this.rh != null) {
			for( var key in this.rh ) {
			if(key.charCodeAt(0) == 36) out.push(key.substr(1));
			}
		}
		return out;
	}
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
var js_Browser = function() { };
js_Browser.__name__ = true;
js_Browser.alert = function(v) {
	window.alert(js_Boot.__string_rec(v,""));
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = ["Date"];
if(Array.prototype.map == null) Array.prototype.map = function(f) {
	var a = [];
	var _g1 = 0;
	var _g = this.length;
	while(_g1 < _g) {
		var i = _g1++;
		a[i] = f(this[i]);
	}
	return a;
};
var __map_reserved = {}
algo_Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
