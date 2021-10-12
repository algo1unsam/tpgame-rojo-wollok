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
		return "pepita.png"
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
object selector{
	var property position = game.at(0,3)
	const property image = "crosshair025.png"
	
	method plantar(){
		game.addVisual(new Planta(position = position))
	}
}