(define (domain extension2)

  (:requirements :adl :typing :equality)

  (:types
  plato dia tipo - object
  )

  (:predicates

    ;;predicados de plato:
    (incompatible ?plato1 - plato ?plato2 - plato)  ;;el plato 1 es incompatible con el plato 2
    (tipoPlato ?plato1 - plato ?tipo1 - tipo) ;; tipo del plato1
    (primerPlato ?p - plato)  ;; p es primer plato
    (platoAsignado ?p - plato)  ;; plato asignado

    ;;predicados de dia:
    (diaAsignado ?d - dia)    ;; dia asignado
    (diaPrevio ?dia1 ?dia2 - dia) ;; dia1 es dia previo de dia2
    (primerDia ?d - dia)  ;; indica si es lunes

    ;;predicados de menu:
    (menuDia ?primero ?segundo - plato ?d - dia)  ;; menu asignado a un dia
  )

  ;; asigna el primer dia (lunes), que no tiene dia previo
  (:action asignaPrimerDia
    ;; parametros: primer plato, segundo plato y dia de la semana
    :parameters (?primero - plato ?segundo - plato ?d - dia)

    ;; precondiciones: los platos NO son incompatibles (y son diferentes) y tanto los platos como los dias no han sido usados
    :precondition (and
      (primerDia ?d)
      (not (= ?primero ?segundo))
      (not (incompatible ?primero ?segundo))
      (not (incompatible ?segundo ?primero))
      (not (platoAsignado ?primero))
      (not (platoAsignado ?segundo))
      (not (diaAsignado ?d))
      (primerPlato ?primero)
      ;(not (primerPlato ?segundo))
    )
    ;; effecto: se dejan los platos y el dia actual como asignados y se forma el menu
    :effect (and
      (platoAsignado ?primero)
      (platoAsignado ?segundo)
      (diaAsignado ?d)
      (menuDia ?primero ?segundo ?d)
    )
  )

  ;; asigna el resto de dias (que si tienen previo)
  (:action asignaRestoDias
    ;; parametros: primer plato, segundo plato y dia de la semana, tipo de estos platos Y primer plato, segundo plato, dia previo y tipo de estos platos
    :parameters (?primero ?segundo - plato ?dAct - dia ?tipo1 ?tipo2 - tipo
      ?primeroPrevio ?segundoPrevio - plato ?dPrev - dia ?tipo3 ?tipo4 - tipo)

    ;; precondiciones:
    :precondition (and
      ;(especialesAsignados)
      (not (= ?primero ?segundo)) ;; no son el mismo plato
      (not (platoAsignado ?primero))  ;; no estan ya asignados
      (not (platoAsignado ?segundo))
      (not (diaAsignado ?dAct)) ;;el dia no esta ya asignado
      
      (primerPlato ?primero)  ;;primero es primero
      ;(not (primerPlato ?segundo)) ;;segundo no es primer plato
      (not (incompatible ?primero ?segundo))  ;;no son incompatibles: no hace
      (not (incompatible ?segundo ?primero))  ;;falta indicar los dos sentidos
      
      (diaPrevio ?dPrev ?dAct)  ;;dPrev es el dia previo de dAct
      (menuDia ?primeroPrevio ?segundoPrevio ?dPrev)  ;;hay un menu asignado al dia previo (construccion de la respuesta: lunes -> viernes)

      (tipoPlato ?primero ?tipo1) ;;tipo1 = tipo del primer plato actual
      (tipoPlato ?segundo ?tipo2) ;;tipo2 = tipo del segundo plato actual
      (tipoPlato ?primeroPrevio ?tipo3) ;;tipo3 = tipo del primer plato previo
      (tipoPlato ?segundoPrevio ?tipo4) ;;tipo4 = tipo del primer plato previo
      (not (= ?tipo1 ?tipo3)) ;;los tipos de los primeros platos no coinciden
      (not (= ?tipo2 ?tipo4)) ;;los tipos de los segundos platos no coinciden

    )

    ;; effecto: se dejan los platos y el dia actual como asignados y se forma el menu
    :effect (and
      (platoAsignado ?primero)
      (platoAsignado ?segundo)
      (diaAsignado ?dAct)
      (menuDia ?primero ?segundo ?dAct)
    )
  )
)