import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;

import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"unchecked","rawtypes"})
public class RedSuccessorFunctionHC implements SuccessorFunction {
	
	public List getSuccessors(Object aState) {
        ArrayList retval = new ArrayList();
        RedSens rs = (RedSens) aState;

        //aplicamos (si se puede) el operador de swap de dos sensores
        for (int i = 0; i < rs.getSensores(); ++i) {
            for (int j = i+1; j < rs.getSensores(); ++j) {
                if (rs.canSwapSensores(i, j)) {
                    //System.out.println("\n" + i + " " + j);
                    RedSens nuevo = new RedSens(rs.getCoste(), rs.getSalidas(), rs.getInCentros(), rs.getInSensores(),rs.getCentrosDatos(),rs.getConjuntoSensores());
                    nuevo.swapSensores(i,j);

                    String S = "Intercambio entre sensores " + i + " y " + j + "\n";
                    retval.add(new Successor(S, nuevo));
                }
            }
        }
        
        //aplicamos (si se puede) el operador de reconectar un sensor a otro punto (si s1->s2, reconectar == s1->s3)
        for(int s1 = 0; s1 < rs.getSensores(); s1++){
        	//por cada sensor, comprobamos todas sus reconexiones (desde los centros (cn = -cn-1 == -nCent) hasta nSens-1)
            for(int s2 = -rs.getCentros(); s2 < rs.getSensores(); s2++){
                if(s1!=s2 && rs.canReconnect(s1, s2)){
                	RedSens nuevo = new RedSens(rs.getCoste(), rs.getSalidas(), rs.getInCentros(), rs.getInSensores(),rs.getCentrosDatos(),rs.getConjuntoSensores());
                    nuevo.reconnect(s1,s2);
                    String S = "Cambio de conexion sensor " + s1 + " a ";
                    if(s2<0) S+= "centro "+(-(s2+1))+"\n";
                    else S+= "sensor "+s2+"\n";
                    retval.add(new Successor(S, nuevo));
                }
            }
        }
        return retval;
    }
}