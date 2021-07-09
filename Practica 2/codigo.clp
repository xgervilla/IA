;;;-----------------------------------------------------------------------------
;;;---------------------- MODULOS ----------------------------------------------
;-------------------------------------------------------------------------------

;;; Modulo principal, modulo basico, desde donde empieza todo.
(defmodule MAIN(export ?ALL))

;;; Modulo de recopilacion de los datos (del usuario)
;;; Primer modulo de recopilación de datos, aquí se hacen las primeras preguntas.
;;; Basicas al hacer un reserva.
(defmodule recopilacion-datos
  (import MAIN ?ALL)
  (export ?ALL)
)

;;; Modulo de recopilacion de las preferencias (del usuario)
;;; Aquí se hacen preguntas un poco más concretas, sobre el tipo de menu que se quiere.
;;; vino?, temperatura de los platos?, bebida por plato?,.....
(defmodule recopilacion-preferencias
  (import MAIN ?ALL)
  (export ?ALL)
)

;;; Modulo de recopilacion del conocimiento (del sistema), Adecuar el menu a los clientes
;;; Este último modulo de preguntas, consiste en preguntas sobre sus gustos y preferencias
;;; con los platos del menu, Region, tipo de plato, estilo
(defmodule recopilacion-conocimiento
  (import MAIN ?ALL)
  (export ?ALL)
)

;;; Modulo de inferencia de los datos de la aplicacion dentro de instancisa
;;; En este modulo se crean las intancias con los datos y prefencias, como marca la
;;; Ontologia.
;;; Util para posibles mejoras, pero en la implementacion final, hemos preferido tratar
;;; con los hechos directamente.
;;; Tambien se escojen los platos que cumplen las condiciones y se guardan como hechos.
;;; basicamente selecionamos los platos que sean adecuados para el usuario
;;; segun los datos leidos en los modulos anteriores.
;;; Cada plato que sea adecuado (pase todos los filtros) es buen candidato para un menu,
;;; y por tanto se creara un hecho con ese plato.
(defmodule inferir-datos
  (import MAIN ?ALL)
  (import recopilacion-datos ?ALL)
  (import recopilacion-preferencias ?ALL)
  ;(import recopilacion-conocimiento ?ALL)
  (export ?ALL)
  )


;;; Modulo de filtrado de platos en base al conocimiento del usuario y creacion
;;; de posibles menus.
;;; En este modulo
;;; Para acabar con todos los platos y peticiones/prefe del usuario se crean todos
;;; los menus posibles y se guardan en hechos.
(defmodule filtrar
  (import MAIN ?ALL)
  (import recopilacion-datos ?ALL)
  (import recopilacion-preferencias ?ALL)
  (import recopilacion-conocimiento ?ALL)
  (import inferir-datos ?ALL)
  (export ?ALL)
)
;;; Modulo que descarta los menus, para cojer como maximo tres.
;;; En este modulo se trata con los menus creados y se selecionan como máximo tres,
;;; uno con el coste mínimo, un con el máximo y un coste medio.
(defmodule obtener-resultados
  (import MAIN ?ALL)
  (import recopilacion-datos ?ALL)
  (import recopilacion-preferencias ?ALL)
  (import recopilacion-conocimiento ?ALL)
  (import inferir-datos ?ALL)
  (import filtrar ?ALL)
  (export ?ALL)
)

;;; Modulo que imprime por pantalla los menus selecionados.
;;; Como maximo tres.
(defmodule imprimir-resultados
  (import MAIN ?ALL)
  (import recopilacion-datos ?ALL)
  (import recopilacion-preferencias ?ALL)
  (import recopilacion-conocimiento ?ALL)
  (import inferir-datos ?ALL)
  (import filtrar ?ALL)
  (import obtener-resultados ?ALL)
  (export ?ALL)
)

;;;--------------------- MAIN --------------------------------------------------

(defrule MAIN::initialRule "Primera regla"
  (declare (salience 10))
  =>
  (printout t crlf)
  (printout t "Sistema de Recomendacion de Menus" crlf)
  (printout t "---------------------------------" crlf)
  (printout t crlf)
  (printout t crlf)
  (printout t "----------------------" crlf)
  (printout t "Bienvenido a Rico Rico" crlf)
  (printout t "----------------------" crlf)
  (printout t crlf)
  (printout t crlf)
  (focus recopilacion-datos)
)


;;;--------------------   TEMPLATES   ------------------------------------------

;;; template para las preguntas de la reserva (tipo de reserva (familiar/congreso),
;;; numero de comensales, estacion en la que se celebra, precio minimo y precio maximo)
(deftemplate MAIN::pregunta-reserva
  (slot tamano (type INTEGER))
  (slot estacion (type INSTANCE))
  (slot precioMin (type FLOAT) (default 0.0))
  (slot precioMax (type FLOAT) (default 0.0))
  (slot tipo (type STRING))
)

;;; template para las preferencias del usuario (temperatura (frio, caliente, templado o no importa),
;;; vino para el menu (true, no importa), bebida por plato (si, no), vegetariano (si, no importa), ingredientes prohibidos)
(deftemplate MAIN::preferencias-reserva
  (multislot temperatura (type STRING))
  (slot vino (type SYMBOL) (allowed-values FALSE TRUE Indef) (default Indef))
  (slot bebidaPorPlato (type SYMBOL) (allowed-values FALSE TRUE Indef) (default Indef))
  (slot menuVegetariano (type SYMBOL) (allowed-values TRUE FALSE Indef) (default Indef))
  (multislot ingredientesProhibidos (type INSTANCE) (default [nil]))
)

;;;template para el conocimiento que tendremos de los comnezales
;;; quer regiones, estilos, y tipos de platos prefieren.
(deftemplate MAIN::conocimiento-reserva
  (multislot regiones (type INSTANCE) (default [nil]))
  (multislot estilos  (type INSTANCE) (default [nil]))
  (multislot tipos    (type INSTANCE) (default [nil]))

)

