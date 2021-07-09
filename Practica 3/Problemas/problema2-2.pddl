(define (problem problema2-2)
  
  (:domain extension2)

  (:objects
    ;;objetos "basicos":
    ;; conjunto de platos
    ensalada_cesar gazpacho macarrones cuscus paella pimientos_rellenos canelones parillada_de_verduras merluza_en_salsa hamburguesa_vegetariana - plato
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
    (incompatible pimientos_rellenos canelones)
    (incompatible pimientos_rellenos parillada_de_verduras)
    (incompatible pimientos_rellenos merluza_en_salsa)
    (incompatible pimientos_rellenos hamburguesa_vegetariana)
    (incompatible canelones parillada_de_verduras)
    (incompatible canelones merluza_en_salsa)
    (incompatible canelones hamburguesa_vegetariana)
    (incompatible parillada_de_verduras merluza_en_salsa)
    (incompatible parillada_de_verduras hamburguesa_vegetariana)
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
    (tipoPlato pimientos_rellenos vegetal)
    (tipoPlato canelones carne)
    (tipoPlato parillada_de_verduras vegetal)
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