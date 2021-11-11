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
			planta.hagoMiTrabajo()
			cartera.restarDinero(planta.precio())		
		}
	}
	method algoPlantado(){
		espacioOcupado = game.colliders(self)
		if (not espacioOcupado.isEmpty()){
			sonidoOcupado.play()
			self.error("Ya esta ocupado este espacio")
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
	const property position = game.at(13,4)
	var property textColor = "000000"
	method text() = "Dinero: " + dinero.toString()
	
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
	method velocidad() = 0
	
	method nuevoDisparo(posicion){
		const temp = new Disparo(position = posicion)
		game.addVisual(temp)
		sonidoDisparo.play()
		temp.moverse()
	}
	
	method comienzo()
	method termino(){game.removeTickEvent("Trabajo"+self.identity())}
	method image()
	method hagoMiTrabajo() = game.onTick(self.velocidad(), "Trabajo"+self.identity(), { => self.comienzo()})
	method hacerDanio(unZombi){ //proyectil es self
				game.removeVisual(self)
	}	
}
 
class LanzaGuisantes inherits Planta{
	override method velocidad() = 7500
	override method precio()=100
	override method image() {return "image-asset.png"}
	override method comienzo(){self.nuevoDisparo((self.position()).right(1))}
	override method hacerDanio(unZombi){
		super(unZombi)
		self.termino()
	}
	
	//pasar el ontick a clase planta, y dejar lo otro aca abajo
	
}
class PlantaGirasol inherits Planta{ 
	override method velocidad() = 5000
	override method image() {return "girasol.png"}
	override method comienzo(){cartera.recibirDinero(25)}
	override method hacerDanio(unZombi){
		super(unZombi)
		self.termino()
	}
	
}
class PlantaEscudo inherits Planta{
	
	override method image() = return "platazana.png"
	override method vida()=250
	override method comienzo()=null
	
	override method hacerDanio(unZombi){
		unZombi.detener()
		game.schedule(5000, {=> unZombi.comenzarAMoverse()})
		super(unZombi)
	}
	
}

// traer lógica de disparo a la clase misma? (.disparar())

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
		unZombie.herir()
		self.meMuero()			 	
	}

	}
	class Cortadora{
		
		var image = "cortadora.png"
		var property position=0
		var apagada = true
		method image() = image
		
		method hacerDanio(unZombie){ 
			// usar if para evitar repetir el onTick
			if(apagada){
			game.onTick(200, "atropella"+self.identity(), { self.move(self.position().right(1))})
			apagada = false
			}
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
		
class Sonido {
	var archivo
	method play(){ game.sound(archivo).play()
	}
}

const sonidoCortadoraPasto = new Sonido(archivo="cortadoraPasto.mp3")
const sonidoDisparo = new Sonido(archivo="disparos.mp3")
const sonidoOcupado = new Sonido(archivo="ocupado.mp3")

const cortadoras = [
	new Cortadora (position = game.at(2, 0)),
	new Cortadora (position = game.at(2, 1)),
	new Cortadora (position = game.at(2, 2)),
	new Cortadora (position = game.at(2, 3)),
	new Cortadora (position = game.at(2, 4))
	]
	