;;; template para el menu (con una sola bebida) -> (primer plato, segundo plato, postre, bebida, precio)
(deftemplate MAIN::menu-simple
  (slot primerPlato (type INSTANCE))
  (slot segundoPlato (type INSTANCE))
  (slot postre (type INSTANCE))
  (slot bebida (type INSTANCE))
  (slot precio (type INTEGER))
)

;;; template para el menu (con bebida diferente por plato)
;;; (primer plato, primera bebida, segundo plato, segunda bebida, postre, bebida postre, precio)
(deftemplate MAIN::menu-completo
  (slot primerPlato (type INSTANCE))
  (slot primeraBebida (type INSTANCE))
  (slot segundoPlato (type INSTANCE))
  (slot segundaBebida (type INSTANCE))
  (slot postre (type INSTANCE))
  (slot bebidaPostre (type INSTANCE))
  (slot precio (type INTEGER))
)

;;;template con los tres posibles precios de los menus selecionados
(deftemplate MAIN::precios-menus
  (slot bajo (type INTEGER))
  (slot medio (type INTEGER))
  (slot alto (type INTEGER))
)
;;; templates que representan un plato.
(deftemplate MAIN::plato1 (slot plato (type INSTANCE)) (slot precio (type FLOAT)))
(deftemplate MAIN::plato2 (slot plato (type INSTANCE)) (slot precio (type FLOAT)))
(deftemplate MAIN::plato3 (slot plato (type INSTANCE)) (slot precio (type FLOAT)))


;;;-------------------    FUNCIONES     ----------------------------------------

;;; ------------ preguntas al usuario ----------
;;;---------------------------------------------


;;; Pregunta numerica con un intervalo (entre min y max)
(deffunction MAIN::pregunta-numerica (?pregunta ?min ?max)
  (format t "%s [%d, %d] " ?pregunta ?min ?max)
  (bind ?respuesta (read))
  (while (not (and(>= ?respuesta ?min) (<= ?respuesta ?max))) do
    (printout t "Por favor introduzca un valor del intervalo." crlf)
    (format t "%s [%d, %d] " ?pregunta ?min ?max)
    (bind ?respuesta (read))
  )
  ?respuesta
)

;;; Pregunta entre dos opciones (op1 O op2) -> escoge una
(deffunction MAIN::pregunta-2opciones (?pregunta ?op1 ?op2)
  (format t "%s [%s / %s] " ?pregunta ?op1 ?op2)
  (bind ?respuesta (read))
  (while (not (or(eq ?respuesta ?op1) (eq ?respuesta ?op2))) do
    (printout t "Por favor introduzca una opcion valida" crlf)
    (format t "%s [%s / %s] " ?pregunta ?op1 ?op2)
    (bind ?respuesta (read))
  )
  ?respuesta
)

;;; Pregunta entre tres opciones (op1 O op2) -> escoge una
(deffunction MAIN::pregunta-3opciones (?pregunta ?op1 ?op2 ?op3)
  (format t "%s [%s / %s / %s] " ?pregunta ?op1 ?op2 ?op3)
  (bind ?respuesta (read))
  (while (not (or(eq ?respuesta ?op1) (or (eq ?respuesta ?op2) (eq ?respuesta ?op3)))) do
    (printout t "Por favor introduzca una opcion valida" crlf)
    (format t "%s [%s / %s / %s] " ?pregunta ?op1 ?op2 ?op3)
    (bind ?respuesta (read))
  )
  ?respuesta
)

;;; Pregunta de opciones multiples -> tiene que escoje un subconjunto
(deffunction MAIN::pregunta-opciones (?pregunta $?opciones)
  (bind ?linea (format nil "%s" ?pregunta))
  (printout t ?linea crlf)
  (progn$ (?var ?opciones)
    (bind ?linea (format nil " %d. %s" ?var-index ?var))
    (printout t ?linea crlf)
  )
  (format t "%s" "Indica los numeros seleccionados: ")
  (bind ?resp (readline))
  (bind ?numeros (str-explode ?resp))
  (bind $?lista (create$ ))
  (progn$ (?var ?numeros)
      (if (and (integerp ?var) (and (>= ?var 1) (<= ?var (length$ ?opciones))))
          then
            (if (not (member$ ?var ?lista))
              then
                (bind ?lista (insert$ ?lista (+ (length$ ?lista) 1) ?var))
            )
      )
  )
  ?lista
)

;;;Funcion que indica si algun elemento de la lista a pertenece a la lista b
;;; util para comprobar su un plato cumple alguna de las preferencias.
(deffunction MAIN::pertenece-alguna (?a ?b)
  (bind ?i 1)   (bind ?c FALSE)
  (while (and (eq ?c FALSE) (<= ?i (length$ $?a)))
      (bind ?curr (nth$ ?i $?a))
      (if (member$ ?curr $?b) then (bind ?c TRUE))
      (bind ?i (+ ?i 1))
  )
  (return ?c)
)

;;; Indica si todos los numeros de a estan entre min y max
(deffunction MAIN::intervalos-correctos (?min ?max $?a)
  (bind ?i 1) (bind ?c TRUE)
  (while (and (eq ?c TRUE) (<= ?i (length$ $?a)))
      (bind ?curr (nth$ ?i $?a))
      (if (or (< ?curr ?min) (> ?curr ?max)) then (bind ?c FALSE))
      (bind ?i (+ ?i 1))
    )
  (return ?c)
)


;;;---------------------   MODULO DE PREGUNTAS  --------------------------------

;;; Preguntas al usuario para los datos de la reserva (tamano, precioMin y precioMax, estacion y tipo de evento)

;;; Numero de comensales (tamano)
(defrule recopilacion-datos::establecer-tamano "¿Cual sera el numero de comensales?"
  (not (pregunta-reserva))
  =>
  (bind ?tamano (pregunta-numerica "¿Cual sera el numero de comensales?" 1 500))
  (assert (pregunta-reserva (tamano ?tamano)))
)

