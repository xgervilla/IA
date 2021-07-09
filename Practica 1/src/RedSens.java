import IA.Red.Centro;
import IA.Red.CentrosDatos;
import IA.Red.Sensor;
import IA.Red.Sensores;

import java.util.ArrayList;
import java.util.Collections;
import java.util.*;

@SuppressWarnings({"rawtypes", "unchecked"})
public class RedSens {
	
	/** CARACTERISTICAS DEL PROBLEMA **/
	
	/* OPERADORES
	 * cambiar un sensor por otro (manteniendo los que cuelgan de el) --> swapSensores
	 * conectar un sensor a otro --> reconnect
	 * conectar un sensor a un centro --> reconnect
	 */
	
	/* ESTADOS
	 * Estado inicial --> diferentes modos iniciales
	 * Generacion del estado siguiente --> generar Suceroes
	 * Solucion mejorada (se va mejorando la solucion inicial hasta que ya no puede mejorar mas)
	 */
	
	/* HEURISTICA
	 * Para ver si al aplicar los operadores se obtiene una solucion mejorada (menor return de la heuristica)
	 */
	
	/* GOAL
	 * La solucion mejorada cumple las restricciones (no hay sensores sueltos -> siempre se cumple por defecto), return false
	 */
	

	/** VARIABLES **/
	
	//arrayLists con los centros de datos y los sensores
	public static CentrosDatos C;
	public static Sensores S;
	
	//tamano del problema (numero de sensores y de centros)
	public static int nSens;
	public static int nCent;
	
	//tamano de nSens+nCent --> hasta nSens-1 los sensores y de nSens a (nSens+nCent-1) los centros 
	public double[][] coste;
	
	//conexion del sensor -> positivo (0,nSensores-1) si conecta a un sensor --> i, negativo (-1,-nCentros) si conecta a un centro --> -j-1
	int[] salidas; 
	
	//cantidad de entradas de cada centro/sensor
	int[] inCentros;
	int[] inSensores;

	Random myRandom;
	
	/** CONSTRUCTORAS **/
	
	
	/* Creadora del estado inicial
	 @param nCentros numero de centros a crear.
	 @param seedCentros semilla para crear los centros.
	 @param nSensores numero de sensores.
	 @param seedSens semilla para crear los sensores.
	 @param modo Indica el modo de creación del estado inicial: "aleatorio", "cercano" o "ordenado".
	 */
	public RedSens(int nCentros, int seedCentros, int nSensores, int seedSens, String modo) {
		//creacion de los centros y los sensores
		C = new CentrosDatos(nCentros, seedCentros);
		S = new Sensores(nSensores, seedSens);
		nSens = nSensores;
		nCent = nCentros;
		
		
		coste = new double[nSensores+nCentros][2];	//coste y flujo/Capacidad hasta el punto: iniciamos con coste 0 y capacidad del propio sensor
		for(int i = 0; i<(nCentros+nSensores);++i) {
			coste[i][0] = coste[i][1] = 0.;
		}
		
		//numero de entradas de cada centro/sensor
		inCentros = new int[nCentros];
		inSensores = new int[nSensores];
		
		//a donde apunta el sensor (a que se conecta por arriba)
		salidas = new int[nSensores];
		
		//Creamos un bucle egocentrico como valor "comodin" para poder comprobar si el sensor esta ya conectado a algo diferente
		for(int i = 0; i<nSensores; ++i) {
			salidas[i] = i;
		}
		
		myRandom = new Random(seedCentros+seedSens);
		
		switch(modo) {
			case "cercano":
				estadoInicialCercano();
				break;
			case "aleatorio":
				estadoInicialAleatorio();
				break;
			case "ordenado":
				estadoInicialOrdenado();
				break;
			case "niveles":
				estadoInicialNiveles();
				break;
			default: 
				System.out.println("Error en el modo de creacion");
				break;
		}
	}
	
	
	/* Constructora de una copia (se le pasan los diferentes parametros del problema (una vez creado el estado inicial)
	 @param cost: coste
	 @param sal: salidas
	 @param inCent: inCentros
	 @param inSens: inSensores
	 @param cd: C
	 @param sens: S
	*/
	public RedSens(double[][] cost, int[] sal, int[] inCent, int[] inSens, CentrosDatos cd, Sensores sens) {
		//asignamos el numero de centros y de sensores
		nCent = cd.size();
		nSens = sens.size();
		
		//asginamos la estructura coste
		coste = new double[nSens + nCent][2];
		for(int i = 0; i<(nSens + nCent);++i) {
			coste[i][0] = cost[i][0];
			coste[i][1] = cost[i][1];
		}
		//asignamos las estructuras salidas y inSensores
		salidas = new int[nSens];
		inSensores = new int[nSens];
		for (int i = 0; i < nSens; ++i) {
			salidas[i] = sal[i];
			inSensores[i] = inSens[i];
		}
		//asignamos la estructura inCentros
		inCentros = new int[nCent];
		for (int i = 0; i < nCent; ++i) {
			inCentros[i] = inCent[i];
		}
		
		//asignamos los centros de datos y los sensores
		C = cd;
		S = sens;
	}


