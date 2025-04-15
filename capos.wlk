object rolando {
  const artefactos = #{}
  const historial = []
  var capacidad = 2
  const morada = castillo
  
  method incrementarCapacidad(cantidad) {
    capacidad += cantidad
  }
  
  method artefactos() = artefactos
  
  method posesiones() = artefactos + morada.baul()
  
  method encontrar(artefacto) {
    if (self.tieneCapacidad()) artefactos.add(artefacto)
    historial.add(artefacto)
  }
  
  method historial() = historial
  
  method tieneCapacidad() = artefactos.size() < capacidad
  
  method irAMorada() {
    morada.depositar(artefactos)
    artefactos.clear()
  }
}
//############################################# ARTEFACTOS ############################################

object espada {
  
}

object libro {
  
}

object collar {
  
}

object armadura {
  
}
//############################################### MORADA ##############################################

object castillo {
  const baul = #{}
  
  method depositar(artefactos) {
    baul.addAll(artefactos)
    // Agrega todo lo que me pasan por la coleccion artefactos.
    // En el caso de pasar una lista, se las arregla para que funcione (porque baul es un conjunto).
    // baul.add(artefactos) // Funciona, pero me queda conjunto de conjuto y podria tener conjuntos repetidos.
  }
  
  method baul() = baul
}