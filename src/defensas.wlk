import pepita.*
import wollok.game.*

object inicializador{

	
	method nuevaTorre(posicion){
		
		const temp = new Torre(position = posicion)
		game.addVisual(temp)
		return temp.proyectil()
		}
	
	method nuevoProyectil(posicion){
		
		const temp = new Proyectil(position = posicion)
		game.addVisual(temp)
		return temp.disparar()
		
	}
	
}


class Torre{
	const property position
	const property image = "placeholderP.png"

	method proyectil() = game.onTick(1000, "Disparar", { => inicializador.nuevoProyectil((self.position()).right(1))})
	
	// { => game.addVisual(new Proyectil(position = ((self.position()).right(1))))}
	
	
}

class Proyectil{
	var property position
	const property image = "proyectil.png"
	const property danio = 1
		method inicioDisp(proy) = proy.disparar()
		method disparar() = game.onTick(250,"Viaje",{ => self.voyDerecha()})
		method voyDerecha(){ position = ((self.position()).right(1)) 
			return position
		}
}