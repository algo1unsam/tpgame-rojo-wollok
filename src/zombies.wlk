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
class OtroZombi{
	const velocidad=4000
	var property vida = 101
	var property position=0
	var contadorDeRevivir = 0
	
	var property image
	method vida() { return vida}
	method golpear() {vida -= 25 } 
	method avanzarIzquierda(nuevaPosicion) {
		var y = nuevaPosicion.y()
		if (nuevaPosicion == game.at(-1, y)) 
			self.position(game.at(16, y)) 			
		else self.position(nuevaPosicion)
	}
	method revive(){ //en lugar de usar removeVisual cuando mueren, 
	                 //los vuelvo a poner en el principio de la pantalla.
		contadorDeRevivir += 1
		var y = self.position().y().randomUpTo(4)// los zombis reviven en una fila random
		vida = vida + 100*contadorDeRevivir // para que cada vez se haga mas fuerte
		self.position(game.at(15,y))
	}
	method hacerDanio(unZombi,proyectil) = 0
}
object movimientos {

	method movimientosOtroZombi() {
		game.onTick(6500, "avanza", { otroZombi0.avanzarIzquierda(otroZombi0.position().left(1))})
		game.onTick(6000, "avanza", { otroZombi1.avanzarIzquierda(otroZombi1.position().left(1))})
		game.onTick(5000, "avanza", { otroZombi2.avanzarIzquierda(otroZombi2.position().left(1))})
		game.onTick(9000, "avanza", { otroZombi3.avanzarIzquierda(otroZombi3.position().left(1))})
		game.onTick(7000, "avanza", { otroZombi4.avanzarIzquierda(otroZombi4.position().left(1))})
	}

}
class Zombie{
	const velocidad=4000
	var vida=100
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
const otroZombi0 = new OtroZombi(position = game.at(15, 0), image = "zomby.png")
const otroZombi1 = new OtroZombi(position = game.at(15, 1), image = "zomby.png")
const otroZombi2 = new OtroZombi(position = game.at(15, 2), image = "zomby.png")
const otroZombi3 = new OtroZombi(position = game.at(15, 3), image = "zomby.png")
const otroZombi4 = new OtroZombi(position = game.at(15, 4), image = "zomby.png")