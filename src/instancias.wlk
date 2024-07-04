import wollok.game.*
import ajustesJuego.*
import sprites.*
import manzana.*
import jugador.*

object pantallaDeInicio {
		
	method iniciar() {
		game.addVisual(fondoMenu)
		keyboard.enter().onPressDo({
			game.removeVisual(fondoMenu)
			snake.juegoIniciar()
		})
	}
}

object pantallaDeMuerte {
	
	method iniciar() {
		game.removeTickEvent("movimientoDelJugador")
    	game.removeVisual(puntaje)
    	puntaje.agregarPuntuacion()
    	puntaje.queMostrar(puntaje.mejorPuntuacion())
		game.addVisual(fondoFinDelJuego)
		puntaje.position(game.at(10, 6))
		game.addVisual(puntaje)
		
		keyboard.space().onPressDo({self.reiniciarNivel()})
			
		keyboard.q().onPressDo({game.stop()})
	}
	
	method reiniciarNivel() {
		game.removeVisual(fondoFinDelJuego)
		cabezaDeSnake.cuerpo().forEach({cuerpo => game.removeVisual(cuerpo)})
		game.removeVisual(manzana)
		game.removeVisual(puntaje)
		puntaje.position(game.at(15, 20))
		puntaje.queMostrar(puntaje.puntos())
		puntaje.puntos(0)
		cabezaDeSnake.cuerpo().clear()
		game.removeVisual(fondoNivel)                           
		pantallaDeInicio.iniciar()
	}
}

object puntaje {
	var property position = game.at(13, 18)
	var property color = "F4FF00"
	var property puntos = 0
	var property queMostrar = 0
	const puntuaciones = []
	
	
	method text() = queMostrar
	
	method textColor() = color
	
	method agregarPuntuacion() = puntuaciones.add(puntos)
		
	method mejorPuntuacion() = if (puntuaciones.isEmpty()) 0 else 
						       if (puntuaciones.max() < puntos) puntos else
						           puntuaciones.max()
						           
	method reiniciarPuntuaciones() = puntuaciones.clear()
	
	method colisionar() {}				  
}

