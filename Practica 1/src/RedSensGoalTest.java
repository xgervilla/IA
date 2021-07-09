import aima.search.framework.GoalTest;

public class RedSensGoalTest implements GoalTest {

    public boolean isGoalState(Object state){

        return((RedSens) state).isGoal();
    }
}
