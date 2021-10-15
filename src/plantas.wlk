import wollok.game.*
import zombies.*

object selector{
	var property position = game.at(0,3)
	const property image = "crosshair025.png"
	var espacioOcupado=false
	
	method plantar(){
		espacioOcupado = self.algoPlantado()
		const temp = new Planta(position=position)
		game.addVisual(temp)
		return temp.disparar()
	}
	
	
	method algoPlantado(){
		espacioOcupado = game.colliders(self)
		if (not espacioOcupado.isEmpty()){
			self.error("Ya esta ocupado este espacio")
		}
		return espacioOcupado
	}
	
	method nuevoDisparo(posicion){
		const temp = new Disparo(position = posicion)
		game.addVisual(temp)
		return temp.moverse()
	}
	
}

class Planta {
	var vida=100
	var velocidad=2000
	const property position=0
	method image() {
		
		return "image-asset.png"
	}
	method disparar() = game.onTick(velocidad, "Disparar", { => selector.nuevoDisparo((self.position()).right(1))})
	
	method recibirDanio(){
	}
	method morir(){		
	}
}


class Disparo {
	const property velocidad=300
	var property position=0
	const property danio=1
	method image(){
		return "proyectil.png"
	}
	
	method moverse(){
		return game.onTick(velocidad, "Movement"+self.identity(), { self.move(self.position().right(1)) })
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
	method hacerDanio(unZombie){
		if (unZombie.vida()>1) { 
			unZombie.golpear()
		} else unZombie.revive()
	}
	
	}
