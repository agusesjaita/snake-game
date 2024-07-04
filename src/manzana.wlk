import wollok.game.*
import jugador.*
import ajustesJuego.*
import sprites.*
import instancias.*


object manzana {
	const property image = "assets/manzana.png"
	var property position = game.at(0, 0)
	const dondeAparecer = []	
	
	method posicionAlAzarVacia() {
		position = self.posicionRandom()
	
		return if (self.estaOcupadaLaPosicion(position)) {self.posicionAlAzarVacia()} 
				else {position}
	}

	method posicionRandom() {
		const x = (0.. game.width()-1).anyOne()
		const y = (0.. game.height()-1).anyOne() 
		
    	return game.at(x, y)
	}

	method estaOcupadaLaPosicion(pos) {
    	return cabezaDeSnake.cuerpo().any({parte => parte.position() == pos})
	}
	
	method reubicar() {
		dondeAparecer.add(position)
		position = self.posicionAlAzarVacia()
		dondeAparecer.remove(position)
		game.addVisual(self)
	}
	
	method colisionar() {
		puntaje.puntos(puntaje.puntos() + 1)
		
	     cabezaDeSnake.cuerpo().add(new ParteDeSnake(
	     	nroDeParte = cabezaDeSnake.cuerpo().last().nroDeParte() + 1,
	     	position = cabezaDeSnake.cuerpo().last().position()))
	     	 
	     game.addVisual(cabezaDeSnake.cuerpo().last())
	     game.removeVisual(self)
	     self.reubicar()	     
	}
}