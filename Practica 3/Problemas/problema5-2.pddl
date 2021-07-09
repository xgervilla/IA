(define (problem problema5-2)
  
  (:domain extension5)

  (:objects
    ;;objetos "basicos":
    ;; conjunto de platos
    crema_de_elote ejotes_con_jitomate frijoles_rancheros macarrones_con_leche pay_vegetariano nopales_con_xoxoyotes sopa_azteca - plato ;;primeros
    chiles_rellenos alambre_vegetariano ceviche chilaquiles_con_pollo pozole_rojo enchiladas_de_pescado tamales_de_pollo tacos - plato ;;segundos
    ;; dias
    lunes martes miercoles jueves viernes - dia

    ;; tipo de platos
    caldo sopa pasta guiso carne pescado vegetal - tipo
  )

  (:init
    ;;primeros:
    (primerPlato crema_de_elote)
    (primerPlato frijoles_rancheros)
    (primerPlato macarrones_con_leche)
    (primerPlato ejotes_con_jitomate)
    (primerPlato pay_vegetariano)
    (primerPlato nopales_con_xoxoyotes)
    (primerPlato sopa_azteca)


    ;;lista de incompatibilidades:
    ;;primeros:
    (incompatible crema_de_elote ejotes_con_jitomate)
    (incompatible crema_de_elote frijoles_rancheros)
    (incompatible crema_de_elote macarrones_con_leche)
    (incompatible crema_de_elote pay_vegetariano)
    (incompatible crema_de_elote nopales_con_xoxoyotes)
    (incompatible crema_de_elote sopa_azteca)
    (incompatible frijoles_rancheros ejotes_con_jitomate)
    (incompatible frijoles_rancheros macarrones_con_leche)
    (incompatible frijoles_rancheros pay_vegetariano)
    (incompatible frijoles_rancheros nopales_con_xoxoyotes)
    (incompatible frijoles_rancheros sopa_azteca)
    (incompatible ejotes_con_jitomate macarrones_con_leche)
    (incompatible ejotes_con_jitomate pay_vegetariano)
    (incompatible ejotes_con_jitomate nopales_con_xoxoyotes)
    (incompatible ejotes_con_jitomate sopa_azteca)
    (incompatible pay_vegetariano macarrones_con_leche)
    (incompatible pay_vegetariano nopales_con_xoxoyotes)
    (incompatible pay_vegetariano sopa_azteca)
    (incompatible macarrones_con_leche nopales_con_xoxoyotes)
    (incompatible macarrones_con_leche sopa_azteca)
    (incompatible sopa_azteca nopales_con_xoxoyotes)
  
    ;;segundos:
    (incompatible chiles_rellenos alambre_vegetariano)
    (incompatible chiles_rellenos ceviche)
    (incompatible chiles_rellenos chilaquiles_con_pollo)
    (incompatible chiles_rellenos pozole_rojo)
    (incompatible chiles_rellenos enchiladas_de_pescado)
    (incompatible chiles_rellenos tamales_de_pollo)
    (incompatible chiles_rellenos tacos)
    (incompatible alambre_vegetariano ceviche)
    (incompatible alambre_vegetariano chilaquiles_con_pollo)
    (incompatible alambre_vegetariano pozole_rojo)
    (incompatible alambre_vegetariano enchiladas_de_pescado)
    (incompatible alambre_vegetariano tamales_de_pollo)
    (incompatible alambre_vegetariano tacos)
    (incompatible ceviche chilaquiles_con_pollo)
    (incompatible ceviche pozole_rojo)
    (incompatible ceviche enchiladas_de_pescado)
    (incompatible ceviche tamales_de_pollo)
    (incompatible ceviche tacos)
    (incompatible chilaquiles_con_pollo pozole_rojo)
    (incompatible chilaquiles_con_pollo enchiladas_de_pescado)
    (incompatible chilaquiles_con_pollo tamales_de_pollo)
    (incompatible chilaquiles_con_pollo tacos)
    (incompatible pozole_rojo enchiladas_de_pescado)
    (incompatible pozole_rojo tamales_de_pollo)
    (incompatible pozole_rojo tacos)
    (incompatible enchiladas_de_pescado tamales_de_pollo)
    (incompatible enchiladas_de_pescado tacos)
    (incompatible tamales_de_pollo tacos) 

    ;;primero-segundo:

    ;;consecutividad de los dias
    (diaprevio lunes lunes)
    (diaprevio lunes martes)
    (diaprevio martes miercoles)
    (diaprevio miercoles jueves)
    (diaprevio jueves viernes)

    ;; "comodin" para indicar el primer dia de la semana: el lunes
    (primerDia lunes)

    ;;tipo de platos
    (tipoPlato crema_de_elote caldo)
    (tipoPlato ejotes_con_jitomate vegetal)
    (tipoPlato frijoles_rancheros vegetal)
    (tipoPlato macarrones_con_leche pasta)
    (tipoPlato pay_vegetariano guiso)
    (tipoPlato nopales_con_xoxoyotes vegetal)
    (tipoPlato sopa_azteca sopa)
    (tipoPlato chiles_rellenos carne)
    (tipoPlato alambre_vegetariano vegetal)
    (tipoPlato ceviche carne)
    (tipoPlato chilaquiles_con_pollo carne)
    (tipoPlato pozole_rojo caldo)
    (tipoPlato enchiladas_de_pescado pescado)
    (tipoPlato tamales_de_pollo carne)
    (tipoPlato tacos carne)


    ;;platos que deben ir un dia en particular
    (platoDiaEspecial tacos martes)

    ;;estado inicial de los especiales asignados
    (especialesPorAsignar)

    ;;precio de cada plato
    (= (precio crema_de_elote) 4)
    (= (precio ejotes_con_jitomate) 5)
    (= (precio frijoles_rancheros) 4)
    (= (precio macarrones_con_leche) 4)
    (= (precio pay_vegetariano) 8)
    (= (precio nopales_con_xoxoyotes) 10)
    (= (precio sopa_azteca) 6)
    (= (precio chiles_rellenos) 7)
    (= (precio alambre_vegetariano) 6)
    (= (precio ceviche) 5)
    (= (precio chilaquiles_con_pollo) 8)
    (= (precio pozole_rojo) 4)
    (= (precio enchiladas_de_pescado) 5)
    (= (precio tamales_de_pollo) 6)
    (= (precio tacos) 7)

    ;;calorias de cada plato
    (= (calorias crema_de_elote) 450)
    (= (calorias ejotes_con_jitomate) 500)
    (= (calorias frijoles_rancheros) 600)
    (= (calorias macarrones_con_leche) 500)
    (= (calorias pay_vegetariano) 400)
    (= (calorias nopales_con_xoxoyotes) 600)
    (= (calorias sopa_azteca) 500)
    (= (calorias chiles_rellenos) 700)
    (= (calorias alambre_vegetariano) 400)
    (= (calorias ceviche) 600)
    (= (calorias chilaquiles_con_pollo) 700)
    (= (calorias pozole_rojo) 550)
    (= (calorias enchiladas_de_pescado) 480)
    (= (calorias tamales_de_pollo) 600)
    (= (calorias tacos) 650)

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
  )

  ;;objetivo: que todos los dias esten asignados
  (:goal (forall (?d - dia) (diaAsignado ?d)) )

  (:metric minimize
      (+ (precioDia lunes) (+ (precioDia martes) (+ (precioDia miercoles) (+ (precioDia jueves) (precioDia viernes)) ) ) )
    )
 )