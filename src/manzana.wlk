import wollok.game.*
import jugador.*
import ajustesJuego.*

const dondeAparecer = []

class ItemEnNivel{
	var position = game.origin()
	method reubicar(){
		dondeAparecer.add(position)
		position = dondeAparecer.anyOne()
		dondeAparecer.remove(position)
	}
}

class Manzana{
	var property position = self.posicionAlAzarVacia()
	var property image = "manzana.png"

	method posicionAlAzarVacia() {
	 const posicion = self.posicionRandom()
	
		return if (self.estaOcupadaLaPosicion(posicion)) {self.posicionAlAzarVacia()} 
				else {posicion}
	}

	method posicionRandom() {
		const x = (0.. game.width()-1).anyOne()
		const y = (0.. game.height()-1).anyOne() 
		
    	return game.at(x, y)
	}


	method estaOcupadaLaPosicion(pos) {
    	return lasPartesDeSnake.any({parte => parte.position() == pos})
	}
	
	method reubicar(){
		dondeAparecer.add(position)
		position = self.posicionAlAzarVacia()
		dondeAparecer.remove(position)
		game.addVisual(self)
	}
	
	method colisionar(v){
	     lasPartesDeSnake.add(new ParteDeSnake(
	     	nroDeParte = lasPartesDeSnake.last().nroDeParte() + 1,
	     	position = lasPartesDeSnake.last().position(),
	     	jugadorV = v))
	     	 
	     game.addVisual(lasPartesDeSnake.last())
	     game.removeVisual(self)
	     self.reubicar()	     
	}
}