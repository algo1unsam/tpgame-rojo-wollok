import wollok.game.*
import zombies.*

object billetera{} // 

object selector{
	var property position = game.at(3,2)
	const property image = "crosshair025.png"
	var espacioOcupado=false
	
	method hacerDanio(unZombi)=0
	method plantarLanzaGuisantes(){
		self.plantar(new LanzaGuisantes(position=position))
	}
	method plantarGirasol(){
		self.plantar(new PlantaGirasol(position=position))
	}
	method plantar(planta) {
		espacioOcupado = self.algoPlantado()
		game.addVisual(planta)
		planta.disparar()
	}
	method algoPlantado(){
		espacioOcupado = game.colliders(self)
		if (not espacioOcupado.isEmpty()){
			self.error("Ya esta ocupado este espacio")
			//agregar un sonido
		}
		return espacioOcupado
	}
	
	method nuevoDisparo(posicion){ //mover a clase plantas
		const temp = new Disparo(position = posicion)
		game.addVisual(temp)
		temp.moverse()
	}
	method totalDinero(){
		return game.say(self,cartera.total().printString())
	}
	
	
}
object cartera {
	var dinero = 50
	
	method recibirDinero(equis){
		dinero+=equis
	}
	method total(){
		return dinero
	}
	
}

class Planta {
	var vida=100
	var velocidad=4000 // es distinto para cada instancia? o se define por subclase
	//si es por subclase convertirlo en metodo
	const property position
	
	method image()
	method disparar()
	method hacerDanio(unZombi){ //proyectil es self
				game.removeVisual(self)//falta sacar el ontick del disparo
	}
	
}
class LanzaGuisantes inherits Planta{
	override method image() {return "image-asset.png"}
	override method disparar() = game.onTick(velocidad, "Disparar", { => selector.nuevoDisparo((self.position()).right(1))})
	//pasar el ontick a clase planta, y dejar lo otro aca abajo
	
}
class PlantaGirasol inherits Planta{ 
	override method image() {return "girasol.png"}
	override method disparar() = game.onTick(velocidad,"Moneda",{=>cartera.recibirDinero(25) })
	
	
}

class Disparo {
	const property velocidad=40
	var property position
	const property danio=1
	method image(){
		return "proyectil.png"
	}
	
	method moverse(){
		game.onTick(velocidad, "Movement"+self.identity(), { self.move(self.position().right(1)) })
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
		
	}
	
	method hacerDanio(unZombie){
		if (unZombie.vida()>1) { 
			unZombie.golpear()
			game.removeVisual(self)
		} else {game.removeVisual(unZombie)}
	}
	
	}
	class Cortadora{
		
		var image = "cortadora.png"
		var property position=0
		method image() = image
		method hacerDanio(unZombie){ 
			game.onTick(200, "atropella", { self.move(self.position().right(1)) })
			game.removeVisual(unZombie)
		}
			
		method move(nuevaPosicion) {
		self.position(nuevaPosicion)}
		}
	const cortadora0 = new Cortadora (position = game.at(2, 0))
	const cortadora1 = new Cortadora (position = game.at(2, 1))
	const cortadora2 = new Cortadora (position = game.at(2, 2))
	const cortadora3 = new Cortadora (position = game.at(2, 3))
	const cortadora4 = new Cortadora (position = game.at(2, 4))
