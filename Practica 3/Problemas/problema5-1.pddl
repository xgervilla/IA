(define (problem problema5-1)

  (:domain extension5)

  (:objects
    ;;objetos "basicos":
    ;; conjunto de platos
    ensalada_cesar gazpacho macarrones cuscus paella entrecot canelones lubina_al_horno merluza_en_salsa hamburguesa_vegetariana - plato
    ;; dias
    lunes martes miercoles jueves viernes - dia

    ;; tipo de platos
    sopa pasta ensalada cereal carne pescado vegetal - tipo


    amanida_cabra escudella magret pichon - plato
  )

  (:init
    ;;primeros:
    (primerPlato ensalada_cesar)
    (primerPlato macarrones)
    (primerPlato cuscus)
    (primerPlato gazpacho)
    (primerPlato paella)
    (primerPlato amanida_cabra)
    (primerPlato escudella)

    ;;lista de incompatibilidades:
    ;;primeros:
    (incompatible ensalada_cesar gazpacho)
    (incompatible ensalada_cesar macarrones)
    (incompatible ensalada_cesar cuscus)
    (incompatible ensalada_cesar paella)
    (incompatible ensalada_cesar amanida_cabra)
    (incompatible ensalada_cesar escudella)

    (incompatible macarrones gazpacho)
    (incompatible macarrones cuscus)
    (incompatible macarrones paella)
    (incompatible macarrones amanida_cabra)
    (incompatible macarrones escudella)

    (incompatible gazpacho cuscus)
    (incompatible gazpacho paella)
    (incompatible gazpacho amanida_cabra)
    (incompatible gazpacho escudella)

    (incompatible escudella amanida_cabra)

    (incompatible paella cuscus)

    ;;segundos:
    (incompatible entrecot canelones)
    (incompatible entrecot lubina_al_horno)
    (incompatible entrecot merluza_en_salsa)
    (incompatible entrecot hamburguesa_vegetariana)
    (incompatible entrecot magret)
    (incompatible entrecot pichon)


    (incompatible canelones lubina_al_horno)
    (incompatible canelones merluza_en_salsa)
    (incompatible canelones hamburguesa_vegetariana)
    (incompatible entrecot pichon)

    (incompatible lubina_al_horno merluza_en_salsa)
    (incompatible lubina_al_horno hamburguesa_vegetariana)
    (incompatible lubina_al_horno magret)

    (incompatible merluza_en_salsa hamburguesa_vegetariana)
    (incompatible magret hamburguesa_vegetariana)

    (incompatible pichon magret)

    ;;primero-segundo:
    (incompatible paella hamburguesa_vegetariana)
    (incompatible paella canelones)
    (incompatible macarrones canelones)

    ;;consecutividad de los dias
    (diaprevio lunes lunes)
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

    ;;platos que deben ir un dia en particular
    (platoDiaEspecial paella jueves)
    (platoDiaEspecial entrecot viernes)

    ;;estado inicial de los especiales asignados
    (especialesPorAsignar)

    ;;precio de cada plato
    (= (precio ensalada_cesar) 4)
    (= (precio gazpacho) 5)
    (= (precio macarrones) 4)
    (= (precio cuscus) 4)
    (= (precio paella) 8)
    (= (precio entrecot) 10)
    (= (precio canelones) 6)
    (= (precio lubina_al_horno) 7)
    (= (precio merluza_en_salsa) 6)
    (= (precio hamburguesa_vegetariana) 5)

    ;;calorias de cada plato
    (= (calorias ensalada_cesar) 500)
    (= (calorias gazpacho) 120)
    (= (calorias macarrones) 300)
    (= (calorias cuscus) 250)
    (= (calorias paella) 400)
    (= (calorias entrecot) 600)
    (= (calorias canelones) 550)
    (= (calorias lubina_al_horno) 150)
    (= (calorias merluza_en_salsa) 120)
    (= (calorias hamburguesa_vegetariana) 200)

    ;;calorias iniciales de cada dia: 0
    (= (caloriasDia lunes) 0)
    (= (caloriasDia martes) 0)
    (= (caloriasDia miercoles) 0)
    (= (caloriasDia jueves) 0)
    (= (caloriasDia viernes) 0)

    ;;precio inicial de cada dia: 0
    (= (precioDia lunes) 0)
    (= (precioDia martes) 0)
    (= (precioDia miercoles) 0)
    (= (precioDia jueves) 0)
    (= (precioDia viernes) 0)


    (tipoPlato amanida_cabra ensalada)
    (tipoPlato escudella sopa)
    (tipoPlato magret carne)
    (tipoPlato pichon carne)

    (= (precio amanida_cabra) 6)
    (= (precio escudella) 6)
    (= (precio magret) 6)
    (= (precio pichon) 6)

    (= (calorias amanida_cabra) 600)
    (= (calorias escudella) 700)
    (= (calorias magret) 800)
    (= (calorias pichon) 1000)


  )

  ;;objetivo: que todos los dias esten asignados
  (:goal (forall (?d - dia) (diaAsignado ?d)) )

  (:metric minimize
      (+ (precioDia lunes) (+ (precioDia martes) (+ (precioDia miercoles) (+ (precioDia jueves) (precioDia viernes)) ) ) )
    )
 )
