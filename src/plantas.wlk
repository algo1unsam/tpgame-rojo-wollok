import wollok.game.*
import zombies.*

object billetera{} // 

object selector{
	var property position = game.at(0,3)
	const property image = "crosshair025.png"
	var espacioOcupado=false
	
	method hacerDanio(unZombi,proyectil)=0
	method plantarLanzaGuisantes(){
		espacioOcupado = self.algoPlantado()
		const temp = new LanzaGuisantes(position=position)
		game.addVisual(temp)
		return temp.disparar()
	}
	method plantarGirasol(){
		espacioOcupado = self.algoPlantado()
		const temp = new PlantaGirasol(position=position)
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
	
	
	
	method hacerDanio(unZombi,proyectil){ //proyectil es self
				game.removeVisual(proyectil)
	}
	
}
class LanzaGuisantes inherits Planta{
	method image() {return "image-asset.png"}
	method disparar() = game.onTick(velocidad, "Disparar", { => selector.nuevoDisparo((self.position()).right(1))})
	
	
}
class PlantaGirasol inherits Planta{ 
	override method image() {return "girasol.png"}
	override method disparar() { return 0 }
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
	
	method hacerDanio(unZombie,proyectil){
		if (unZombie.vida()>1) { 
			unZombie.golpear()
			game.removeVisual(proyectil)
		} else unZombie.revive()
	}
	
	}
	class Cortadora{
		
		var image = "cortadora.png"
		var property position=0
		method image() = image
		method hacerDanio(unZombie,proyectil){ 
			game.onTick(200, "atropella", { self.move(self.position().right(1)) })
			unZombie.revive()}
		method move(nuevaPosicion) {
		self.position(nuevaPosicion)}
		}
	const cortadora0 = new Cortadora (position = game.at(0, 0))
	const cortadora1 = new Cortadora (position = game.at(0, 1))
	const cortadora2 = new Cortadora (position = game.at(0, 2))
	const cortadora3 = new Cortadora (position = game.at(0, 3))
	const cortadora4 = new Cortadora (position = game.at(0, 4))