	/** ESTADO INICIAL**/
	//posible mejora: se podria intentar conectar al sensor mas cercano si el coste es menor, sin importar que el centro de datos tenga conexiones disponibles
	
	//conexion inicial (de forma aleatoria)
	private void estadoInicialAleatorio() {
		//centros y sensores conectados de alguna forma a un centro
        //que aceptan mas conexiones
        //inicializado a los centros
        ArrayList<Integer> libres = new ArrayList<Integer>();
        for (int i = -1; i >= -nCent; i--) {
            libres.add(i);
        }

        //Sensores aun no conectados a la red
        //Inicializado a todos los sensores
        ArrayList<Integer> sinConectar = new ArrayList<Integer>();
        for (int i = 0; i <nSens; ++i) {
        	sinConectar.add(i);
        }
        Collections.shuffle(sinConectar, myRandom); //conectarlos en orden aleatorio
        
        //no hay que ir eliminando, solo recorriendo
        for (int i = 0; i < nSens; i++) {//por cada sensor sin conectar
            int aConectar = sinConectar.get(i); //sensor que se va a conectar
            Integer alQueSeConecta = libres.get((int) (Math.random() * libres.size())); //escoger aleatoriamente al que se conecta
            
            nuevaConexion(aConectar,alQueSeConecta);	//propagamos el coste de la conexion
            
            if (alQueSeConecta >= 0) { //si se conecta a un sensor
                ++inSensores[alQueSeConecta];
                //si se llega al limite de conexiones por sensor se elimina de las posibiles conexiones
                if (inSensores[alQueSeConecta] == 3) {
                    libres.remove(alQueSeConecta); //esto elimina el numero del ArrayList ya que alQueSeConecta es un Integer, no un int
                }
            }
            else { //si se conecta a un centro de datos
                ++inCentros[-(alQueSeConecta + 1)];
                //si se llega al limite de conexiones por centro se elimina de las posibles conexiones
                if (inCentros[-(alQueSeConecta + 1)] == 25) {
                    libres.remove(alQueSeConecta);
                }
            }
            libres.add(aConectar);
        }
	}
	
	//conexion inicial (por cercania a un centro o a un sensor)
	private void estadoInicialCercano() {
		//por cada sensor vemos si se puede conectar al centro mas cercano o a otro sensor si estan todos ocupados
		for (int i = 0; i<nSens; ++i){
			//si no esta ya conectado lo conectamos
			if(salidas[i]==i) {
				int centroConect = -1;	//centro auxiliar (para asignar solo una vez)
				double costeMin = -1.;	//coste minimo (mas cercano para conectar)
				for (int j = 0; j<nCent; ++j){
					double c = costeCentroSensor(i,j);
					//comprobamos que se pueda conectar al centro (no tenga mas de 25 conexiones)
					boolean centroValido = inCentros[j]<25;
					//si el coste es menor y se puede conectar, actualizamos el costeMinimo y dejamos como centro auxiliar el centro actual
					if(centroValido && (c<costeMin || costeMin == -1.)) {
						costeMin = c;
						centroConect = j;
					}
				}
				
				//al comprobar los diferentes centro nos quedamos con el mas cercano valido (o ninguno)
				//si no se ha encontrado ninguno valido se intenta conectar a un sensor
				if(centroConect == -1) conectarASensor(i);
				//si se ha encontrado algun centro se conecta (aumentando el coste)
				else connectCentroSensor(i,centroConect,costeMin);
			}
		}
	}
	
