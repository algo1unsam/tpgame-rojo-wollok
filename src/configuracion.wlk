import wollok.game.*
import plantas.*
import zombies.*

object configuracion {

	method pantallaInicio() {
		game.addVisual(principio)	
		game.addVisualIn(pressStart, game.at(4,1))
		game.onTick(500, "PressStart", {=> pressStart.titilar() })
		keyboard.enter().onPressDo{ self.fondoJuego()}
	}

	method fondoJuego() {
		game.addVisual(fondo)
		self.configuracionInicio()
	}

	method configuracionInicio() {
	game.addVisualCharacter(selector)
	game.sound("musicaJuego.mp3").play()
    game.addVisual(cortadora0)
	game.addVisual(cortadora1)
	game.addVisual(cortadora2)
	game.addVisual(cortadora3)
	game.addVisual(cortadora4)

	game.onTick(10000,"inicializadorZombie",{ => inicializadorZombie.agregarZombie()})

	keyboard.a().onPressDo{
		selector.plantarLanzaGuisantes()
		
	}
	keyboard.s().onPressDo{
		selector.plantarGirasol()
		
	}

	keyboard.z().onPressDo{
		selector.totalDinero()
	}
	/*keyboard.r().onPressDo{
		selector.recogerSol()
	}*/

}
}

object principio {

	var property position = game.at(0, 0)
	var property image = "start.png"

}
object fondo {

	var property position = game.at(0, 0)
	var property image = "fondoPvsZ.jpg"

	}


object pressStart{
	var cambio = 0
	
	method image() = if (cambio.even()) "assets/pressStart.png" else "assets/vacio35.png"
	method titilar(){
		cambio += 1
	}
	
}