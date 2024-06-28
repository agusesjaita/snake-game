import wollok.game.*
import manzana.*
import ajustesJuego.*

const lasPartesDeSnake = []

class ParteDeSnake {
	var property jugadorV = null
	var property aDondeIr = null
	var property siguienteaDondeIr = null
	var property lado = aDondeIr
	var property nroDeParte = 0
	var property position = game.center()
	var property image = "cuerpoArAb.png" //importa que sea una propiedad para que se abra el programa
	
	method siguienteaDondeIr() = siguienteaDondeIr
	
	method conseguirSiguienteaDondeIr(){
		siguienteaDondeIr = (lasPartesDeSnake.find(
			{p => p.nroDeParte() +1 == self.nroDeParte()}
		).aDondeIr())
	}
	
	method moverse(){
		if (jugadorV.seMovio()) {
	     aDondeIr = siguienteaDondeIr
		if (aDondeIr == "left"){
			position = position.left(1)
			image = "cuerpoIzqDer.png"
		} if (aDondeIr == "up"){
			position = position.up(1)
			image = "cuerpoArAb.png"
		} if (aDondeIr == "right"){
			position = position.right(1)
			image = "cuerpoIzqDer.png"
		} if (aDondeIr == "down"){
			position = position.down(1)
			image = "cuerpoArAb.png"
		}
		self.conseguirSiguienteaDondeIr()
		} else {
			position = self.seguirHaciaDondeIba(siguienteaDondeIr)
			image = self.animacionHacia(siguienteaDondeIr)
		}
	}	
		
	
	method seguirHaciaDondeIba(dir) =
		if (dir == "left"){
			position.left(1)
		} else if (dir == "up"){
			position.up(1)
		} else if (dir == "right"){
			position.right(1)
		} else position.down(1)
		
		
	method animacionHacia(dir) = 
		if (dir == "right" or dir == "left") "cuerpoIzqDer.png"
		else "cuerpoArAb.png"
	
	method colisionar(v){}
}

class CabezaDeSnake inherits ParteDeSnake {
	var property puntos = 0
	const puntuaciones = []
	var property seMovio = null
	var property detener = false
	
	override method image() = image
		
	override method conseguirSiguienteaDondeIr(){
		keyboard.up().onPressDo(siguienteaDondeIr = "up")
		keyboard.down().onPressDo(siguienteaDondeIr = "down")
		keyboard.left().onPressDo(siguienteaDondeIr = "left")
		keyboard.right().onPressDo(siguienteaDondeIr = "right")
	}
	
	
	override method moverse(){
		aDondeIr = siguienteaDondeIr
		if (position.y() == 0 or position.y() == 20 or position.x() == 0 or position.x() == 15) 
			{detener = true
			self.morir()} 
			else {
		if (lado != "right" and aDondeIr == "left"){
			position = position.left(1)
			self.seMovio(true)
			image = "cabezaIzquierda.png"
			lado = aDondeIr
		} else if (lado != "down" and aDondeIr == "up"){
			position = position.up(1)
			self.seMovio(true)
			image = "cabezaArriba.png"
			lado = aDondeIr
		} else if (lado != "left" and aDondeIr == "right"){
			position = position.right(1)
			self.seMovio(true)
			image = "cabezaDerecha.png"
			lado = aDondeIr
		} else if (lado != "up" and aDondeIr == "down"){
			position = position.down(1)
			self.seMovio(true)
			image = "cabezaAbajo.png"
			lado = aDondeIr
		} else {
			self.seMovio(false)
			position = self.seguirHaciaDondeIba(lado)
			image = self.animacionHacia(lado)
		}}
	}
	
	override method seguirHaciaDondeIba(dir) =
		if (dir == "left"){
			position.left(1)
		} else if (dir == "up"){
			position.up(1)
		} else if (dir == "right"){
			position.right(1)
		} else position.down(1)
		
	override method animacionHacia(dir) = 
		if (dir == "right") "cabezaDerecha.png"
		else if (dir == "left") "cabezaIzquierda.png"
		else if (dir == "down") "cabezaAbajo.png"
		else "cabezaArriba.png"
	
	method morir() {
		game.removeTickEvent("movimientoDelJugador")
		//game.addVisualIn("pantallaMuerte.png", game.center())
		keyboard.space().onPressDo({snake.reiniciarPartida()})
	}
	
	method mejorPuntuacion() = if (puntuaciones.isEmpty()) 0 else 
							   if (puntuaciones.max() < puntos) puntos else
							       puntuaciones.max()
}

object pantallaDeInicio {
	var property position = game.at(0, 0)
	var property image = "fondoInicio.jpg"
		
	method iniciar() {
		game.addVisual(self)
		keyboard.enter().onPressDo({
			game.removeVisual(self)
			//game.addVisualIn("fondoJuego.", game.center())
			snake.personaje()	
		})
	}
}

object textoPuntos {
	var cantidadPuntaje = 0
	
	method asignarPuntaje(numero) {cantidadPuntaje = numero}
	method text() = "maxima puntuacion" + cantidadPuntaje 
	method position() = game.at(game.width()/2, game.height() - 3)
	//method textColor() = "FF0000FF" probar colores
}
