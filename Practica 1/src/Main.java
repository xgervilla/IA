import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.SimulatedAnnealingSearch;
import aima.search.informed.HillClimbingSearch;

import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import java.util.*;

@SuppressWarnings({"rawtypes","unused"})
public class Main {
	

	public static void main(String[] args) {
		System.out.println("Introduce el numero de centros y la semilla para generarlos");
		Scanner sc = new Scanner(System.in);
		int nCents = sc.nextInt();
		int semCents = sc.nextInt();
		
		System.out.println("Introduce el numero de sensores y la semilla para generarlos");
		int nSens = sc.nextInt();
		int semSens = sc.nextInt();
		
		System.out.println("Introduce el modo de creacion del estado inicial:\nModo cercano: 'cercano'\nModo aleatorio: 'aleatorio'\nModo ordenado: 'ordenado'\nModo por niveles: 'niveles'");
		String mode = sc.next();
		


		System.out.println("\nProblema generado con las siguientes caracteristicas:\nNumero de centros: "+nCents+"\nSemilla de los centros: "+semCents+"\nNumero de sensores: "+nSens+"\nSemilla de los sensores: "+semSens+"\nModo de creacion: "+mode);
		
		long first = System.currentTimeMillis();
		RedSens rs = new RedSens(nCents,semCents,nSens,semSens,mode);
		long second = System.currentTimeMillis();
		System.out.println("Heuristica inicial: "+ rs.heuristic());
		System.out.println("Tiempo de creacion: "+(second-first)+"ms\n");

		boolean algoCor = false;
		while(!algoCor) {
			System.out.println("\nIntroduce el algoritmo a usar:\nHill Climbing: 'hc'\nSimulated Annealing: 'sa'\n");
			String algo = sc.next();
			sc.close();
			if(algo.equals("hc")) {
				RedHillClimbingSearch(rs);
				algoCor = true;
			}
			else if(algo.equals("sa")) {
				RedSimulatedAnnealingSearch(rs);
				algoCor = true;
			}
			else System.out.println("Error en el algoritmo escogido");
		}

	}

	//Falta crear una nueva clase para los sucesores de annealing.
	private static void RedSimulatedAnnealingSearch(RedSens rs) {
		System.out.println("\nRedSensores Simulated Annealing  -->\n");
		try {
			long first = System.currentTimeMillis();
			Problem problem =  new Problem(rs,new RedSuccessorFunctionSA(), new RedSensGoalTest(),new RedSensHeuristic());
			SimulatedAnnealingSearch search =  new SimulatedAnnealingSearch(2000,100,5,0.001);
			search.traceOn();
			SearchAgent agent = new SearchAgent(problem,search);
			long second = System.currentTimeMillis();
			System.out.println("Tiempo de calculo Simmulated Annealing: "+(second-first)+"ms\n");

			System.out.println();
			printInstrumentation(agent.getInstrumentation());

			RedSens a = (RedSens) search.getGoalState();
			System.out.println("Heuristica del ultimo estado: " +a.heuristic()+"\nCoste "+ a.getCosteTotal()+"\nCapacidad total "+a.getCapacidadTotal()+"\nCapacidad maxima "+a.getCapacidadMaxima()+"\n");

		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void RedHillClimbingSearch(RedSens rs) {
		System.out.println("\nRedSensores HillClimbing  -->");
		try {
			long first = System.currentTimeMillis();
			Problem problem =  new Problem(rs,new RedSuccessorFunctionHC(), new RedSensGoalTest(),new RedSensHeuristic());
			Search search =  new HillClimbingSearch();
			SearchAgent agent = new SearchAgent(problem,search);
			long second = System.currentTimeMillis();

			System.out.println("Tiempo de calculo Hill Climbing: "+(second-first)+"ms\n");

			RedSens a = (RedSens) search.getGoalState();
			System.out.println("Heuristica del ultimo estado: " +a.heuristic()+"\nCoste "+ a.getCosteTotal()+"\nCapacidad total "+a.getCapacidadTotal()+"\nCapacidad maxima "+a.getCapacidadMaxima()+"\n");

		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void printInstrumentation(Properties properties) {
		Iterator keys = properties.keySet().iterator();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			String property = properties.getProperty(key);
			System.out.println(key + " : " + property);
		}

	}
}