;;; Precio minimo por comensal (precioMin)
(defrule recopilacion-datos::establecer-precioMin "¿Cual es el presupuesto minimo por comensal?"
  ?u <- (pregunta-reserva (tamano ?tamano) (precioMin ?p))
  (test (eq ?p 0.0))
  =>
  (bind ?e (pregunta-numerica "¿Cual es el presupuesto minimo por comensal?" 14 56))
  (modify ?u (precioMin ?e))
)

;;; Precio maximo por comensal (precioMax)
(defrule recopilacion-datos::establecer-precioMax "¿Cual es el presupuesto maximo por comensal?"
  ?u <- (pregunta-reserva (tamano ?t) (precioMin ?pm) (precioMax ?pM))
  (test (> ?pm 0.0))
  (test (eq ?pM 0.0))
  =>
  (bind ?e (pregunta-numerica "¿Cual es el presupuesto maximo por comensal?" ?pm 56))
  (modify ?u (precioMax ?e))
)

;;; Estacion de la reserva (estacion)
(defrule recopilacion-datos::establecer-estacion "¿En que estacion es la reserva?"
  ?u <- (pregunta-reserva (tamano ?t) (precioMin ?min) (precioMax ?max) (estacion ?est))
  (test (eq ?est [nil]))
  =>
  (bind $?estaciones (find-all-instances ((?inst Estacion)) (neq ?inst:Nombre "siempre")))
  (bind $?nombres (create$))
  ;(printout t (length $?estaciones) crlf)
  (loop-for-count (?i 1 (length$ $?estaciones)) do
    (bind ?objeto (nth$ ?i ?estaciones))
    (bind ?nombre (send ?objeto get-Nombre))
    ;(printout t ?nombre crlf)
    (bind $?nombres(insert$ $?nombres (+ (length$ $?nombres) 1) ?nombre))
  )
  (bind ?respuesta (pregunta-opciones "¿Para que estacion es la reserva?" $?nombres))
  (bind ?indice (nth$ 1 ?respuesta))
  (while (not (integerp ?indice))
    (printout t "Por favor introduzca una opcion valida" crlf)
    (bind ?respuesta (pregunta-opciones "¿Para que estacion es la reserva?" $?nombres))
    (bind ?indice (nth$ 1 ?respuesta))
  )
  (bind ?r (nth$ ?indice ?estaciones))
  (modify ?u (estacion ?r))
)

; ;;; Tipo de evento (tipo)
(defrule recopilacion-datos::establecer-tipo-evento "¿Que tipo de celebracion sera? (familiar o congresos)"
  ?u <- (pregunta-reserva (tamano ?t) (precioMin ?min) (precioMax ?max) (estacion ?est) (tipo ?tip))
  (test (eq ?tip ""))
  =>
  (bind ?tip (pregunta-2opciones "¿Que tipo de celebracion sera?" Familiar Congreso))
  (modify ?u (tipo ?tip))
  (focus recopilacion-preferencias)
)


;;; Preguntas al usuario para las preferencias (temperatura, vino, bebidaPorPlato, menuVegetariano, ingredientesProhibidos)

(deffacts recopilacion-preferencias::instancias-vacias "Establece hechos vacios para no repetir reglas"
  (temperatura t)
  (vino v)
  (bebidaPorPlato bbp)
  (menuVegetariano veg)
  (ingredientesProhibidos ip)
  (preferencias-reserva)
)

;;; Temperatura del menu (frio, caliente, templado o no importa)
(defrule recopilacion-preferencias::temperatura-menu "¿Que temperatura prefiere que tengan los platos del menu?"
  ?u <- (preferencias-reserva)
  ?t <- (temperatura t)
  =>
  (bind $?temperaturas (explode$ "frio caliente templado indiferente"))
  (bind ?respuesta (pregunta-opciones "¿Que temperatura prefiere que tengan los platos del menu? Escoja una opcion." $?temperaturas))
  (while (eq (intervalos-correctos 1 (length$ $?temperaturas) $?respuesta) FALSE)
    (printout t "Por favor introduzca una opcion valida" crlf)
    (bind ?respuesta (pregunta-opciones
      "¿Que temperatura prefiere que tengan los platos del menu? Escoja una opcion." $?temperaturas))
  )

  (bind $?ings (create$ ))
  (loop-for-count (?i 1 (length ?respuesta)) do
    (bind ?pos (nth$ ?i ?respuesta))        ;numero del ingrediente seleccionado (pos)
    (bind ?ing (str-cat (nth$ ?pos ?temperaturas)))   ;ingrediente pos
    (bind $?ings (insert$ $?ings (+ (length$ $?ings) 1) ?ing))
  )
  (modify ?u (temperatura $?ings))
  (retract ?t)
)

;;; Vino con el menu (si quiere que la bebida del menu sea vino, o le es indiferente)
;;; y si quiere un vino por plato
(defrule recopilacion-preferencias::vino-menu "¿Querra vino con el menu?, y si quiere, por menu o plato"
  ?u <- (preferencias-reserva)
  ?vino <- (vino v)
  ?bebida <- (bebidaPorPlato bbp)
  =>

  (bind ?vin (pregunta-2opciones "¿Querra que la bebida sea vino o le es indiferente?" Vino Indiferente))
  (if (eq ?vin Vino)
    then
      (bind ?qvino TRUE) ;si quiere vino, vino = true
      (bind ?bebidaMenu (pregunta-2opciones "¿Prefiere tener una bebida por cada plato o una para misma todo el menu?" Plato Menu))
      (if (eq ?bebidaMenu Menu)
        then
          (modify ?u (vino TRUE) (bebidaPorPlato FALSE))  ;si quiere la misma bebida para todo el menu, bebidaPorPlato = false
        else
          (modify ?u (vino TRUE)(bebidaPorPlato TRUE))   ;si quiere una bebida por cada plato, bebidaPorPlato = true
      )
    else
      (modify ?u (vino FALSE))
  )
  (retract ?vino)
  (retract ?bebida)
)

