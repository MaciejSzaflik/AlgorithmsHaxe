package algo.problems.knapsack;
import algo.problems.knapsack.Result;
import algo.problems.knapsack.BinaryKnapsack;
import haxe.ds.Vector;
import js.html.rtc.IdentityAssertion;

/**
 * ...
 * @author 
 */
class GeneticAlgorithm extends ProblemSolver
{
	public var populationSize:Int;
	public var mutationProbability:Float;
	public var recombinationProbability:Float;
	public var termination:Int;
	private var uselessGenerations:Int;
	
	private var allTimeBest : Result;
	
	public function new(knapsack:BinaryKnapsack, populationSize:Int, mutator:Float,recombinationProbability:Float,termination:Int)
	{
		super();
		this.knapsack = knapsack;
		this.populationSize = populationSize;
		this.mutationProbability = 1.0 / knapsack.values.length *mutator;
		this.recombinationProbability = recombinationProbability;
		this.termination = termination;
		this.uselessGenerations = 0;
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
			while (index < populationSize)
			{
				generateChildren(population, newPoulation);
				index++;
			}
			population = newPoulation;
			if(allTimeBest.value > lastPoulationBest)
				uselessGenerations = 0;
			else
				uselessGenerations++;
				
			history.push(allTimeBest.value);
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
	
	private function crossParents(parentA:Result, parentB:Result):Result
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
			allTimeBest = child;
		}
		return child;
	}
	
	private function chooseParent(population:Array<Result>)
	{
		var firstParentI = Random.int(0, population.length - 1);
		var secParentI = Random.int(0, population.length - 1);
		return (population[firstParentI].value > population[secParentI].value)? population[firstParentI] : population[secParentI];
	}
}