	//conexion inicial (ordenado) -> se reparte por centros -> s0->c0, s1->c1, s2->c2, s3->c3, --> s5->c0, s6->c1..
	private void estadoInicialOrdenado() {
		//arraylist de los sensores que se han conectado a un centro y aun pueden recibir conexiones
		ArrayList<Integer> libres = new ArrayList<>();
		Integer contS = 0;	//iterador de los sensores
		Integer i = 0;	//iterador para los centros
		while (contS < nSens && inCentros[0] < 25) {
			//mientras no se supera el numero de sensores y el centro 0 puede recibir conexiones
			salidas[contS] = -i-1;	//como salida tiene el centro	
			++inCentros[i];
			libres.add(contS);	//lo anadimos a libres porque contS puede recibir conexioens por debajo
			
			//como se conecta directamente al centro, se aumenta directamente el valor calculado
			double capacidad = S.get(contS).getCapacidad();
			double costeConexion = costeCentroSensor(contS,i);
			
			propagarCoste1((-i-1),new double[] {costeConexion,capacidad});
			
			//coste[nSens+i][0] += costeConexion;
			//coste[nSens+i][1] += capacidad;
			
			++contS;	//aumentamos el iterador de sensor
			++i;		//aumentamos el iterador de centro
			if(i == nCent) i = 0;	//una vez todos los centros tienen un sensor repetimos la vuelta (hasta que no queden mas sensores que conectar)
		}
		
		//en caso de quedar sensores sin conectar, los conectamos a los otros sensores
		while (contS < nSens) {
			//cogemos el primer sensor de libre y lo quitamos
			Integer actual = libres.get(0);
			libres.remove(0);
			//intentamos conectar al actual (primero libre) los siguientes sensores
			while (inSensores[actual] < 3 && contS < nSens) {
				//el sensor sin conectar (contS) pasa a conectarse al sensor libre (actual)
				salidas[contS] = actual;
				++inSensores[actual];
				//ahora en contS se pueden conectar otros sensores
				libres.add(contS);
				
				//en este caso se conecta a un sensor, por lo que hay que propagar la variacion
				double capacidad = S.get(contS).getCapacidad(); 
				double costeConexion = coste[contS][0]+costeSensorSensor(contS,actual);		//coste que ya tiene mas coste al conectar
				double[] variacion = {costeConexion,capacidad};
				propagarCoste1(actual, variacion);
				
				++contS;
			}
		}
	}
	
	/*Funcion que conecta los centros a los sensores, respectadon el volumen si todos fueran al maximo de su capacidad.*/
	private void leerNivelZero(ArrayList<Integer> sensores, ArrayList<Integer> libres, Integer nivel) {
		Integer max = 25;	//para 1 y 2 consideramos maximo 25 (normal), para 5 consideramos 10 para evitar saturacion
		if (nivel == 5) max = 10;

		Integer i = 0;	//iterador para los sensores, misma mecanica que ordenado
		while (inCentros[0] < max && !sensores.isEmpty()) {
			//cogemos el primer sensor disponible
			Integer actual = sensores.get(0);
			sensores.remove(0);
			//lo conectamos al centro y actualizamos su salida
			salidas[actual] = -i-1;
			++inCentros[i];
			libres.add(actual);		//anadimos el sensor a la lista de sensores que pueden recibir entradas
			
			//como se conecta directamente al centro, se aumenta directamente el valor calculado
			double capacidad = S.get(actual).getCapacidad();
			double costeConexion = costeCentroSensor(actual,i);
			
			propagarCoste1((-i-1),new double[] {costeConexion,capacidad});
			
			//incrementamos el centro al que conectar
			++i;
			if (i == nCent) i = 0;
		}
	}

