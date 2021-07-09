(define (problem problema1-2)
  
  (:domain extension1)

  (:objects
    ;;objetos "basicos":
    ;; conjunto de platos
    ensalada_cesar gazpacho macarrones cuscus paella entrecot canelones lubina_al_horno merluza_en_salsa - plato
    ;; dias
    lunes martes miercoles jueves viernes - dia

    ;; tipo de platos
    sopa pasta ensalada cereal carne pescado vegetal - tipo
  )

  (:init
    ;;primeros:
    (primerPlato ensalada_cesar)
    (primerPlato macarrones)
    (primerPlato cuscus)
    (primerPlato gazpacho)
    (primerPlato paella)

    ;;lista de incompatibilidades:
    (incompatible ensalada_cesar gazpacho)
    (incompatible ensalada_cesar macarrones)
    (incompatible ensalada_cesar cuscus)
    (incompatible ensalada_cesar paella)
    (incompatible macarrones gazpacho)
    (incompatible macarrones cuscus)
    (incompatible macarrones paella)
    (incompatible gazpacho cuscus)
    (incompatible gazpacho paella)
    (incompatible paella cuscus)
  
    ;;segundos:
    (incompatible entrecot canelones)
    (incompatible entrecot lubina_al_horno)
    (incompatible entrecot merluza_en_salsa)
    (incompatible canelones lubina_al_horno)
    (incompatible canelones merluza_en_salsa)
    (incompatible lubina_al_horno merluza_en_salsa)

    ;;primero-segundo:
    (incompatible paella canelones)

  )

  ;;objetivo: que todos los dias esten asignados
  (:goal
    (forall (?d - dia) (diaAsignado ?d))
  )
 )