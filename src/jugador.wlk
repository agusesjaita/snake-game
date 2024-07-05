import wollok.game.*
import manzana.*
import ajustesJuego.*
import sprites.* 
import instancias.*


object cabezaDeSnake {	
	var property image = derecha.image()
	var property aDondeIr = null
	var property siguienteaDondeIr = "right"
	var property position = game.at(4, 5)
	var property nroDeParte = 0
	const lasPartesDeSnake = []
	
	method siguienteaDondeIr() = siguienteaDondeIr
	
	method moverse(){
		aDondeIr = siguienteaDondeIr
		if (aDondeIr == "left"){
			position = position.left(1)
			image = izquierda.image()
		} if (aDondeIr == "up"){
			position = position.up(1)
			image = arriba.image()
		} if (aDondeIr == "right"){
			position = position.right(1)
			image = derecha.image()
		} if (aDondeIr == "down"){
			position = position.down(1)
			image = abajo.image()
		}}
	
	method cuerpo() = lasPartesDeSnake
	
	method reiniciar() = lasPartesDeSnake.clear()
	
	method colisionar() {pantallaDeMuerte.iniciar()}
}

class ParteDeSnake {
	var property aDondeIr = null
	var property siguienteaDondeIr = null
	var property nroDeParte = 0
	var property position = game.center()
	var property image = arribaAbajo.image()
	
	method siguienteaDondeIr() = siguienteaDondeIr
	
	method conseguirSiguienteaDondeIr() {
		siguienteaDondeIr = (cabezaDeSnake.cuerpo().find(
			{p => p.nroDeParte() +1 == self.nroDeParte()}
		).aDondeIr())
	}
	
	method moverse() {
		aDondeIr = siguienteaDondeIr
		if (aDondeIr == "left"){
			position = position.left(1)
			image = izquierdaDerecha.image()
		} if (aDondeIr == "up"){
			position = position.up(1)
			image = arribaAbajo.image()
		} if (aDondeIr == "right"){
			position = position.right(1)
			image = izquierdaDerecha.image()
		} if (aDondeIr == "down"){
			position = position.down(1)
			image = arribaAbajo.image()
		}
		self.conseguirSiguienteaDondeIr()
	}
		
	method crecer(){
		cabezaDeSnake.cuerpo().add(new ParteDeSnake(
	     	nroDeParte = cabezaDeSnake.cuerpo().last().nroDeParte() + 1,
	     	position = cabezaDeSnake.cuerpo().last().position()))
	     	 
	     game.addVisual(cabezaDeSnake.cuerpo().last())
	}
	
	method colisionar() {pantallaDeMuerte.iniciar()}
}


