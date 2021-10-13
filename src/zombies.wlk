import wollok.game.*
import plantas.*

object inicializadorZombie{
	var x=0
	
	method agregarZombie(){
		const temp = new Zombie(position = game.at(14,x.randomUpTo(4)))
		game.addVisual(temp)
		return temp.moverse()
		
	}
}

class Zombie{
	const velocidad=4000
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
	method recibirDanio(){
		
	}
	method morir(){
		game.removeTickEvent("Movement"+self.identity())
	}
	
}