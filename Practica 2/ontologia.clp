(defclass Comida "Clase comida general"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Region de la comida (lugar donde se encuentra)
    (single-slot region_comida
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Precio por unidad
    (single-slot Precio
        (type FLOAT)
        (create-accessor read-write))
    ;;; Nombre del objeto
    (single-slot Nombre
        (type STRING)
        (create-accessor read-write))
    ;;; Estaciones en las que esta la comida
    (single-slot estacion_comida
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Bebida "Bebida"
    (is-a Comida)
    (role concrete)
    (pattern-match reactive)
    ;;; Indica si una bebida es vino
    (single-slot Vino
        (type SYMBOL)
        (create-accessor read-write))
    ;;; precio por la copa
    (single-slot Precio_copa
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Plato "Plato"
    (is-a Comida)
    (role concrete)
    (pattern-match reactive)
    ;;; Orden en el que se sirve durante la comida (primer plato, segundo plato o postre)
    (multislot OrdenPlato
        (type STRING)
        (create-accessor read-write))
    ;;; El plato contiene el ingrediente
    (multislot contieneIngrediente
        (type INSTANCE)
        (create-accessor read-write))
    (multislot tipo_comida
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Estilo del plato
    (multislot estilo_plato
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Indica si un plato es vegetariano (true)
    (single-slot Vegetariano
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Complejidad para preparar un plato (1 facil - a partir de 100, 2 medio - hasta 100, 3 dificil-hasta 30 comensales)
    (single-slot Complejidad
        (type INTEGER)
        (create-accessor read-write))
    (multislot compatibilidadConBebida
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Temperatura a la que se sirve (frio, templado o caliente)
    (single-slot Temperatura
        (type STRING)
        (create-accessor read-write))
)

(defclass Ingrediente "Ingredientes que forman los platos"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Nombre del objeto
    (single-slot Nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Estilo "Estilo del plato (clasico, moderno, sibarita, regional (region)..)"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Nombre del objeto
    (single-slot Nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Preferencias "Preferencias del usuario"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot ingrediente_prohibido
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Estilo de preferencia del usuario
    (multislot estilo_preferencia
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Estacion "Estacion del año"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Nombre del objeto
    (single-slot Nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Reserva "Reserva que hace el usuario"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Numero de comensales de una reserva
    (single-slot Numero_de_comensales
        (type STRING)
        (create-accessor read-write))
    ;;; Precio maximo del menu por persona
    (single-slot precio_maximo
        (type FLOAT)
        (create-accessor read-write))
    (multislot temperatura
        (type SYMBOL)
        (create-accessor read-write))
    (multislot vinoPlato
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si un plato es vegetariano (true)
    (single-slot Vegetariano
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Indica si una bebida es vino
    (single-slot Vino
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Tipo de celebracion (familiar (boda, comunion..), congreso..) de una reserva
    (single-slot Tipo_de_celebracion
        (type STRING)
        (create-accessor read-write))
    ;;; Estacion preferencia del usuario
    (single-slot estacion_preferencia
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Precio minimo del menu por persona
    (single-slot precio_minimo
        (type FLOAT)
        (create-accessor read-write))
    ;;; Preferencias de una reserva
    (single-slot preferencia_reserva
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Region
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Nombre del objeto
    (single-slot Nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Tipo
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Nombre del objeto
    (single-slot Nombre
        (type STRING)
        (create-accessor read-write))
)

(definstances instances
    ([aceituna_verde] of Ingrediente
         (Nombre  "Aceituna verde")
    )

    ([entrecot_de_vaca] of Ingrediente
         (Nombre  "Entrecot de vaca")
    )

    ([gazpacho] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [vinagre] [pepino] [ajo] [sal] [aceite] [tomate] [pimiento_verde])
         (tipo_comida  [verdura])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "frio")
         (region_comida  [europa])
         (Precio  4)
         (Nombre  "Gazpacho")
         (estacion_comida  [siempre])
    )

    ([merlusa] of Ingrediente
         (Nombre  "merlusa")
    )

    ([surtido_de_croquetas] of Plato
         (OrdenPlato  "segundo" "primero")
         (contieneIngrediente  [perejil] [ajo] [cebolla] [leche] [huevo] [aceite] [mantequilla] [harina])
         (tipo_comida  [picoteo])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  2)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  5)
         (Nombre  "Surtido de croquetas")
         (estacion_comida  [siempre])
    )

    ([azafran] of Ingrediente
         (Nombre  "azafran")
    )

    ([hamburguesa_vegana] of Plato
         (OrdenPlato  "segundo" "primero")
         (contieneIngrediente  [pan] [cebolla] [lechuga] [tomate] [patata])
         (tipo_comida  [verdura])
         (estilo_plato  [moderno])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  10)
         (Nombre  "Hamburguesa vegana")
         (estacion_comida  [siempre])
    )

    ([patbingsu] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [yogur] [azucar])
         (tipo_comida  [pastel])
         (estilo_plato  [moderno])
         (Vegetariano  "true")
         (Complejidad  2)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [asia])
         (Precio  4)
         (Nombre  "Patbingsu")
         (estacion_comida  [siempre])
    )

    ([caldo_pescado] of Ingrediente
         (Nombre  "Caldo pescado")
    )

    ([carbonara] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [pasta] [huevo] [bacon] [sal] [parmesano] [pimienta])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [europa])
         (Precio  6.0)
         (Nombre  "Carbonara")
         (estacion_comida  [siempre])
    )

    ([arroz] of Tipo
         (Nombre  "arroz")
    )

    ([levadura] of Ingrediente
         (Nombre  "Levadura")
    )

    ([verano] of Estacion
         (Nombre  "Verano")
    )

    ([invierno] of Estacion
         (Nombre  "Invierno")
    )

    ([pasta] of Tipo
         (Nombre  "Pasta")
    )

    ([pastel_chocolate] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [vainilla] [harina] [chocolate] [huevo] [mantequilla] [azucar])
         (tipo_comida  [pastel])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "templado")
         (region_comida  [mundo])
         (Precio  4)
         (Nombre  "Pastel chocolate")
         (estacion_comida  [siempre])
    )

    ([ensalada_verde] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [lechuga] [tomate] [aceituna_verde] [pimiento_rojo] [aceituna_negra] [cebolla])
         (tipo_comida  [ensalada])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado])
         (Temperatura  "templado")
         (region_comida  [mundo])
         (Precio  5)
         (Nombre  "Ensalada verde")
         (estacion_comida  [siempre])
    )

    ([huevo] of Ingrediente
         (Nombre  "Huevo")
    )

    ([amaretto] of Ingrediente
         (Nombre  "amaretto")
    )

    ([garrofo] of Ingrediente
         (Nombre  "Garrofo")
    )

    ([muslo_de_pollo] of Ingrediente
         (Nombre  "Muslo de pollo")
    )

    ([gamba] of Ingrediente
         (Nombre  "Gamba")
    )

    ([carne_picada] of Ingrediente
         (Nombre  "Carne Picada")
    )

    ([pan] of Ingrediente
         (Nombre  "Pan")
    )

    ([rape] of Ingrediente
         (Nombre  "Rape")
    )

    ([harina] of Ingrediente
         (Nombre  "Harina")
    )

    ([arroz_verde] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [tomate] [zanahorias] [arroz] [sal] [aceite])
         (tipo_comida  [arroz])
         (estilo_plato  [moderno] [sibarita])
         (Vegetariano  "true")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  14)
         (Nombre  "Arroz verde")
         (estacion_comida  [siempre])
    )

    ([canelones_vegetarianos] of Plato
         (OrdenPlato  "primero" "segundo")
         (contieneIngrediente  [aceite] [mantequilla] [harina] [queso] [placas_de_pasta] [espinacas] [bechamel] [sal] [cebolla] [leche])
         (tipo_comida  [pasta])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  10)
         (Nombre  "Canelones de espinacas")
         (estacion_comida  [siempre])
    )

    ([aceituna_negra] of Ingrediente
         (Nombre  "Aceituna negra")
    )

    ([mascarpone] of Ingrediente
         (Nombre  "Mascarpone")
    )

    ([filete_de_atun] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [atun])
         (tipo_comida  [pescado])
         (estilo_plato  [moderno] [sibarita])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [mundo])
         (Precio  20)
         (Nombre  "Filete de atun")
         (estacion_comida  [siempre])
    )

    ([helado] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [azucar] [leche])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [mundo])
         (Precio  4)
         (Nombre  "Helado")
         (estacion_comida  [siempre])
    )

    ([macedonia] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [fresa] [manzana] [naranja] [pera])
         (tipo_comida  [fruta])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [mundo])
         (Precio  5)
         (Nombre  "Macedonia")
         (estacion_comida  [verano])
    )

    ([bacalao] of Ingrediente
         (Nombre  "Bacalao")
    )

    ([europa] of Region
         (Nombre  "Europa")
    )

    ([sibarita] of Estilo
         (Nombre  "sibarita")
    )

    ([pastel] of Tipo
         (Nombre  "pastel")
    )

    ([pepino] of Ingrediente
         (Nombre  "Pepino")
    )

    ([patata] of Ingrediente
         (Nombre  "Patata")
    )

    ([sepia] of Ingrediente
         (Nombre  "Sepia")
    )

    ([chocolate] of Ingrediente
         (Nombre  "Chocolate")
    )

    ([cafe] of Ingrediente
         (Nombre  "cafe")
    )

    ([ensalada] of Tipo
         (Nombre  "Ensalada")
    )

    ([lechuga] of Ingrediente
         (Nombre  "Lechuga")
    )

    ([vino_blanco] of Bebida
         (Vino  "true")
         (Precio_copa  4)
         (region_comida  [mundo])
         (Precio  10)
         (Nombre  "Vino blanco")
         (estacion_comida  [siempre])
    )

    ([sopa_de_pollo] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [puerro] [zanahorias] [perejil] [ajo] [sal] [cebolla] [pechuga_pollo])
         (tipo_comida  [caldo])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_rosado] [vino_blanco])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  7)
         (Nombre  "Sopa de pollo")
         (estacion_comida  [siempre])
    )

    ([maiz] of Ingrediente
         (Nombre  "Maiz")
    )

    ([mantequilla] of Ingrediente
         (Nombre  "Mantequilla")
    )

    ([fajitas] of Ingrediente
         (Nombre  "Fajitas")
    )

    ([yogur] of Ingrediente
         (Nombre  "Yogur")
    )

    ([flan] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [huevo] [leche_condensada] [leche] [caramelo])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [mundo])
         (Precio  3.0)
         (Nombre  "Flan de huevo")
         (estacion_comida  [siempre])
    )

    ([fresa] of Ingrediente
         (Nombre  "Fresa")
    )

    ([fruta] of Tipo
         (Nombre  "Fruta")
    )

    ([limon] of Ingrediente
         (Nombre  "Limon")
    )

    ([cacao] of Ingrediente
         (Nombre  "cacao")
    )

    ([bizcocho] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [yogur] [limon] [huevo] [aceite] [azucar] [harina] [levadura] [sal])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "templado")
         (region_comida  [mundo])
         (Precio  3)
         (Nombre  "Bizcocho")
         (estacion_comida  [siempre])
    )

    ([tacos] of Plato
         (OrdenPlato  "segundo" "primero")
         (contieneIngrediente  [cebolla] [muslo_de_pollo] [fajitas] [tomate] [perejil])
         (tipo_comida  [carne])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  2)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [sudamerica])
         (Precio  8)
         (Nombre  "Tacos")
         (estacion_comida  [siempre])
    )

    ([naranja] of Ingrediente
         (Nombre  "Naranja")
    )

    ([pera] of Ingrediente
         (Nombre  "pera")
    )

    ([queso] of Ingrediente
         (Nombre  "Queso")
    )

    ([puerro] of Ingrediente
         (Nombre  "Puerro")
    )

    ([parmesano] of Ingrediente
         (Nombre  "Parmesano")
    )

    ([vino_rosado] of Bebida
         (Vino  "true")
         (Precio_copa  4)
         (region_comida  [mundo])
         (Precio  10)
         (Nombre  "Vino rosado")
         (estacion_comida  [siempre])
    )

    ([pescado] of Tipo
         (Nombre  "Pescado")
    )

    ([surtido_de_quesos] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [queso] [mascarpone] [sibarita] [parmesano])
         (tipo_comida  [picoteo])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "templado")
         (region_comida  [europa])
         (Precio  12)
         (Nombre  "Surtido de quesos")
         (estacion_comida  [siempre])
    )

    ([cerdo_agridulce] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [lomo] [arroz])
         (tipo_comida  [arroz] [carne])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [asia])
         (Precio  4)
         (Nombre  "cerdo agridulce")
         (estacion_comida  [siempre])
    )

    ([ensalada_con_fruta] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [manzana] [pera] [naranja] [cebolla] [lechuga] [tomate])
         (tipo_comida  [ensalada])
         (estilo_plato  [moderno])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado])
         (Temperatura  "templado")
         (region_comida  [mundo])
         (Precio  4)
         (Nombre  "Ensalada con fruta")
         (estacion_comida  [siempre])
    )

    ([pechuga_pollo] of Ingrediente
         (Nombre  "Pechuga de pollo")
    )

    ([fideua] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [sepia] [caldo_pescado] [pimiento_verde] [rape] [pimiento_rojo] [espagueti] [langostino] [ajo] [sal] [limon] [cebolla] [aceite] [tomate] [mejillones])
         (tipo_comida  [pescado])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado])
         (Temperatura  "caliente")
         (region_comida  [europa])
         (Precio  14)
         (Nombre  "Fideua")
         (estacion_comida  [siempre])
    )

    ([leche_condensada] of Ingrediente
         (Nombre  "Leche_condensada")
    )

    ([apio] of Ingrediente
         (Nombre  "Apio")
    )

    ([mejillones] of Ingrediente
         (Nombre  "Mejillones")
    )

    ([tartar_de_atun] of Plato
         (OrdenPlato  "segundo" "primero")
         (contieneIngrediente  [ajo] [sal] [atun])
         (tipo_comida  [pescado])
         (estilo_plato  [moderno] [sibarita])
         (Vegetariano  "false")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado])
         (Temperatura  "frio")
         (region_comida  [europa])
         (Precio  14)
         (Nombre  "Tartar de atun")
         (estacion_comida  [siempre])
    )

    ([coulant] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [mantequilla] [azucar] [chocolate] [harina] [huevo])
         (tipo_comida  [pastel])
         (estilo_plato  [moderno] [sibarita])
         (Vegetariano  "true")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "caliente")
         (region_comida  [europa])
         (Precio  8)
         (Nombre  "Coulant")
         (estacion_comida  [siempre])
    )

    ([tomate] of Ingrediente
         (Nombre  "Tomate")
    )

    ([bacaco] of Ingrediente
         (Nombre  "Bacaco")
    )

    ([bacon] of Ingrediente
         (Nombre  "Bacon")
    )

    ([agua] of Bebida
         (Vino  "false")
         (Precio_copa  0)
         (region_comida  [mundo])
         (Precio  0)
         (Nombre  "Agua")
         (estacion_comida  [siempre])
    )

    ([zanahorias] of Ingrediente
         (Nombre  "Zanahorias")
    )

    ([primavera] of Estacion
         (Nombre  "Primavera")
    )

    ([canelones] of Plato
         (OrdenPlato  "segundo" "primero")
         (contieneIngrediente  [tomate] [carne_picada] [pimiento_verde] [harina] [queso] [placas_de_pasta] [bechamel] [sal] [cebolla] [leche] [aceite] [mantequilla])
         (tipo_comida  [pasta])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  8)
         (Nombre  "Canelones")
         (estacion_comida  [siempre])
    )

    ([cebolla] of Ingrediente
         (Nombre  "Cebolla")
    )

    ([merluza_en_salsa] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [salsa_generica] [sibarita] [merlusa])
         (tipo_comida  [pescado])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  10)
         (Nombre  "Merluza en salsa")
         (estacion_comida  [siempre])
    )

    ([manzana] of Ingrediente
         (Nombre  "manzana")
    )

    ([verdura] of Tipo
         (Nombre  "Verdura")
    )

    ([clasico] of Estilo
         (Nombre  "clasico")
    )

    ([cebiche_de_atun] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [atun] [tomate] [sal] [limon])
         (tipo_comida  [pescado])
         (estilo_plato  [clasico] [sibarita])
         (Vegetariano  "false")
         (Complejidad  2)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [sudamerica])
         (Precio  16)
         (Nombre  "Ceviche de atun")
         (estacion_comida  [siempre])
    )

    ([placas_de_pasta] of Ingrediente
         (Nombre  "Placas de pasta")
    )

    ([picoteo] of Tipo
         (Nombre  "Picoteo")
    )

    ([pimienta] of Ingrediente
         (Nombre  "Pimienta")
    )

    ([vainilla] of Ingrediente
         (Nombre  "Vainilla")
    )

    ([mundo] of Region
         (Nombre  "Platos sin region especifica")
    )

    ([vinagre] of Ingrediente
         (Nombre  "Vinagre")
    )

    ([verduras_a_la_parrilla] of Plato
         (OrdenPlato  "primero" "segundo")
         (contieneIngrediente  [tomate] [pimiento_verde] [zanahorias] [pimiento_rojo] [cebolla])
         (tipo_comida  [verdura])
         (estilo_plato  [moderno])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado] [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  6)
         (Nombre  "Verduras a la parilla")
         (estacion_comida  [siempre])
    )

    ([nata] of Ingrediente
         (Nombre  "Nata")
    )

    ([otoño] of Estacion
         (Nombre  "Otoño")
    )

    ([arroz_con_gambas] of Plato
         (OrdenPlato  "segundo" "primero")
         (contieneIngrediente  [arroz] [gamba])
         (tipo_comida  [arroz])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado])
         (Temperatura  "caliente")
         (region_comida  [asia])
         (Precio  5)
         (Nombre  "Arroz con Gambas")
         (estacion_comida  [siempre])
    )

    ([perejil] of Ingrediente
         (Nombre  "Perejil")
    )

    ([espinacas] of Ingrediente
         (Nombre  "Espinacas")
    )

    ([lomo] of Ingrediente
         (Nombre  "lomo")
    )

    ([salsa_generica] of Ingrediente
         (Nombre  "Salsa generica")
    )

    ([magret_con_patatas] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [sal] [magret] [patata])
         (tipo_comida  [carne])
         (estilo_plato  [sibarita])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [europa])
         (Precio  18)
         (Nombre  "Magret con patatas")
         (estacion_comida  [siempre])
    )

    ([refresco] of Bebida
         (Vino  "false")
         (Precio_copa  0)
         (region_comida  [mundo])
         (Precio  2)
         (Nombre  "Refresco")
         (estacion_comida  [siempre])
    )

    ([moderno] of Estilo
         (Nombre  "moderno")
    )

    ([boloñesa] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [apio] [espagueti] [sal] [cebolla] [aceite] [tomate] [parmesano] [carne_picada] [azucar] [zanahorias])
         (tipo_comida  [pasta])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  2)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  5)
         (Nombre  "Boloñesa")
         (estacion_comida  [siempre])
    )

    ([jamon] of Ingrediente
         (Nombre  "Jamon")
    )

    ([soletilla] of Ingrediente
         (Nombre  "Soletilla")
    )

    ([azucar] of Ingrediente
         (Nombre  "azucar")
    )

    ([carne] of Tipo
         (Nombre  "Carne")
    )

    ([asia] of Region
         (Nombre  "Asia")
    )

    ([pimiento_rojo] of Ingrediente
         (Nombre  "Pimiento Rojo")
    )

    ([panacota_con_culi_de_fresa] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [leche] [azucar] [nata] [gelatina] [fresa] [limon])
         (tipo_comida  [fruta])
         (estilo_plato  [sibarita] [moderno])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [europa])
         (Precio  6)
         (Nombre  "Panacota con culi de fresa")
         (estacion_comida  [siempre])
    )

    ([sal] of Ingrediente
         (Nombre  "Sal")
    )

    ([sushi] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [arroz])
         (tipo_comida  [pescado])
         (estilo_plato  [clasico] [moderno])
         (Vegetariano  "true")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [asia])
         (Precio  13)
         (Nombre  "Sushi")
         (estacion_comida  [siempre])
    )

    ([ensalada_cesar] of Plato
         (OrdenPlato  "primero")
         (contieneIngrediente  [ajo] [sal] [limon] [huevo] [parmesano] [aceite] [lechuga] [muslo_de_pollo] [pimienta])
         (tipo_comida  [ensalada])
         (estilo_plato  [moderno])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco] [vino_rosado])
         (Temperatura  "templado")
         (region_comida  [europa])
         (Precio  7)
         (Nombre  "Ensalada Cesar")
         (estacion_comida  [siempre])
    )

    ([pimiento_verde] of Ingrediente
         (Nombre  "Pimiento verde")
    )

    ([soja] of Ingrediente
         (Nombre  "soja")
    )

    ([leche] of Ingrediente
         (Nombre  "Leche")
    )

    ([siempre] of Estacion
         (Nombre  "siempre")
    )

    ([espagueti] of Ingrediente
         (Nombre  "Espaguetti")
    )

    ([entrecot_vaca] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [sal] [entrecot_de_vaca])
         (tipo_comida  [carne])
         (estilo_plato  [clasico] [sibarita])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  18)
         (Nombre  "Entrecot de vaca")
         (estacion_comida  [siempre])
    )

    ([paella] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [pimienta] [arroz] [garrofo] [sal] [aceite] [azafran] [tomate] [muslo_de_pollo])
         (tipo_comida  [arroz])
         (estilo_plato  [clasico])
         (Vegetariano  "false")
         (Complejidad  3)
         (compatibilidadConBebida  [vino_rosado] [vino_blanco] [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [europa])
         (Precio  16)
         (Nombre  "Paella")
         (estacion_comida  [siempre])
    )

    ([aceite] of Ingrediente
         (Nombre  "Aceite")
    )

    ([magret] of Ingrediente
         (Nombre  "Magret")
    )

    ([vino_generico] of Bebida
         (Vino  "true")
         (Precio_copa  2)
         (region_comida  [mundo])
         (Precio  0)
         (Nombre  "Vino de la casa")
         (estacion_comida  [siempre])
    )

    ([langostino] of Ingrediente
         (Nombre  "Langostino")
    )

    ([muslo_en_salsa] of Plato
         (OrdenPlato  "segundo")
         (contieneIngrediente  [muslo_de_pollo] [salsa_generica])
         (tipo_comida  [carne])
         (Vegetariano  "false")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_tinto])
         (Temperatura  "caliente")
         (region_comida  [mundo])
         (Precio  7)
         (Nombre  "Muslo en salsa")
         (estacion_comida  [siempre])
    )

    ([ajo] of Ingrediente
         (Nombre  "Ajo")
    )

    ([vino_tinto] of Bebida
         (Vino  "true")
         (Precio_copa  4)
         (region_comida  [mundo])
         (Precio  10)
         (Nombre  "Vino tinto")
         (estacion_comida  [siempre])
    )

    ([caldo] of Tipo
         (Nombre  "Caldo")
    )

    ([sudamerica] of Region
         (Nombre  "Sudamerica")
    )

    ([atun] of Ingrediente
         (Nombre  "Atun")
    )

    ([caramelo] of Ingrediente
         (Nombre  "caramelo")
    )

    ([gelatina] of Ingrediente
         (Nombre  "Gelatina")
    )

    ;;; postre tiramisu
    ([tiramisu] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [cafe] [huevo] [cacao] [azucar] [amaretto] [mascarpone] [soletilla])
         (estilo_plato  [clasico])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [europa])
         (Precio  5)
         (Nombre  "Tiramisu")
         (estacion_comida  [siempre])
    )

    ([rustido] of Ingrediente
         (Nombre  "Rustido")
    )

    ([dulce_de_bacaco] of Plato
         (OrdenPlato  "tercero")
         (contieneIngrediente  [bacaco])
         (tipo_comida  [fruta])
         (estilo_plato  [clasico] [sibarita])
         (Vegetariano  "true")
         (Complejidad  1)
         (compatibilidadConBebida  [vino_blanco])
         (Temperatura  "frio")
         (region_comida  [sudamerica])
         (Precio  7)
         (Nombre  "Dulce de bacaco")
         (estacion_comida  [verano])
    )

    ([bechamel] of Ingrediente
         (Nombre  "Bechamel")
    )

)
