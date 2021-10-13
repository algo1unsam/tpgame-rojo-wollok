import wollok.game.*

class Planta {
	var vida=100
	const property position=0
	method image() {
		
		return "image-asset.png"
	}
	method disparar(){
		
	}
	method morir(){
		
	}
	
}

class Zombie{
	const velocidad=1000
	const vida=100
	var property position=0
	
	
	method image(){
		return "zomboide.png"
	}
	method moverse(){
		return game.onTick(velocidad, "Movement"+self.identity(), { self.move(self.position().left(1)) })
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}	
	method atacar(){
		
	}
	method morir(){
		game.removeTickEvent("Movement"+self.identity())
	}
	
}
class Disparo {
	const velocidad=1000
	var property position=0
	method image(){
		return "pepita.png"
	}
	method moverse(){
		game.onTick(velocidad, "MovimientoDisparo"+self.identity(),position.right(1))
	}
}
object uno{
	var x=0
	
	method agregarZombie(){
		const temp = new Zombie(position = game.at(14,x.randomUpTo(5)))
		game.addVisual(temp)
		return temp.moverse()
		
	}
}
object selector{
	var property position = game.at(0,3)
	const lista=[]
	const property image = "crosshair025.png"
	var espacioOcupado=false
	
	method plantar(){
		espacioOcupado = self.algoPlantado()
		game.addVisual(new Planta(position=position))
	}
	
	
	method algoPlantado(){
		espacioOcupado = game.colliders(self)
		if (not espacioOcupado.isEmpty()){
			self.error("Ya esta ocupado este espacio")
		}
		return espacioOcupado
	}
}