	/*Función que conecta un sensor ya conectado, a otros tres, hasta acabar la lista. */
	private void leerNiveles(ArrayList<Integer> sensores, ArrayList<Integer> libres) {
		//mientras la lista de sensores no esta vacia, conectamos
		while (!sensores.isEmpty()) {
			//cogemos el primer sensor disponible
			Integer actual = libres.get(0);
			libres.remove(0);
			//conectamos hasta 3 sensores al disponible
			while (inSensores[actual] < 3 && !sensores.isEmpty()) {
				//cogemos el siguiente disponible
				Integer next = sensores.get(0);
				sensores.remove(0);

				//los conectamos 
				salidas[next] = actual;
				++inSensores[actual];
				//anadimos el sensor recien conectado a la lista de sensores que pueden recibir conexiones
				libres.add(next);
				
				//next -> actual
				//en este caso se conecta a un sensor, por lo que hay que propagar la variacion
				double capacidad = S.get(next).getCapacidad(); 
				double costeConexion = costeSensorSensor(next,actual);		//coste al conectar
				
				double[] variacion = {costeConexion,capacidad};
				propagarCoste1(actual, variacion);
				
			}
		}
	}

	/*Función que conecta al primer nivel los sensores con maxima capacidad, y en los niveles posteriores los niveles con menor capacidad.*/
	private void estadoInicialNiveles() {
		//Separamos por niveles (cada sensor puede ser solo de uno)
		ArrayList cinco = new ArrayList<>();
		ArrayList dos = new ArrayList<>();
		ArrayList uno = new ArrayList<>();
		for (int i = 0; i < nSens; ++i) {
			if (S.get(i).getCapacidad() == 1) uno.add(i);
			else if (S.get(i).getCapacidad() == 2) dos.add(i);
			else if (S.get(i).getCapacidad() == 5) cinco.add(i);
		}
		
		ArrayList<Integer> libres = new ArrayList<>();

		//intentamos asignar primero los de nivel 5 (al nivel 0, conectados a centros)
		if (!cinco.isEmpty()) leerNivelZero(cinco, libres, 5);
		else {
			//si los de 5 estan vacios intentamos asignar los de 2
			if (!dos.isEmpty()) leerNivelZero(dos, libres, 2);
			//si los de 2 estan vacios asignamos los de 1
			else leerNivelZero(uno, libres, 1);
		}

		//conectamos los que queden a los niveles restantes (manteniendo la prioridad)
		leerNiveles(cinco, libres);
		leerNiveles(dos, libres);
		leerNiveles(uno, libres);
	}
	
	
	/** CONEXIONES INICIALES **/
	
	//conexion inicial de un sensor a otro (si no hay centros disponibles)
	private void conectarASensor(int s1) {
		double costeMin = -1.;
		int sensorConect = -1;
		for(int i = 0; i<nSens; ++i) {
			if(i!=s1) {	//si no es si mismo (evitamos bucles egocentricos durante la asignacion)
				double c = costeSensorSensor(s1,i);
				boolean sensorValido = inSensores[i]<3 && !bucleAlConectar(s1,i);
				if(sensorValido && (c<costeMin || costeMin == -1.)) {
					costeMin = c;
					sensorConect = i;
				}
			}
		}
		//una vez comprobados todos se asigna (s1 es subconexion de sensorConect) s1->sensorConect
		if(sensorConect == -1) System.out.print("Error en la creacion del problema\n");
		else connectSensorSensor(s1,sensorConect,costeMin);
	}
	
	//operador de asignar conexiones (el sensor s1 es subconexion de s2) == s1->s2
	private void connectSensorSensor(int s1, int s2, double newCoste) {
		//Establecemos las conexiones
		salidas[s1] = s2;	//s1 conectado a s2 (s1->s2)
		++inSensores[s2]; 
		//si s2 no esta conectado a nada -> conectamos a sensor
		if(salidas[s2] == s2) {
			conectarASensor(s2);
		}
		 
		//auxiliar para propagar los cambios en s2 (aumento del coste nuevo y de la capacidad)
		double capacidad = Math.min(coste[s1][1]+S.get(s1).getCapacidad(), S.get(s1).getCapacidad()*3);
		double costeCon = coste[s1][0]+newCoste; 
		double[] aumento = {costeCon,capacidad};
		
		propagarCoste1(s2,aumento); 
	}
	