;;; Menu vegetariano o no importa
(defrule recopilacion-preferencias::menu-vegetariano "¿Prefiere que el menu sea apto para vegetarianos?"
  ?u <- (preferencias-reserva)
  ?veg <- (menuVegetariano veg)
  =>
  (bind ?veget (pregunta-2opciones "¿Prefiere que el menu sea apto para vegetarianos o le es indiferente?" Si Indiferente))
  (if (eq ?veget Si)
    then
      (modify ?u (menuVegetariano TRUE))
    else
      (modify ?u (menuVegetariano FALSE))
  )
  (retract ?veg)
)

;;; Ingredientes prohibidos
(defrule recopilacion-preferencias::ingredientes-prohibidos "¿Quiere que algun ingrediente NO se use en los platos del menu?"
  ?u <- (preferencias-reserva)
  ?ip <- (ingredientesProhibidos ip)
  =>
  (bind ?restIng (pregunta-2opciones "¿Quiere restringir el uso de algun ingrediente? Las restricciones pueden afectar a las recomendaciones." Si No))
  (if (eq ?restIng Si)
    then
      (bind $?ingredientes (find-all-instances ((?inst Ingrediente)) TRUE))
      (bind $?nombres (create$))
      (loop-for-count (?i 1 (length$ $?ingredientes)) do
        (bind ?objeto (nth$ ?i ?ingredientes))
        (bind ?nombre (send ?objeto get-Nombre))
        (bind $?nombres(insert$ $?nombres (+ (length$ $?nombres) 1) ?nombre))
      )
      (bind $?respuesta (pregunta-opciones "Seleccione los ingredientes que NO se usaran:" $?nombres))
      (bind $?ings (create$ ))
      (loop-for-count (?i 1 (length ?respuesta)) do
        (bind ?pos (nth$ ?i ?respuesta))    ;numero del ingrediente seleccionado (pos)
        (bind ?ing (nth$ ?pos ?ingredientes))  ;ingrediente pos
        (bind $?ings (insert$ $?ings (+ (length$ $?ings) 1) ?ing))
      )
      (modify ?u (ingredientesProhibidos ?ings))
  )
  (retract ?ip)
  (focus recopilacion-conocimiento)

)


;;;-------------------- modulo de recopilacion del conocimiento ----------------

(deffacts recopilacion-conocimiento::instancias-vacias1 "Establece hechos vacios para no repetir reglas"
  (estilos est)
  (tipos tip)
  (regiones reg)
  (conocimiento-reserva)
)

(defrule recopilacion-conocimiento::leer-regiones "¿De que regiones prefiere los platos?"
  ?u <- (conocimiento-reserva)
  ?v <- (regiones reg)
  =>
  (bind $?regiones (find-all-instances ((?inst Region)) (neq ?inst:Nombre "siempre")))
  (bind $?nombres (create$))
  ;(printout t (length $?estaciones) crlf)
  (loop-for-count (?i 1 (length$ $?regiones)) do
    (bind ?objeto (nth$ ?i ?regiones))
    (bind ?nombre (send ?objeto get-Nombre))
    ;(printout t ?nombre crlf)
    (bind $?nombres(insert$ $?nombres (+ (length$ $?nombres) 1) ?nombre))
  )
  (bind ?respuesta (pregunta-opciones "¿De que regiones prefieres los platos?" $?nombres))
  (bind $?escojido (create$ ))
  (loop-for-count (?i 1 (length$ ?respuesta)) do
    (bind ?curr-index (nth$ ?i ?respuesta))
    (bind ?curr-atr (nth$ ?curr-index ?regiones))
    (bind $?escojido(insert$ $?escojido (+ (length$ $?escojido) 1) ?curr-atr))
  )
  (modify ?u (regiones $?escojido))
  (retract ?v)
  ;(printout t "fin" crlf)
)

(defrule recopilacion-conocimiento::leer-estilos "¿Que estilos de plato prefiere?"
  ?u <- (conocimiento-reserva)
  ?v <- (estilos est)
  =>
  (bind $?regiones (find-all-instances ((?inst Estilo)) (neq ?inst:Nombre "siempre")))
  (bind $?nombres (create$))
  ;(printout t (length $?estaciones) crlf)
  (loop-for-count (?i 1 (length$ $?regiones)) do
    (bind ?objeto (nth$ ?i ?regiones))
    (bind ?nombre (send ?objeto get-Nombre))
    ;(printout t ?nombre crlf)
    (bind $?nombres(insert$ $?nombres (+ (length$ $?nombres) 1) ?nombre))
  )
  (bind ?respuesta (pregunta-opciones "¿Que estilos de platos prefieres?" $?nombres))
  (bind $?escojido (create$ ))
  (loop-for-count (?i 1 (length$ ?respuesta)) do
    (bind ?curr-index (nth$ ?i ?respuesta))
    (bind ?curr-atr (nth$ ?curr-index ?regiones))
    (bind $?escojido(insert$ $?escojido (+ (length$ $?escojido) 1) ?curr-atr))
  )
  (modify ?u (estilos $?escojido))
  (retract ?v)
  ;(printout t "fin" crlf)
)

(defrule recopilacion-conocimiento::leer-tipos "¿Que tipos de platos quiere que forme su menu?"
  ?u <- (conocimiento-reserva)
  ?v <- (tipos tip)
  =>
  (bind $?regiones (find-all-instances ((?inst Tipo)) (neq ?inst:Nombre "siempre")))
  (bind $?nombres (create$))
  ;(printout t (length $?estaciones) crlf)
  (loop-for-count (?i 1 (length$ $?regiones)) do
    (bind ?objeto (nth$ ?i ?regiones))
    (bind ?nombre (send ?objeto get-Nombre))
    ;(printout t ?nombre crlf)
    (bind $?nombres(insert$ $?nombres (+ (length$ $?nombres) 1) ?nombre))
  )
  (bind ?respuesta (pregunta-opciones "¿Que tipo de platos prefieres?" $?nombres))
  (bind $?escojido (create$ ))
  (loop-for-count (?i 1 (length$ ?respuesta)) do
    (bind ?curr-index (nth$ ?i ?respuesta))
    (bind ?curr-atr (nth$ ?curr-index ?regiones))
    (bind $?escojido(insert$ $?escojido (+ (length$ $?escojido) 1) ?curr-atr))
  )
  (modify ?u (tipos $?escojido))
  (retract ?v)
  ;(printout t "fin" crlf)
  (focus inferir-datos)
)

