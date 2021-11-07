import wollok.game.*
import zombies.*



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
	method plantarPapa(){
		self.plantar(new PlantaEscudo(position=position))
	}
	method plantar(planta) {
		espacioOcupado = self.algoPlantado()
		if(planta.precio()<=cartera.total()){
			game.addVisual(planta)
			planta.disparar()
			cartera.restarDinero(planta.precio())		
		}
	}
	method algoPlantado(){
		espacioOcupado = game.colliders(self)
		if (not espacioOcupado.isEmpty()){
			self.error("Ya esta ocupado este espacio")
			//agregar un sonido
		}
		return espacioOcupado
	}
	
	method meMuero(){}
	
	method totalDinero(){
		return game.say(self,cartera.total().printString())
	}
	
	
}
object cartera {
	var dinero = 50
	
	method recibirDinero(equis){
		dinero+=equis
	}
	method restarDinero(equis){
		dinero-=equis
	}
	method total(){
		return dinero
	}
	
}

class Planta {
	var property vida=100
	const property position
	const property precio = 50
	
	method nuevoDisparo(posicion){
		const temp = new Disparo(position = posicion)
		game.addVisual(temp)
		temp.moverse()
	}
	
	method image()
	method disparar()
	method hacerDanio(unZombi){ //proyectil es self
				game.removeVisual(self)
	}
	
}
 
class LanzaGuisantes inherits Planta{
	override method precio()=100
	override method image() {return "image-asset.png"}
	override method disparar() = game.onTick(7500, "Disparar"+self.identity(), { => self.nuevoDisparo((self.position()).right(1))})
	override method hacerDanio(unZombi){
		super(unZombi)
		game.removeTickEvent("Disparar"+self.identity())
	}
	
	//pasar el ontick a clase planta, y dejar lo otro aca abajo
	
}
class PlantaGirasol inherits Planta{ 
	
	override method image() {return "girasol.png"}
	override method disparar() = game.onTick(5000,"Moneda"+self.identity(),{=>cartera.recibirDinero(25) })
	override method hacerDanio(unZombi){
		super(unZombi)
		game.removeTickEvent("Moneda"+self.identity())
	}
	
}
class PlantaEscudo inherits Planta{
	
	override method image() = return "platazana.png"
	override method vida()=250
	override method disparar()=null
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
	
	method meMuero(){
		game.removeVisual(self)
		game.removeTickEvent("Movement"+self.identity())
	}
	
	method hacerDanio(unZombie){
		if (unZombie.vida()>1) { 
			unZombie.golpear()
			self.meMuero()
		} else {game.removeVisual(unZombie)
			 	self.meMuero()}
	}
	
	}
	class Cortadora{
		
		var image = "cortadora.png"
		var property position=0
		method image() = image
		method hacerDanio(unZombie){ 
			game.onTick(200, "atropella"+self.identity(), { self.move(self.position().right(1)) })
			unZombie.meMuero()
		}
		method meMuero(){
			game.removeVisual(self)
			game.removeTickEvent("atropella"+self.identity())
		}
		method move(nuevaPosicion) {
			if (nuevaPosicion.x()==3) self.sonidoAtropello()
		self.position(nuevaPosicion)}
		
		method sonidoAtropello(){
			return sonidoCortadoraPasto.play()
		}
		}
		
class Sonidos {
	method play()
}

object sonidoCortadoraPasto inherits Sonidos{
	override method play(){
		return game.sound("cortadoraPasto.mp3").play()
	}
}

	const cortadora0 = new Cortadora (position = game.at(2, 0))
	const cortadora1 = new Cortadora (position = game.at(2, 1))
	const cortadora2 = new Cortadora (position = game.at(2, 2))
	const cortadora3 = new Cortadora (position = game.at(2, 3))
	const cortadora4 = new Cortadora (position = game.at(2, 4))

	