	//operador de asignar conexiones (el sensor s al centro c) == s1->c1
	private void connectCentroSensor(int s1, int c1, double newCoste) {
		salidas[s1] = -c1-1;
		++inCentros[c1];
		
		double capacidad = Math.min(coste[s1][1]+S.get(s1).getCapacidad(), S.get(s1).getCapacidad()*3);		
		
		propagarCoste1((-c1-1),new double[] {coste[s1][0]+newCoste,capacidad});
	}
	
	
	/** OPERADORES **/
	
	//operador de intercambiar conexiones (el sensor s1 por el s2)
	public void swapSensores(int s1, int s2) {
		int salidaS3 = salidas[s1];
		int salidaS4 = salidas[s2];
		
		double costes1s3, costes2s4;
		double costes1s4, costes2s3;
		
		boolean centroS3 = salidaS3<0;
		boolean centroS4 = salidaS4<0;
		
		//Calculo de los costes de las conexiones
		if(!centroS3) {
			costes1s3 = costeSensorSensor(s1, salidaS3);
			costes2s3 = costeSensorSensor(s2,salidaS3);
		}
		else{
			costes1s3 = costeCentroSensor(s1,-(salidaS3+1));
			costes2s3 = costeCentroSensor(s2,-(salidaS3+1));
		}
		
		if(!centroS4) {
			costes2s4 = costeSensorSensor(s2, salidaS4);
			costes1s4 = costeSensorSensor(s1, salidaS4);
		}
		else{
			costes2s4 = costeCentroSensor(s2,-(salidaS4+1));
			costes1s4 =costeCentroSensor(s1,-(salidaS4+1));
		}
		
		//variacion del coste
		double variacionCosteS3 = -(coste[s1][0]+costes1s3) + (coste[s2][0]+costes2s3);
		double variacionCosteS4 = -(coste[s2][0]+costes2s4) + (coste[s1][0]+costes1s4);

		//capacidad que sale de s1 y de s2
    	double capacidadS1 = Math.min(S.get(s1).getCapacidad()+coste[s1][1],3*S.get(s1).getCapacidad());
    	double capacidadS2 = Math.min(S.get(s2).getCapacidad()+coste[s2][1],3*S.get(s2).getCapacidad());
    	
       	double variacionCapacidadS3 = -(capacidadS1)+(capacidadS2);
       	double variacionCapacidadS4 = -(capacidadS2)+(capacidadS1);
       	
       	//propagamos con las variaciones
       	propagarCoste1(salidaS3, new double[]{variacionCosteS3, variacionCapacidadS3});
    	propagarCoste1(salidaS4, new double[]{variacionCosteS4, variacionCapacidadS4});
    	
    	int conexion1 = salidas[s1];
    	int conexion2 = salidas[s2];
    	salidas[s1] = conexion2;
    	salidas[s2] = conexion1;
	}
	
	//Conecta s1 a s2 (sin importar si s2 es centro o sensor)
    public void reconnect(int s1, int s2){
    	//guardamos la salida original de s1
    	int salidaAnterior = salidas[s1];
    	
    	//quitamos la conexion anterior y actualizamos el numero de entradas de la salida (salidaAnterior)
        if(salidaAnterior >= 0){
            --inSensores[salidaAnterior];
        }
        else{
            --inCentros[-(salidaAnterior+1)];
        }
        
        //quitamos de salidaAnterior el peso de s1 (variacion de coste y de capacidad)
        double variacionCoste = coste[s1][0];
        
        double costeConexion = 0.;
        if(salidaAnterior<0) costeConexion = costeCentroSensor(s1,-(salidaAnterior+1));
        else costeConexion = costeSensorSensor(s1,salidaAnterior);
        
        double capacidadS1 = Math.min(S.get(s1).getCapacidad()+coste[s1][1],3*S.get(s1).getCapacidad()); 
        
        //propagamos        
        propagarCoste1(salidaAnterior,new double[] {-(variacionCoste+costeConexion),-capacidadS1});
        
        salidas[s1] = s2;
        if(s2 >= 0){
            ++inSensores[s2];
        }
        else{
            ++inCentros[-(s2+1)];
        }
        
        //anadimos a s2 el peso de s1 (variacion de coste y de capacidad nuevos)
        if(s2<0) costeConexion = costeCentroSensor(s1,-(s2+1));
        else costeConexion = costeSensorSensor(s1,s2);
        variacionCoste = coste[s1][0];
        
        //la capacidad no varia, propagamos
        propagarCoste1(s2,new double[] {(variacionCoste+costeConexion), capacidadS1});
    }
    
    
	/** COSTE Y DISTANCIA**/
	//coste: ( (xi-yi)^2+(xj-yj)^2 )*v(x) --> x: s1, y: s2 || c1
	
