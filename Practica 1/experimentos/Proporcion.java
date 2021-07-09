import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.HillClimbingSearch;
import java.util.Random;

@SuppressWarnings({"unused"})
public class Proporcion {
  public static void main(String[] args) {

      double wFlujo = 1.0;
      double wCoste = 1.0 / 30000;

      Random r = new Random();
      for (int i = 0; i < 200; i++) {
          try {
              RedSens2 rs = new RedSens2(4, 100, r.nextInt(), r.nextInt(), "cercano");
              Problem problem = new Problem(rs, new RedSuccessorFunction3(true, true), new RedSensGoalTest2(), new RedSensHeuristic3(wFlujo, wCoste));
              Search search = new HillClimbingSearch();
              SearchAgent agent = new SearchAgent(problem, search);

              RedSens2 a = (RedSens2) search.getGoalState();
              int usados = 0;
              for(int entradas: a.inCentros){
                  if(entradas != 0) System.out.println(i + " , usado ");
                  else System.out.println(i + " , vacio ");
              }
              System.out.println();
          } catch (Exception e) {
              e.printStackTrace();
          }
      }
  }
}
