(define (problem problema2-1)
  
  (:domain extension2)

  (:objects
    ;;objetos "basicos":
    ;; conjunto de platos
    ensalada_cesar gazpacho macarrones cuscus paella entrecot canelones lubina_al_horno merluza_en_salsa hamburguesa_vegetariana - plato
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
    (incompatible entrecot hamburguesa_vegetariana)
    (incompatible canelones lubina_al_horno)
    (incompatible canelones merluza_en_salsa)
    (incompatible canelones hamburguesa_vegetariana)
    (incompatible lubina_al_horno merluza_en_salsa)
    (incompatible lubina_al_horno hamburguesa_vegetariana)
    (incompatible merluza_en_salsa hamburguesa_vegetariana)

    ;;primero-segundo:
    (incompatible paella hamburguesa_vegetariana)
    (incompatible paella canelones)

    ;;consecutividad de los dias
    (diaprevio lunes martes)
    (diaprevio martes miercoles)
    (diaprevio miercoles jueves)
    (diaprevio jueves viernes)

    ;;tipo de platos
    (tipoPlato ensalada_cesar ensalada)
    (tipoPlato gazpacho sopa)
    (tipoPlato macarrones pasta)
    (tipoPlato cuscus cereal)
    (tipoPlato paella cereal)
    (tipoPlato entrecot carne)
    (tipoPlato canelones carne)
    (tipoPlato lubina_al_horno pescado)
    (tipoPlato merluza_en_salsa pescado)
    (tipoPlato hamburguesa_vegetariana vegetal)

    ;; "comodin" para indicar el primer dia de la semana: el lunes
    (primerDia lunes)
  )

  ;;objetivo: que todos los dias esten asignados
  (:goal
    (forall (?d - dia) (diaAsignado ?d))
  )
 )