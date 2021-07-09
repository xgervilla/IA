(define (domain extension1)

  (:requirements :adl :typing :equality)

  (:types
    plato dia tipo - object
  )

  (:predicates
    ;;predicados de plato:
    (incompatible ?plato1 ?plato2 - plato)  ;;el plato 1 es incompatible con el plato 2
    (primerPlato ?plato1 - plato)  ;; p es primer plato
    (platoAsignado ?plato1 - plato)  ;; plato asignado

    ;;predicados de dia:
    (diaAsignado ?dia1 - dia)    ;; dia asignado

    ;;predicados de menu:
    (menuDia ?primero ?segundo - plato ?dia1 - dia)  ;; menu asignado a un dia
  )
  ;; asigna el primer dia (lunes), que no tiene dia previo
  (:action asignaDia
    ;; parametros: primer plato, segundo plato y dia de la semana
    :parameters (?primero - plato ?segundo - plato ?d - dia)

    ;; precondiciones: los platos NO son incompatibles (y son diferentes) y tanto los platos como los dias no han sido usados
    :precondition (and
      (not (= ?primero ?segundo))
      (not (incompatible ?primero ?segundo))
      (not (incompatible ?segundo ?primero))
      (not (platoAsignado ?primero))
      (not (platoAsignado ?segundo))
      (not (diaAsignado ?d))
      (primerPlato ?primero)
      
    )
    ;; effecto: se dejan los platos y el dia actual como asignados y se forma el menu
    :effect (and
      (platoAsignado ?primero)
      (platoAsignado ?segundo)
      (diaAsignado ?d)
      (menuDia ?primero ?segundo ?d)
    )
  )
)