;;;-----------------------------------------------------------------------------
;;;--------------- PARTE EN LA QUE INFERIMOS LOS DATOS A LA CLASE ---------------
;;;-----------------------------------------------------------------------------

;;;Creamos la reserva y le damos los valores leidos.
(defrule inferir-datos::crear-reserva
  ?u <- (pregunta-reserva (tamano ?tamano) (estacion ?est) (precioMin ?min) (precioMax ?max) (tipo ?tip))
  ?v <- (preferencias-reserva (temperatura $?temp) (vino ?vi) (bebidaPorPlato ?bp) (menuVegetariano ?mv)
                              (ingredientesProhibidos $?ip))
  (not (crear-reserva-definido))
  =>
  (switch ?tamano
    (case 1 then
        (bind ?tipoGrupo SOLO))
    (case 2 then
        (bind ?tipoGrupo PAREJA))
    (default
      (if (< ?tamano 50) then
        (bind ?tipoGrupo PEQUENO)
      else
          (bind ?tipoGrupo GRANDE)
      )
    )
  )
    (bind ?nuevaReserva (make-instance reserva of Reserva))

    (send ?nuevaReserva put-precio_minimo ?min)
    (send ?nuevaReserva put-precio_maximo ?max)
    (send ?nuevaReserva put-Numero_de_comensales ?tipoGrupo)
    (send ?nuevaReserva put-Tipo_de_celebracion ?tip)
    (send ?nuevaReserva put-temperatura ?temp)
    (send ?nuevaReserva put-Vino ?vi)
    (send ?nuevaReserva put-vinoPlato ?bp)
    (send ?nuevaReserva put-Vegetariano ?mv)
    (send ?nuevaReserva put-estacion_preferencia ?est)

  (assert (crear-reserva-definido))

  ;(printout t "mirar si llega hasta aqui" crlf)
)

;;; Creamos la instancia de la clase preferencia y la asociamos a la reserva.
(defrule inferir-datos::crear-preferencias
  (crear-reserva-definido)
  (not (crear-reserva-preferencias))
  ?v <- (preferencias-reserva (temperatura $?temp) (vino ?vi) (bebidaPorPlato ?bp) (menuVegetariano ?mv)
                              (ingredientesProhibidos $?ip))
  ?f <- (pregunta-reserva (estacion ?est))
  ?d <- (conocimiento-reserva (tipos $?tipos) (estilos $?estilos) (regiones $?regiones))
  ?reserva <- (object (is-a Reserva))
  =>
  (bind ?nuevasPreferencias (make-instance preferencias of Preferencias))
  (send ?nuevasPreferencias put-ingrediente_prohibido $?ip)
  (send ?nuevasPreferencias put-estilo_preferencia $?estilos)

  (send ?reserva put-preferencia_reserva ?nuevasPreferencias)
  (assert (crear-reserva-preferencias))

  ;(printout t "He logrado crear las nuevas clases" crlf)
)

;;; Regla que analiza todos los platos de la base de datos y los guarda como hechos
;;; si son adecuados para formar un menu.
;;; La regla esta llena de pritouts para poder debugar cada plato y comprobar cuando
;;; es descatados.
(defrule inferir-datos::crear-platos
  (crear-reserva-definido)
  (crear-reserva-preferencias)
  ?v <- (preferencias-reserva (temperatura $?temp) (vino ?vi) (bebidaPorPlato ?bp) (menuVegetariano ?mv)
                              (ingredientesProhibidos $?ip))
  ?f <- (pregunta-reserva (estacion ?est) (tipo ?tipo) (tamano ?tam))
  ?d <- (conocimiento-reserva (tipos $?tipos) (estilos $?estilos) (regiones $?regiones))
  =>

  (bind $?platos (find-all-instances ((?inst Plato)) TRUE))
  (loop-for-count (?i 1 (length$ $?platos)) do
          ;(printout t crlf crlf crlf)

    (bind ?curr-plato (nth$ ?i $?platos))
    (bind ?complj (send ?curr-plato get-Complejidad))
    (bind ?pos TRUE)
    (if (and (> ?tam 60) (> ?complj 1)) then (bind ?pos FALSE)
    else
      (if (and (> ?tam 30) (> ?complj 2)) then (bind ?pos FALSE))
    )

        ;(printout t "Nombre del plato: " ?curr-plato crlf)
    (bind ?v1 (send ?curr-plato get-Vegetariano))
    (if (eq ?v1 "true") then
      (bind ?v2 TRUE)
      else
        (bind ?v2 FALSE)
    )
    ;(assert (plato2 (plato ?curr-plato)))
    (bind ?t1 (send ?curr-plato get-Temperatura))
    (bind $?ing (send ?curr-plato get-contieneIngrediente))
    ;(printout t "Complejidad plato: " ?complj crlf)
    ;(printout t "Ingredientes prohibidos: " $?ip crlf)
    ;(printout t "Vegano, primero plato, despues preferencia:" crlf)
    ;(printout t ?v2 crlf)
    ;(printout t ?mv crlf)
    ;(printout t "Temperatura, primero plato, despues preferencia:" crlf)
    ;(printout t ?t1 crlf)
    ;(printout t ?temp crlf)

    (if (and  (eq ?pos TRUE)
        (and  (or (eq (length$ $?ip) 0) (eq (pertenece-alguna $?ip $?ing) FALSE))
        (and  (or (eq ?mv FALSE) (eq ?v2 ?mv))
              (or (member$ "indiferente" $?temp) (member ?t1 $?temp))))) then

            ;(printout t "1" crlf)

      (bind ?est1 (send ?curr-plato get-estacion_comida))
      ;(printout t (str-cat ?est) crlf)
      ;(printout t "Estacion, primero plato, despues preferencia:" crlf)
      ;(printout t (str-cat (instance-name ?est1)) crlf)
      ;(printout t (str-cat (instance-name ?est)) crlf)
      (if (or (eq (str-cat (instance-name ?est1)) "siempre") (eq ?est1 ?est)) then
              ;(printout t "2" crlf)
        (bind ?reg1 (send ?curr-plato get-region_comida))
              ;(printout t "Regiones, primero plato, despues preferencias:" crlf)
              ;(printout t ?reg1 crlf)
              ;(printout t $?regiones crlf)

        (if (member$ ?reg1 $?regiones) then
              ;(printout t "3" crlf)
          (bind ?tip1 (send ?curr-plato get-tipo_comida))
              ;(printout t "Tipos, primero plato, despues preferencias." crlf)
            ;  (printout t $?tip1 crlf)
              ;(printout t $?tipos crlf)

          (if (or  (pertenece-alguna $?tip1 $?tipos) (eq (length$ $?tip1) 0)) then
              ;(printout t "4" crlf)
            (bind $?est1 (send ?curr-plato get-estilo_plato))
                  ;(printout t "Estilos, primero plato, despues preferencias" crlf)
                  ;(printout t $?est1 crlf)
                  ;(printout t $?estilos crlf)

              (if (or  (pertenece-alguna $?est1 $?estilos) (eq (length$ $?est1) 0)) then
                      ;(printout t "5" crlf)
                (bind $?orden (send ?curr-plato get-OrdenPlato))
                ;(printout t $?orden crlf)

                (bind ?n 1)
                (while (<= ?n (length$ $?orden))
                (bind ?orden-act (nth$ ?n $?orden))
                (bind ?pre (send ?curr-plato get-Precio))
                (if (eq ?orden-act "primero") then

                  (assert (plato1 (plato ?curr-plato) (precio ?pre)))
                )
                (if (eq ?orden-act "segundo") then
                  (assert (plato2 (plato ?curr-plato) (precio ?pre)))
                )
                (if (eq ?orden-act "tercero") then
                  (assert (plato3 (plato ?curr-plato) (precio ?pre)))
                )

                (bind ?n (+ ?n 1))
                )
              )
          )
        )
      )
    )

  )
  ;(printout t "calculado platos" crlf)
  (focus filtrar)
  (assert (filtro-hecho a))
)

