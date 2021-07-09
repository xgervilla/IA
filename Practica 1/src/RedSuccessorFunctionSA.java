import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@SuppressWarnings({"unchecked","rawtypes"})
public class RedSuccessorFunctionSA implements SuccessorFunction {
	
	public List getSuccessors(Object aState) {
        ArrayList retval = new ArrayList();
        RedSens rs = (RedSens) aState;
        Random myRandom = new Random();
        int i, j;
        boolean canSwap = false, canReconnect = false;

        //mientras no se pueda reconectar, generamos un nuevo estado diferente
        do {
            canSwap = canReconnect = false;
            i = myRandom.nextInt(rs.getSensores());
            j = myRandom.nextInt(rs.getSensores() + rs.getCentros());
            if (j >= rs.getSensores()) {
                j = rs.getSensores() - j - 1;
                if(rs.canReconnect(i, j)) canReconnect = true;
            }
            else {
                if (rs.canSwapSensores(i, j)) canSwap = true;
                if (i!=j && rs.canReconnect(i, j)) canReconnect = true;
            }
        } while(!canReconnect && !canSwap);

        //cuando una de las dos operaciones se pueden aplicar, lo generamos
        RedSens operador = new RedSens(rs.getCoste(), rs.getSalidas(), rs.getInCentros(), rs.getInSensores(),rs.getCentrosDatos(),rs.getConjuntoSensores());
        if (canSwap && canReconnect) {
            if (Math.random() < 0.5) operador.swapSensores(i,j);
            else operador.reconnect(i,j);
        }
        else {
            if (canSwap) operador.swapSensores(i,j);
            else operador.reconnect(i,j);
        }
        String S = "operacion entre" + i + " y " + j;
        retval.add(new Successor(S, operador));
        return retval;
    }
}