	//coste al conectar dos sensores
	private double costeSensorSensor(int s1, int s2) {
		Sensor sens1 = S.get(s1);
		return distanciaSensorSensor(s1,s2) * sens1.getCapacidad();
		
	}
	
	//coste al conectar un sensor y un centro
	private double costeCentroSensor(int s1, int c1) {
		Sensor sens1 = S.get(s1);
		return distanciaCentroSensor(s1,c1) * sens1.getCapacidad();
	}
	
	//distancia euclida entre las coordenadas del sensor1 y el sensor 2 (al cuadrado)
	private double distanciaSensorSensor(int s1, int s2) {
		Sensor sens1 = S.get(s1);
		Sensor sens2 = S.get(s2);
		return (Math.pow((sens1.getCoordX()-sens2.getCoordX()),2) + Math.pow((sens1.getCoordY()-sens2.getCoordY()),2));
	}
	
	//distancia euclida entre las coordenadas del sensor s11 y el centro c1 (al cuadrado)
	private double distanciaCentroSensor(int s1, int c1) {
		Sensor sens1 = S.get(s1);
		Centro cent1 = C.get(c1);
		return (Math.pow((sens1.getCoordX()-cent1.getCoordX()),2) + Math.pow((sens1.getCoordY()-cent1.getCoordY()),2));
	}
	
	/** PROPAGACION DE COSTE **/
	
	//propaga la variacion de una conexion (coste y capacidad)
	private void propagarCoste1(int s1, double[] variacion) {
		//si se propaga a un centro:
		if(s1<0) {
			s1 = nSens+ (-(s1+1));	//normalizamos el identificador del centro y le aplicamos el desplazamiento
			coste[s1][0] += variacion[0];
    		coste[s1][1] = Math.min(150.0, coste[s1][1]+variacion[1]);
		}
		//si se propaga a un sensor:
		else {
			double capacidad = S.get(s1).getCapacidad();
			
			//lo que transmitia:
			double capPrevia = Math.min(coste[s1][1]+capacidad, capacidad*3);
			
			coste[s1][0]+=variacion[0];
			coste[s1][1]+=variacion[1];
			
			//lo que transmite ahora
			double capNueva = Math.min(coste[s1][1]+capacidad, capacidad*3);

			//actualizamos la variacion
			variacion[1] = capNueva-capPrevia;
			
			//propagamos en la salida
			int salida = salidas[s1];
			propagarCoste1(salida,variacion);	
		}
	}
		
	//funcion puente para cargar los parametros de propagarCoste2
	private void nuevaConexion(int s1, int s2) {
		salidas[s1] = s2;
		double capacidad = S.get(s1).getCapacidad();
		
		coste[s1][1] = capacidad;
		
		double costeConexion = 0.; 
		if(s2<0) costeConexion = distanciaCentroSensor(s1,-(s2+1));
		else costeConexion = distanciaSensorSensor(s1,s2);
		
		costeConexion = coste[s1][0] + costeConexion*Math.min(coste[s1][1], 3*capacidad);
		
		propagarCoste2(s2, 0, capacidad, 0, coste[s1][0]+costeConexion);
		
		if(s2<0) ++inCentros[-(s2+1)];
		else ++inSensores[s2];
	}
	
