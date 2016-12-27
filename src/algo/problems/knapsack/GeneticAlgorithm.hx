package algo.problems.knapsack;
import algo.problems.knapsack.Result;
import algo.problems.knapsack.BinaryKnapsack;
import haxe.ds.Vector;
import js.html.rtc.IdentityAssertion;

/**
 * ...
 * @author 
 */
enum CrossingType
{
	OnePoint;
	TwoPoint;
	Uniform;
}

enum SelectionType
{
	SimpleTournament;
	Roulette;
}
 
class GeneticAlgorithm extends ProblemSolver
{
	public var populationSize:Int;
	public var mutationProbability:Float;
	public var recombinationProbability:Float;
	public var termination:Int;
	private var uselessGenerations:Int;
	private var crossingType:CrossingType;
	private var selectionType:SelectionType;
	
	private var allTimeBest : Result;
	
	public function new(knapsack:BinaryKnapsack, 
	populationSize:Int, mutator:Float, recombinationProbability:Float, termination:Int,
	crossingType:CrossingType,selectionType:SelectionType)
	{
		super();
		this.knapsack = knapsack;
		this.populationSize = populationSize;
		this.mutationProbability = 1.0 / knapsack.values.length *mutator;
		this.recombinationProbability = recombinationProbability;
		this.termination = termination;
		this.uselessGenerations = 0;
		this.crossingType = crossingType;
		this.selectionType = selectionType;
	}
	
	override public function solve(withHistory:Bool):Result 
	{
		var population = generateFirstGeneration();
		history = new Array<Int>();
		allTimeBest = new Result(new Vector<Bool>(1), 0, 0);
		while (uselessGenerations < termination)
		{
			var index = 0;
			var newPoulation = new Array<Result>();
			var lastPoulationBest = allTimeBest.value;
			while (index < populationSize/2)
			{
				generateChildren(population, newPoulation);
				index++;
			}
			population = newPoulation;
			if(allTimeBest.value > lastPoulationBest)
				uselessGenerations = 0;
			else
				uselessGenerations++;
			
			roulette = null;
		}
		return allTimeBest;
	}
	
	private function generateFirstGeneration():Array<Result>
	{
		var index = 0;
		var toReturn = new Array<Result>();
		while (index < populationSize)
		{
			toReturn.push(knapsack.generateRandomSolution());
			index++;
		}
		return toReturn;
	}
	
	private function generateChildren(population:Array<Result>,newPopulation:Array<Result>)
	{
		var parentA = chooseParent(population);
		var parentB = chooseParent(population);
		
		if (recombinationProbability > Math.random())
		{
			newPopulation.push(onChildPush(crossParents(parentA,parentB)));
			newPopulation.push(onChildPush(crossParents(parentB,parentA)));
		}
		else
		{
			newPopulation.push(onChildPush(parentA));
			newPopulation.push(onChildPush(parentB));
		}
	}
	
	private function twopointCross(parentA:Result, parentB:Result):Result
	{	
		var len = parentA.resultVector.length;
		var newVector = new Vector <Bool>(len);
		
		var firstSwapPoint = Random.int(1, Std.int(len / 2 - 1));
		var secondSwapPoint = Random.int(Std.int(len / 2 + 1), len - 2);
		
		for (i in 0...len)
		{
			if (i < firstSwapPoint)
				newVector[i] = parentA.resultVector[i];
			else if (i < secondSwapPoint)
				newVector[i] = parentB.resultVector[i];
			else
				newVector[i] = parentA.resultVector[i];
		}
		return new Result(newVector, 0, 0);
	}
	
	private function uniformCross(parentA:Result, parentB:Result):Result
	{
		var newVector = new Vector <Bool>(parentA.resultVector.length);
		for (i in 0...parentA.resultVector.length)
		{
			newVector[i] = Random.bool() ? parentA.resultVector[i] : parentB.resultVector[i];
		}
		return new Result(newVector, 0, 0);
	}
	
	private function onePointCorss(parentA:Result, parentB:Result):Result
	{
		var index = 0;
		var newVector = new Vector <Bool>(parentA.resultVector.length);
		while (index < parentA.resultVector.length)
		{
			if(index < parentA.resultVector.length/2)
				newVector[index] = parentA.resultVector[index];
			else
				newVector[index] = parentB.resultVector[index];
			
			index++;
		}
		return new Result(newVector, 0, 0);
	}
	
	private function crossParents(parentA:Result, parentB:Result):Result
	{
		switch(crossingType)
		{
			case CrossingType.OnePoint:
				return onePointCorss(parentA, parentB);
			case CrossingType.TwoPoint:
				return twopointCross(parentA, parentB);
			case CrossingType.Uniform:
				return uniformCross(parentA, parentB);
		}
		return null;
		
	}
	private function mutateChild(child:Result):Result
	{
		var index = 0;
		while (index < child.resultVector.length)
		{
			if (Math.random() > mutationProbability)
				child.resultVector[index] = !child.resultVector[index];
			index++;
		}
		return child;
	}
	
	private function onChildPush(child:Result):Result
	{
		child = mutateChild(child);
		child = knapsack.recalculateResult(child);
		
		if (child.value > allTimeBest.value)
		{
			trace(allTimeBest.value + " " + child.value );
			history.push(child.value);
			allTimeBest = new Result(child.resultVector, child.value, child.weight);
		}
		return child;
	}
	
	
	private var roulette : Array<Float>;
	private function simpleRoulette(population:Array<Result>) : Result
	{
		if (roulette == null)
			roulette = createRoulette(population);
		
		var valueRand = Math.random();
		for ( i in 0...roulette.length)
		{
			if (valueRand < roulette[i])
				return population[i];
		}
		return population[0];
	}
	
	private function createRoulette(population:Array<Result>) : Array<Float>
	{
		var propabilites = new Array<Float>();
		var populationTotalFintness = 0.0;
		for (item in population)
			populationTotalFintness += item.value;
		
		var currentTotal = 0.0;
		for (item in population)
		{
			currentTotal += item.value / populationTotalFintness;
			propabilites.push(currentTotal);
		}
		trace("--------------------------------");
		return propabilites;
	}
	
	private function simpleTournament(population:Array<Result>) :Result
	{
		var firstParentI = Random.int(0, population.length - 1);
		var secParentI = Random.int(0, population.length - 1);
		return (population[firstParentI].value > population[secParentI].value)? population[firstParentI] : population[secParentI];
	}
	
	private function chooseParent(population:Array<Result>) :Result
	{
		if (selectionType == SelectionType.SimpleTournament)
			return simpleTournament(population);
		else
			return simpleRoulette(population);
		
	}
}