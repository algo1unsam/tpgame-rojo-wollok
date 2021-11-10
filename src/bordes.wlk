import wollok.game.*
import zombies.*
import plantas.*

class Borde{
	var property position
	var property image = "pepita.png"
	
		method destruyo(unBorde){
		game.onCollideDo(unBorde, { proyectil => proyectil.meMuero()})
	}
}


const bordeDer0 = new Borde(position = game.at(15,0))
const bordeDer1 = new Borde(position = game.at(15,1))
const bordeDer2 = new Borde(position = game.at(15,2))
const bordeDer3 = new Borde(position = game.at(15,3))
const bordeDer4 = new Borde(position = game.at(15,4))

const bordeIzq0 = new Borde(position = game.at(-1,0))
const bordeIzq1 = new Borde(position = game.at(-1,1))
const bordeIzq2 = new Borde(position = game.at(-1,2))
const bordeIzq3 = new Borde(position = game.at(-1,3))
const bordeIzq4 = new Borde(position = game.at(-1,4))

object borde{
	
	const paredes = [bordeDer0, bordeDer1, bordeDer2, bordeDer3, bordeDer4, bordeIzq0, bordeIzq1, bordeIzq2, bordeIzq3, bordeIzq4]
	
	method colocar(){ paredes.forEach({unBorde => game.addVisual(unBorde)
															unBorde.destruyo(unBorde)})
	}											
	
	
}