	//propaga  la variacion de una conexion teniendo en cuenta el limite de capacidad
	private void propagarCoste2(int s2, double flujoPrev, double flujoNew, double costePrev, double costeNew){ 
	    int indice = s2;  //indice actual
	    boolean sensor = indice >= 0;

	    if(sensor){
	    	double capacidadOriginal = coste[indice][1];
	    	coste[indice][1] -= flujoPrev;
	    	coste[indice][1] += flujoNew;
	    	
	    	double costeOriginal = coste[indice][0];
	        coste[indice][0] -= costePrev;
	        coste[indice][0] += costeNew;
	        
	        

	        //cogemos la capacididad del sensor parametro
	        double capacidad = S.get(indice).getCapacidad(); //capacidad de s2
	        
	        //cogemos la salida del sensor parametro
	        int salidaActual = salidas[indice]; //siguiente sensor (o centro)

	        //flujo s2->s3 previo
	        double flujoPrevCalc = Math.min(capacidad*3, capacidadOriginal);	//min(capacidad maxima, capacidad sin cambios)
	        //flujo s2->s3 nuevo
	        double flujoNewCalc = Math.min(capacidad*3, coste[indice][1]);		//min(capacidad maxima, capacidad actualizada)
	        
	        //distancia (sin tener el cuenta el voulmen) entre el sensor parametro y el sensor de salida
	        double distanciaCuad = 0.; 
	        if(salidaActual>=0) distanciaCuad = distanciaSensorSensor(indice, salidaActual);
	        else distanciaCuad = distanciaCentroSensor(indice,-(salidaActual+1));	//salida normalizada en caso de ser centro

	        //calculamos el coste nuevo y el previo
	        
	        //coste s2->s3 previo
	        double costePrevCalc = costeOriginal+flujoPrevCalc*distanciaCuad;
	        //coste nuevo = coste actualizado + (distancia * flujo nuevo calculado) (coste nuevo + coste conexion actualizado)
	        //coste s2->s3 nuevo
	        double costeNewCalc = coste[indice][0]+flujoNewCalc*distanciaCuad;

	        //propagamos el coste con el sensor de salida como sensor parametro y con los costes y flujos calculados
	        propagarCoste2(salidaActual, flujoPrevCalc, flujoNewCalc, costePrevCalc, costeNewCalc);
	    }
	    else{
	    	//normalizamos el indice si es centro
	        indice = -(indice+1);
	        //al llegar a centro no hace falta seguir propagando, simplemente actualizar
	        coste[nSens+indice][0] -= costePrev;
	        coste[nSens+indice][0] += costeNew;

	        coste[nSens+indice][1] -= flujoPrev;
	        coste[nSens+indice][1] += flujoNew;
	    }
	}

	/** HEURISTICA Y GOAL**/
	
	//funcion heuristica (calculo) (sin implementar, return inutil (por ahora))
	public double heuristic() {
		double[] costeCapacidad = sumaCoste();
		
		//return costeCapacidad[0];	//coste
		//return costeCapacidad[1]; //capacidad
		//return Math.max(15000., Math.pow(costeCapacidad[0], costeCapacidad[1]/getCapacidadMaxima()));	//ponderacion pow
		//return costeCapacidad[0]/30000 - costeCapacidad[1]/265.;	//ponderacion lineal
		return Math.max(costeCapacidad[0]/1000.-costeCapacidad[1],0);	//ponderacion basica
	}
	
	//en busqueda local por defecto es falso
	public boolean isGoal() {
		return false;
	}

	
	/** RETURNS DE VARIABLES **/

	//estructura coste
	public double[][] getCoste(){
		return coste;
	}
	
	//estructura salidas
	public int[] getSalidas() {
		return salidas;
	}
	
	//numero de sensores
	public int getSensores() {
		return nSens;
	}
	
	//numero de centros
	public int getCentros() {
		return nCent;
	}
	
	//inCentros
	public int[] getInCentros() {
		return inCentros;
	}
	
	//inSensores
	public int[] getInSensores() {
		return inSensores;
	}
	
	//conjunto de centros de datos
	public CentrosDatos getCentrosDatos() {
		return C;
	}
	
