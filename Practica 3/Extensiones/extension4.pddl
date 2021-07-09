(define (domain extension4)

  (:requirements :adl :typing :equality)

  (:types
    plato dia tipo - object
  )

  (:functions
    (calorias ?plato1 - plato) ;; calorias del plato1
    (caloriasDia ?dia1 - dia)  ;;numero de calorias de ese dia
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
    (platoDiaEspecial ?plato1 - plato ?d - dia) ;; el plato se debe servir en un dia especial
    (tipoPrimeroPrev ?tipo1 - tipo ?d - dia)
    (tipoSegundoPrev ?tipo1 - tipo ?d - dia)

    (especialesPorAsignar)
    (checkEspeciales)
  )

  (:action compruebaEspeciales
    :parameters ()
    :precondition (checkEspeciales)
    :effect 
      (when
        (forall (?p1 - plato ?d1 - dia)
          (and
            (platoDiaEspecial ?p1 ?d1)
            (platoAsignado ?p1)
            (diaAsignado ?d1)
          )
        )
        (and
          (not (especialesPorAsignar))
          (not (checkEspeciales))
        )
      )
  )
   

  ;; asigna los platos que deben estar en un dia especifico
  (:action asignaEspeciales
    ;; parametros: plato especial, plato para completar el menu y dia de la semana
    :parameters (?platoEsp ?plato2 - plato ?dAct ?dPrev - dia ?tipoEsp ?tipo2 - tipo)

    ;; precondiciones: que el plato especial sea especial de ese dia, no esten ya asignado y no sean incompatibles
    :precondition (and
      (especialesPorAsignar)

      (not (= ?platoEsp ?plato2)) ;;no son el mismo plato
      (platoDiaEspecial ?platoEsp ?dAct) ;;platoEsp es especial en dAct
      
      (not (platoAsignado ?platoEsp)) ;;platoEsp no esta asignado
      (not (platoAsignado ?plato2))   ;;plato2 no esta asignado
      (not (diaAsignado ?dAct))

      (not (incompatible ?platoEsp ?plato2))  ;;no son incompatibles
      (not (incompatible ?plato2 ?platoEsp))

      (diaPrevio ?dPrev ?dAct)  ;;dPrev es el dia previo de dAct

      (tipoPlato ?platoEsp ?tipoEsp)  ;;platoEsp es del tipo tipoEsp
      (tipoPlato ?plato2 ?tipo2)      ;;plato2 es del tipo tipo2

      ;;no existe un plato especial que se asigne a ese dia y sea diferente de platoEsp o plato2
      (not (exists (?plato - plato)
        (and
          (platoDiaEspecial ?plato ?dAct)
          (not (or (= ?plato ?plato2) (= ?plato ?platoEsp)) )
        )
      ))

      (<= (+ (calorias ?plato2) (calorias ?platoEsp)) 1500)
      (>= (+ (calorias ?plato2) (calorias ?platoEsp)) 1000)
    )
    ;; effecto: dejamos los platos como asignados y creamos el menu del dia. Para el menu sepramos en si el plato especial es primero o segundo
    :effect (and
      ;;si es primero y el tipo de plato2 no se ha usado en el dia previo, lo ponemos como primer plato del menu
      (when
        (and
          (primerPlato ?platoEsp)
          (not (tipoSegundoPrev ?tipo2 ?dPrev))
        )
        (and
          (platoAsignado ?platoEsp)
          (platoAsignado ?plato2)
          (diaAsignado ?dAct)
          (menuDia ?platoEsp ?plato2 ?dAct)
          (tipoPrimeroPrev ?tipoEsp ?dAct)
          (tipoSegundoPrev ?tipo2 ?dAct)
          (increase (caloriasDia ?dAct) (+ (calorias ?plato2) (calorias ?platoEsp)))
        )
      )
      ;;si es segundo y el tipo de plato2 no se ha usado en el dia previo, lo ponemos como segundo plato del menu
      (when
        (and
          (not (primerPlato ?platoEsp))
          (not (tipoPrimeroPrev ?tipo2 ?dPrev))
        )
        (and
          (platoAsignado ?platoEsp)
          (platoAsignado ?plato2)
          (diaAsignado ?dAct)
          (menuDia ?plato2 ?platoEsp ?dAct)
          (tipoPrimeroPrev ?tipo2 ?dAct)
          (tipoSegundoPrev ?tipoEsp ?dAct)
          (increase (caloriasDia ?dAct) (+ (calorias ?plato2) (calorias ?platoEsp)))
        )
      )
    )
  )

  ;; asigna el primer dia (lunes), que no tiene dia previo
  (:action asignaPrimerDia
    ;; parametros: primer plato, segundo plato y dia de la semana
    :parameters (?primero - plato ?segundo - plato ?d - dia ?tipo1 ?tipo2 - tipo)

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
      (<= (+ (calorias ?primero) (calorias ?segundo)) 1500)
      (>= (+ (calorias ?primero) (calorias ?segundo)) 1000)

      (tipoPlato ?primero ?tipo1) ;;tipo1 = tipo del primer plato actual
      (tipoPlato ?segundo ?tipo2) ;;tipo2 = tipo del segundo plato actual
    )
    ;; effecto: se dejan los platos y el dia actual como asignados y se forma el menu
    :effect (and
      (platoAsignado ?primero)
      (platoAsignado ?segundo)
      (diaAsignado ?d)
      (menuDia ?primero ?segundo ?d)

      (tipoPrimeroPrev ?tipo1 ?d)
      (tipoSegundoPrev ?tipo2 ?d)
      (increase (caloriasDia ?d) (+ (calorias ?primero) (calorias ?segundo)))
    )
  )

  ;; asigna el resto de dias (que si tienen previo)
  (:action asignaRestoDias
    ;; parametros: primer plato, segundo plato y dia de la semana, tipo de estos platos Y primer plato, segundo plato, dia previo y tipo de estos platos
    :parameters (?primero ?segundo - plato ?dAct ?dPrev - dia ?tipo1 ?tipo2 - tipo)

    ;; precondiciones:
    :precondition (and
      (not (exists
        (?platoEsp - plato ?dEsp - dia)
        (and
          (platoDiaEspecial ?platoEsp ?dEsp)
          (not (platoAsignado ?platoEsp))
        )
      ))
      ;(not (checkEspeciales))
      (not (= ?primero ?segundo)) ;; no son el mismo plato
      (not (platoAsignado ?primero))  ;; no estan ya asignados
      (not (platoAsignado ?segundo))
      (not (diaAsignado ?dAct)) ;;el dia no esta ya asignado
      
      (primerPlato ?primero)  ;;primero es primero
      (not (primerPlato ?segundo)) ;;segundo no es primer plato
      (not (incompatible ?primero ?segundo))  ;;no son incompatibles: no hace
      (not (incompatible ?segundo ?primero))  ;;falta indicar los dos sentidos
      
      (diaPrevio ?dPrev ?dAct)  ;;dPrev es el dia previo de dAct

      (tipoPlato ?primero ?tipo1) ;;tipo1 = tipo del primer plato actual
      (tipoPlato ?segundo ?tipo2) ;;tipo2 = tipo del segundo plato actual
      (not (tipoPrimeroPrev ?tipo1 ?dPrev)) ;;los tipos de los primeros platos no coinciden
      (not (tipoSegundoPrev ?tipo2 ?dPrev)) ;;los tipos de los segundos platos no coinciden

      (<= (+ (calorias ?primero) (calorias ?segundo)) 1500)
      (>= (+ (calorias ?primero) (calorias ?segundo)) 1000)

    )

    ;; effecto: se dejan los platos y el dia actual como asignados y se forma el menu
    :effect (and
      (platoAsignado ?primero)
      (platoAsignado ?segundo)
      (diaAsignado ?dAct)
      (menuDia ?primero ?segundo ?dAct)

      (tipoPrimeroPrev ?tipo1 ?dAct)
      (tipoSegundoPrev ?tipo2 ?dAct)
      (increase (caloriasDia ?dAct) (+ (calorias ?primero) (calorias ?segundo)))
    )
  )

)