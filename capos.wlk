object rolando{
    const artefactos  =  #{}
    const historial = []
    var capacidad = 2
    const morada = castillo
    var property poderBase = 100
   
    method capacidad(_capacidad){
        capacidad = _capacidad
    }

    method incrementarCapacidad(cantidad){
        capacidad += cantidad
    }

    method poder() = poderBase + self.poderArtefactos()

    method poderArtefactos() = artefactos.sum({artefacto => artefacto.poder(self)})

    method puedeVencer(enemigo) = self.poder() > enemigo.poder()

    method artefactos() = artefactos

    method posesiones() = artefactos + morada.baul()

    method artefactoInvocado() = morada.artefactoInvocado(self)

    method historial() = historial

    method tieneCapacidad() = artefactos.size() < capacidad

    method batalla() {
        poderBase += 1
        artefactos.forEach({artefacto => artefacto.usar()})
    }

    method encontrar(artefacto){
        if(self.tieneCapacidad()){
            artefactos.add(artefacto)
        } 
        historial.add(artefacto)
    }

    method irAMorada(){
        morada.depositar(artefactos)
        artefactos.clear()
    }

    method tieneArtefactoFatal(enemigo) {
        return artefactos.any({artefacto => enemigo.poder() <= artefacto.poder(self)})
    }

    method artefactoFatal(enemigo) {
        return artefactos.find({artefacto => enemigo.poder() <= artefacto.poder(self)})
    } 
}

// ############################################ HECHIZOS ############################################

object bendicion{
    method poder(personaje) = 4
} 

object invisibilidad {
    method poder(personaje) = personaje.poderBase()
}

object invocacion {
    method poder(personaje) = personaje.artefactoInvocado().poder(personaje)
}

// ########################################### ARTEFACTOS ###########################################

object collar{
    var vecesUsadas = 0

    method poder(personaje) {
        return 3 + if (personaje.poderBase() > 6) vecesUsadas else 0
    }

    method usar() {
        vecesUsadas += 1 
    }
}

object armadura{
    method poder(personaje) = 6

    method usar() {}
}

object espada{
    var nueva = true

    method poder(personaje) {
        const coeficiente = if (nueva) {1} else {0.5}
        return personaje.poderBase() * coeficiente
    }

    method usar() {
        nueva = false
    }
}

object libro{
    var property hechizos = []

    method poder(personaje) {
        return if (hechizos.isEmpty()) {0} else {hechizos.first().poder(personaje)}
    }

    method usar() {
        hechizos = hechizos.drop(1)
    }
}

// ############################################ CASTILLO ############################################

object castillo{
    var property baul = #{}

    method depositar(artefactos){
        baul.addAll(artefactos)
    }

    method baul() = baul

    method artefactoInvocado(personaje) {
        return baul.max({artefacto => artefacto.poder(personaje)})
    }
}

// ###################################### LUGARES DE ENEMIGOS #######################################

object palacio{}

object fortaleza {}

object torre {}

// ############################################ ENEMIGOS ############################################

object archibaldo {
    method poder() = 16

    method morada() = palacio
} 

object caterina {
    method poder() = 28

    method morada() = fortaleza
}

object astra {
    method poder() = 15

    method morada() = torre
}

object erethia {
    var property enemigos = #{caterina, astra, archibaldo}

    method enemigosVencibles(personaje) {
        return enemigos.filter({enemigo => personaje.puedeVencer(enemigo)})
    }

    method moradasConquistables(personaje) {
        return self.enemigosVencibles(personaje).map({enemigo => enemigo.morada()}).asSet()
    }

    method esPoderoso(personaje) {
        return enemigos.all({enemigo => personaje.puedeVencer(enemigo)})
    }
}