	//conjunto de sensores
	public Sensores getConjuntoSensores() {
		return S;
	}
	
	//devuelve el coste total del estado
	public double getCosteTotal() {
		double suma = 0.;
		for(int i = nSens; i<(nSens+nCent);++i) {
			suma+=coste[i][0];
		}
		return suma;
	}
	
	//devuevle la capacidad total del estado
	public double getCapacidadTotal() {
		double suma = 0.;
		for(int i = nSens; i<(nSens+nCent);++i) {
			suma+=coste[i][1];
		}
		return suma;
	}
	
	//devuelve la capacidad maxima del problema
	public double getCapacidadMaxima() {
		double suma = 0.;
		for(int i = 0; i<nSens; ++i) {
			suma+= S.get(i).getCapacidad();
		}
		return suma;
	}
	
	/** FUNCIONES AUXILIARES **/
	
	//devuelve el sumatorio de los costes de los centros [0] y el sumatorio de las capacidades [1]
	private double[] sumaCoste() {
		double[] suma = {getCosteTotal(),getCapacidadTotal()};
		return suma;
	}
	
	/*Dice si un sensor esta conectado erroneamente a si mismo solo funciona con los casos para los que esta hecho para funcionar no hace falta
	preocuparse por entrar en el bucle del otro, o crear un bucle comun, esos casos son imposibles si se parte de un estado valido*/
	private boolean sinBucle(int sensor){
        int actual = sensor;
        while(actual >= 0){ //mientras es un sensor
            actual = salidas[actual];
            if(actual == sensor) return false; //si se conecta a si mismo no es posible --> hay bucle
        }
        //si ha encontrado que se conecta a un centro, no hay bucle
        return true;
    }
	
	//comprobamos si hay un bucle al conectar s1 a s2
	private boolean bucleAlConectar(int s1, int s2) {
		int auxSalida = salidas[s1];
		salidas[s1] = s2;
		int act = s1;
		//comprobamos si hay un bucle	-> si esta conectado a un centro, devuelve true. si esta conectado a si mismo, devuelve true
		while(salidas[act]!=s1) {
			//si esta conectado a otro sensor
			if(salidas[act]<0 || salidas[act] == act) {
				//Dejamos el valor como estaba
				salidas[s1] = auxSalida;
				return false;
			}
			//seguimos buscando
			else act = salidas[act];
		}
		//si sale es que ha encontrado un bucle
		salidas[s1] = auxSalida;
		return true;
	}
	
	//indica si se puede conectar s1 a s2
	
	//devuelve si se puede aplicar la conexion s1->s2
	public boolean canReconnect(int s1, int s2) {
		//si se intenta conectar a un centro o sensor pero no se pueden hacer mas conexiones devuelve falso
		if(s2>=0 && inSensores[s2]==3) return false;
		if(s2<0 && inCentros[-(s2+1)]==25) return false;
		//si se intenta reconectar a su actual salida devuelve falso
		if(salidas[s1]==s2) return false;
		
		else {
			int salidaAnterior = salidas[s1];
			//asignamos la salida
			salidas[s1] = s2;
			//comprobamos que no sea crea bucle al anadir la conexion
			boolean posible = sinBucle(s1);
			//reasignamos la salida
			salidas[s1] = salidaAnterior;
			//devolvemos si ha sido posible anadir la conexion
			return posible;
		}
	}
	
	//devuelve si se puede aplicar el swap s1,s2
	public boolean canSwapSensores(int s1, int s2) {
		//no se puede hacer swap consigo mismo
		if(s1 == s2) return false;
		else if(salidas[s1] == salidas[s2]) return false;

		int conexion1 = salidas[s1];
		int conexion2 = salidas[s2];
		salidas[s1] = conexion2;
		salidas[s2] = conexion1;

		//comprobamos que no se han creado bucles al hacer el swap
		boolean resultado = (sinBucle(s1) && sinBucle(s2));

		//reasignamos las conexiones
		salidas[s1] = conexion1;
		salidas[s2] = conexion2;

		//devolvemos si ha sido posible aplicar el swap sin crear bucles
		return resultado;
	}
}