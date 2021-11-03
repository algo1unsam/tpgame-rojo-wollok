import wollok.game.*
import plantas.*
import configuracion.*

object inicializadorZombie {

	var x = 0
	var y = 0

	method agregarZombie() {
		const unZombie = new OtroZombi(position = game.at(14, x.randomUpTo(4)))
		game.addVisual(unZombie)
		game.onCollideDo(unZombie, { proyectil => proyectil.hacerDanio(unZombie)})
		unZombie.comenzarAMoverse()
	}

}

class OtroZombi {

	const velocidad = 4000
	var property vida = 100
	var property position = 0
	
	
	method comenzarAMoverse(){
		game.onTick(5000, "avanza"+self.identity(), { self.avanzarIzquierda(position.left(1))})
	}
	method image() {
		return "zomby.png"
	}

	method vida() {
		return vida
	}

	method golpear() {
		vida -= 50
	}

	method avanzarIzquierda(nuevaPosicion) {
		var y = nuevaPosicion.y()
		if (nuevaPosicion == game.at(-1, y)) self.position(game.at(16, y)) else self.position(nuevaPosicion)
	}

	method hacerDanio(unZombi, proyectil) = 0
	
	method meMuero(){
		game.removeVisual(self)
		game.removeTickEvent("avanza"+self.identity())
	}
	
	method ganar() {
		if (position.x() == 1) {
			terminar.cerrar()
		}
	}

}

