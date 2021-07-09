import aima.search.framework.HeuristicFunction;

public class RedSensHeuristic implements HeuristicFunction{
	
	public double getHeuristicValue(Object n) {
		return ((RedSens) n).heuristic(); 
	}
	
	public boolean equals(Object obj) {
		return super.equals(obj);
	}
}