(defrule inferir-datos::siguiente-modulo
  (filtro-hecho a)
  =>
  ;(retract (filtro-hecho a))
  (focus obtener-resultados)
)

;;;-----------------------------------------------------------------------------
;;;------------------- Modulo para Filtrar los Menus ---------------------------
;;;-----------------------------------------------------------------------------

;;; Regla para crear todos los menus simples sin vino posibles con los platos guardados en
;;; hechos y respectando las condiciones leidas.

(defrule filtrar::menus-sin-vino-simple
  ?v <- (preferencias-reserva (vino ?vi) (bebidaPorPlato ?bp))
  ?f <- (pregunta-reserva (estacion ?est) (tipo ?tipo) (precioMin ?min) (precioMax ?max))
  ?d <- (conocimiento-reserva (tipos $?tipos) (estilos $?estilos) (regiones $?regiones))

  ?pp1 <- (plato1 (plato ?p1) (precio ?e1))
  ?pp2 <- (plato2 (plato ?p2) (precio ?e2))
  ?pp3 <- (plato3 (plato ?p3) (precio ?e3))
  (test (eq ?vi FALSE))
  (test (>= (+ ?e1 (+ ?e2 ?e3)) ?min))
  (test (<= (+ ?e1 (+ ?e2 ?e3)) ?max))

  (test (neq ?p1 ?p2))
  =>
  (bind $?bebidas (find-all-instances ((?inst Bebida)) (eq ?inst:Vino "false")))
  (bind ?bebida (nth$ (random 1 (length$ $?bebidas)) $?bebidas))
  (assert (menu-simple (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (bebida ?bebida) (precio (+ ?e1 (+ ?e2 ?e3)))))
)

;;; Idem que antes pero para menus complejos con vino.
(defrule filtrar::menus-con-vino-complejo
  ?v <- (preferencias-reserva (vino ?vi) (bebidaPorPlato ?bp))
  ?f <- (pregunta-reserva (tipo ?tipo) (precioMin ?min) (precioMax ?max))
  ?d <- (conocimiento-reserva (tipos $?tipos) (estilos $?estilos) (regiones $?regiones))

  ?pp1 <- (plato1 (plato ?p1) (precio ?e1))
  ?pp2 <- (plato2 (plato ?p2) (precio ?e2))
  ?pp3 <- (plato3 (plato ?p3) (precio ?e3))
  (test (neq ?p1 ?p2))
  (test (eq ?vi TRUE))
  (test (eq ?bp TRUE))
  (test (>= (+ ?e1 (+ ?e2 ?e3)) ?min))
  (test (<= (+ ?e1 (+ ?e2 ?e3)) ?max))
  =>
  (bind $?bebida (send ?p1 get-compatibilidadConBebida))
  (if (eq (length$ $?bebida) 1) then (bind ?vino1 (nth$ 1 $?bebida)))
  (if (> (length$ $?bebida) 1) then (bind ?vino1 (nth$ (random 1 (length$ $?bebida)) $?bebida)))
  (if (eq (length$ $?bebida) 0) then (bind ?vino1 (nth$ 1 (find-instance ((?inst Bebida)) (and  (eq ?inst:Vino "true") (eq ?inst:Precio 0))))))
  ;(printout t ?p1 crlf)
  ;(printout t ?vino1 crlf)
  (bind ?pr1 (send ?vino1 get-Precio_copa))

  (bind $?bebida (send ?p2 get-compatibilidadConBebida))
  (if (eq (length$ $?bebida) 1) then (bind ?vino2 (nth$ 1 $?bebida)))
  (if (> (length$ $?bebida) 1) then (bind ?vino2 (nth$ (random 1 (length$ $?bebida)) $?bebida)))
  (if (eq (length$ $?bebida) 0) then (bind ?vino2 (nth$ 1 (find-instance ((?inst Bebida)) (and  (eq ?inst:Vino "true") (eq ?inst:Precio 0))))))
  ;(printout t ?p1 crlf)
  ;(printout t ?vino2 crlf)
  (bind ?pr2 (send ?vino2 get-Precio_copa))

  (bind $?bebida (send ?p3 get-compatibilidadConBebida))
  (if (eq (length$ $?bebida) 1) then (bind ?vino3 (nth$ 1 $?bebida)))
  (if (> (length$ $?bebida) 1) then (bind ?vino3 (nth$ (random 1 (length$ $?bebida)) $?bebida)))
  (if (eq (length$ $?bebida) 0) then (bind ?vino3 (nth$ 1 (find-instance ((?inst Bebida)) (and  (eq ?inst:Vino "true") (eq ?inst:Precio 0))))))
  ;(printout t ?p1 crlf)
  ;(printout t ?vino3 crlf)

  (bind ?pr3 (send ?vino3 get-Precio_copa))

  (if (<= (+ ?e1 (+ ?e2 (+ ?e3 (+ ?pr1 (+ ?pr2 ?pr3))))) ?max) then
    (assert (menu-completo (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3)
                (primeraBebida ?vino1) (segundaBebida ?vino2) (bebidaPostre ?vino3 )
                (precio (+ ?e1 (+ ?e2 (+ ?e3 (+ ?pr1 (+ ?pr2 ?pr3))))))))
  )
)

;;; Idem que antes para menus simple con vino
(defrule filtrar::menus-con-vino-simple
  ?v <- (preferencias-reserva (vino ?vi) (bebidaPorPlato ?bp))
  ?f <- (pregunta-reserva (estacion ?est) (tipo ?tipo) (precioMin ?min) (precioMax ?max))
  ?d <- (conocimiento-reserva (tipos $?tipos) (estilos $?estilos) (regiones $?regiones))

  ?pp1 <- (plato1 (plato ?p1) (precio ?e1))
  ?pp2 <- (plato2 (plato ?p2) (precio ?e2))
  ?pp3 <- (plato3 (plato ?p3) (precio ?e3))
  (test (eq ?vi TRUE))
  (test (eq ?bp FALSE))
  (test (>= (+ ?e1 (+ ?e2 ?e3)) ?min))
  (test (<= (+ ?e1 (+ ?e2 ?e3)) ?max))

  (test (neq ?p1 ?p2))
  =>

  (bind $?bebida (send ?p2 get-compatibilidadConBebida))
  (if (eq (length$ $?bebida) 1) then (bind ?vino-escojido (nth$ 1 $?bebida)))
  (if (> (length$ $?bebida) 1) then (bind ?vino-escojido (nth$ (random 1 (length$ $?bebida)) $?bebida)))
  (if (eq (length$ $?bebida) 0) then (bind ?vino-escojido (nth$ 1 (find-instance ((?inst Bebida)) (and  (eq ?inst:Vino "true") (eq ?inst:Precio 0))))))
  (bind ?pr (send ?vino-escojido get-Precio))
  (if (<= (+ ?e1 (+ ?e2 (+ ?e3 ?pr))) ?max) then
    (assert (menu-simple (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (bebida ?vino-escojido) (precio (+ ?e1 (+ ?e2 (+ ?e3 ?pr))))))
    )
)

;;;-----------------------------------------------------------------------------
;;;-------------------MODULO PARA OBTENER LOS RESULTADOS ------------------------------
;;;-----------------------------------------------------------------------------
;;; Cada regla seleciona como maximo tres precios de los menus creados, para un menu
;;; simple o uno completo.

(defrule obtener-resultados::imprimir-menus-simple
  (not (fin))
  ?v <- (preferencias-reserva (vino ?vi) (bebidaPorPlato ?bp))
  (test (or (eq ?bp FALSE) (eq ?bp Indef)))
  =>
  (bind ?min 10000)
  (bind ?max 0)
  (bind ?med 0)
  (do-for-all-facts ((?f menu-simple)) TRUE
    (if (< ?f:precio ?min) then (bind ?min ?f:precio))
    (if (> ?f:precio ?max) then (bind ?max ?f:precio))
  )
  (bind ?diff (/ (- ?max ?min) 3))
  (do-for-fact ((?f menu-simple)) (and (>= ?f:precio (+ ?min ?diff)) (<= ?f:precio (- ?max ?diff)))
    (bind ?med ?f:precio)
  )
  ;(printout t ?min " " ?med " " ?max crlf)

  (do-for-all-facts ((?f menu-simple)) (not (or (eq ?f:precio ?min) (or (eq ?f:precio ?med) (eq ?f:precio ?max))))
    (retract ?f)
  )
  ;(printout t "he eliminado facts" crlf)
  (assert (precios-menus (bajo ?min) (medio ?med) (alto ?max)))


  (assert (fin))
)

(defrule obtener-resultados::imprimir-menus-completo
  (not (fin))
  ?v <- (preferencias-reserva (vino ?vi) (bebidaPorPlato ?bp))
  (test (eq ?bp TRUE))
  =>
  (bind ?min 10000)
  (bind ?max 0)
  (bind ?med 0)
  (do-for-all-facts ((?f menu-completo)) TRUE
    (if (< ?f:precio ?min) then (bind ?min ?f:precio))
    (if (> ?f:precio ?max) then (bind ?max ?f:precio))
  )
  (bind ?diff (/ (- ?max ?min) 3))
  (do-for-fact ((?f menu-completo)) (and (>= ?f:precio (+ ?min ?diff)) (<= ?f:precio (- ?max ?diff)))
    (bind ?med ?f:precio)
  )
  ;(printout t ?min " " ?med " " ?max crlf)

  (do-for-all-facts ((?f menu-completo)) (not (or (eq ?f:precio ?min) (or (eq ?f:precio ?med) (eq ?f:precio ?max))))
    (retract ?f)
  )
  ;(printout t "he eliminado facts" crlf)
  (assert (precios-menus (bajo ?min) (medio ?med) (alto ?max)))

)

(defrule obtener-resultados::paso-a-imprimir
  (precios-menus)
  =>
  (focus imprimir-resultados)
)

(defrule imprimir-resultados::comienzo
  (declare (salience 10))
  =>
  (printout t crlf)
  (printout t "-------------------------------------------------------" crlf)
  (printout t "Los Menus que le ofrecemos, adaptados a sus gustos son:" crlf)
  (printout t "-------------------------------------------------------" crlf)
)

;;;---------------- MUDULO PARA IMPRIMIR RESULTADOS ----------------------------

;;; Cada Regla imprime Un menu economico, mediano y caro si existen.
;;; Si  no existe, hay una regla indicando que no ha sido posible crear un menu.

(defrule imprimir-resultados::imprimir-economico-simple
  ?u <- (menu-simple (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (bebida ?vi) (precio ?pr))
  ?v <- (precios-menus (bajo ?e) (medio ?m) (alto ?c))
  (test (eq ?e ?pr))
  (not (economico))
  =>
    (printout t "Primer plato: " (send ?p1 get-Nombre)  crlf)
    (printout t "Segundo plato: " (send ?p2 get-Nombre) crlf)
    (printout t "Postre: " (send ?p3 get-Nombre)        crlf)
    (printout t "Bebida: " (send ?vi get-Nombre)        crlf)
    (printout t "Precio Total: " ?pr                    crlf crlf)

    (assert (economico))
)

(defrule imprimir-resultados::imprimir-mediano-simple
  ?u <- (menu-simple (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (bebida ?vi) (precio ?pr))
  ?v <- (precios-menus (bajo ?e) (medio ?m) (alto ?c))
  (test (eq ?m ?pr))
  (not (mediano))
  =>
    (printout t "Primer plato: " (send ?p1 get-Nombre)  crlf)
    (printout t "Segundo plato: " (send ?p2 get-Nombre) crlf)
    (printout t "Postre: " (send ?p3 get-Nombre)        crlf)
    (printout t "Bebida: " (send ?vi get-Nombre)        crlf)
    (printout t "Precio Total: " ?pr                    crlf crlf)

    (assert (mediano))
)
(defrule imprimir-resultados::imprimir-caro-simple
  ?u <- (menu-simple (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (bebida ?vi) (precio ?pr))
  ?v <- (precios-menus (bajo ?e) (medio ?m) (alto ?c))
  (test (eq ?c ?pr))
  (not (caro))
  =>
    (printout t "Primer plato: " (send ?p1 get-Nombre)  crlf)
    (printout t "Segundo plato: " (send ?p2 get-Nombre) crlf)
    (printout t "Postre: " (send ?p3 get-Nombre)        crlf)
    (printout t "Bebida: " (send ?vi get-Nombre)        crlf)
    (printout t "Precio Total: " ?pr                    crlf crlf)
    (assert (caro))
)

(defrule imprimir-resultados::imprimir-economico-completo
  ?u <- (menu-completo (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (primeraBebida ?v1) (segundaBebida ?v2) (bebidaPostre ?v3)(precio ?pr))
  ?v <- (precios-menus (bajo ?e) (medio ?m) (alto ?c))
  (test (eq ?e ?pr))
  (not (economico))
  =>
    (printout t "Primer plato: " (send ?p1 get-Nombre)    crlf)
    (printout t "Segundo plato: " (send ?p2 get-Nombre)  crlf)
    (printout t "Postre: " (send ?p3 get-Nombre)               crlf)
    (printout t "Bebida 1: " (send ?v1 get-Nombre)        crlf)
    (printout t "Bebida 2: " (send ?v2 get-Nombre)        crlf)
    (printout t "Bebida 3: " (send ?v3 get-Nombre)         crlf)
    (printout t "Precio Total: " ?pr                    crlf crlf)
    (assert (economico))
)

(defrule imprimir-resultados::imprimir-mediano-completo
  ?u <- (menu-completo (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (primeraBebida ?v1) (segundaBebida ?v2) (bebidaPostre ?v3)(precio ?pr))
  ?v <- (precios-menus (bajo ?e) (medio ?m) (alto ?c))
  (test (eq ?m ?pr))
  (not (mediano))
  =>
    (printout t "Primer plato: " (send ?p1 get-Nombre)    crlf)
    (printout t "Segundo plato: " (send ?p2 get-Nombre)  crlf)
    (printout t "Postre: " (send ?p3 get-Nombre)               crlf)
    (printout t "Bebida 1: " (send ?v1 get-Nombre)        crlf)
    (printout t "Bebida 2: " (send ?v2 get-Nombre)        crlf)
    (printout t "Bebida 3: " (send ?v3 get-Nombre)         crlf)
    (printout t "Precio Total: " ?pr                    crlf crlf)
    (assert (mediano))
)
(defrule imprimir-resultados::imprimir-caro-completo
  ?u <- (menu-completo (primerPlato ?p1) (segundoPlato ?p2) (postre ?p3) (primeraBebida ?v1) (segundaBebida ?v2) (bebidaPostre ?v3)(precio ?pr))
  ?v <- (precios-menus (bajo ?e) (medio ?m) (alto ?c))
  (test (eq ?c ?pr))
  (not (caro))
  =>
    (printout t "Primer plato: " (send ?p1 get-Nombre)    crlf)
    (printout t "Segundo plato: " (send ?p2 get-Nombre)  crlf)
    (printout t "Postre: " (send ?p3 get-Nombre)               crlf)
    (printout t "Bebida 1: " (send ?v1 get-Nombre)        crlf)
    (printout t "Bebida 2: " (send ?v2 get-Nombre)        crlf)
    (printout t "Bebida 3: " (send ?v3 get-Nombre)         crlf)
    (printout t "Precio Total: " ?pr                    crlf crlf)
    (assert (caro))
)

(defrule imprimir-resultados::imprimir-no-menu
  (and (not (menu-completo)) (not (menu-simple)))
    =>
    (printout t "No se han podido generar menús con esas preferencias." crlf)
)
