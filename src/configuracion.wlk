import wollok.game.*
import plantas.*
import zombies.*

	const musicaDeFondo = game.sound("musicaJuego.mp3")
    const musicaInicio = game.sound("musicaInicio.mp3")
    const musicaFinal = game.sound("musicaFinal.mp3")
object configuracion {
	
	method pantallaInicio() {
		game.addVisual(principio)	
		game.addVisualIn(pressStart, game.at(4,1))
		game.onTick(500, "PressStart", {=> pressStart.titilar() })
		musicaInicio.shouldLoop(true)
		game.schedule(50, {musicaInicio.play()})
		keyboard.enter().onPressDo{ self.fondoJuego()}
		keyboard.m().onPressDo{musicaInicio.stop()}
	}

	method fondoJuego() {
		game.addVisual(fondo)
		self.configuracionInicio()
	}

	method configuracionInicio() {
	game.removeVisual(pressStart)
	game.removeVisual(principio)
	game.addVisualCharacter(selector)
	game.schedule(50, {musicaInicio.stop()})
	musicaDeFondo.shouldLoop(true)
	game.schedule(50, {musicaDeFondo.play()})
    game.addVisual(cortadora0)
	game.addVisual(cortadora1)
	game.addVisual(cortadora2)
	game.addVisual(cortadora3)
	game.addVisual(cortadora4)


	game.onTick(15000,"inicializadorZombie",{ => inicializadorZombie.agregarZombie()})
	game.onTick(2000,"monedasPasivas",{=>cartera.recibirDinero(10)})
	keyboard.a().onPressDo{
		selector.plantarLanzaGuisantes()
		
	}
	keyboard.s().onPressDo{selector.plantarGirasol()}
	keyboard.d().onPressDo{selector.plantarGirasol()}

	keyboard.z().onPressDo{selector.totalDinero()}
	keyboard.m().onPressDo{musicaDeFondo.stop()}
	/*keyboard.r().onPressDo{
		selector.recogerSol()
	}*/

}
}

object principio {

	var property position = game.at(0, 0)
	var property image = "start.png"
	
	
}

object final {
	var property position = game.at(0,0)
	var property image = "gameOver.jpg"
	
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
object terminar {
	
	method cerrar() {
		
		game.addVisual(final)
		game.schedule(50, {musicaDeFondo.stop()})
		musicaFinal.shouldLoop(true)
		game.schedule(50, {musicaFinal.play()})
		game.schedule(10000, { game.stop()})
	}

}
