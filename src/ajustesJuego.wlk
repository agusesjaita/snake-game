import wollok.game.*
import jugador.*
import puntuacion.*
import manzana.*

object snake{
 	var item = null
 	var property puntos = 0
	const puntaje = new Puntaje(quePoner = puntos, position = game.at(15, 11))
	const puntuaciones = []
	
	
 		method iniciar(){
			game.cellSize(32)
			game.height(20)
			game.width(15)
			pantallaDeInicio.iniciar()
	    	game.start()
		}
	
    	method personaje(){
			const jugador = new CabezaDeSnake(position = game.at(4,5), siguienteaDondeIr = "right")
			const parte1 = new ParteDeSnake(position = game.at(3,5), nroDeParte = 1, siguienteaDondeIr = "right")
			const parte2 = new ParteDeSnake(position = game.at(2,5), nroDeParte = 2, siguienteaDondeIr = "right")
			const man = new Manzana()
			item = man
			
			game.addVisual(fondoNivel)
			game.addVisual(jugador)
			game.addVisual(parte1)
			game.addVisual(parte2)
			game.addVisual(man)
		
		
			lasPartesDeSnake.add(jugador)
			lasPartesDeSnake.add(parte1)
			lasPartesDeSnake.add(parte2)
			game.onCollideDo(jugador, {a => a.colisionar()})
		
		
			keyboard.up().onPressDo({if (not (jugador.siguienteaDondeIr() == "down")) jugador.siguienteaDondeIr("up") else jugador.siguienteaDondeIr()})
			keyboard.down().onPressDo({if (not (jugador.siguienteaDondeIr() == "up")) jugador.siguienteaDondeIr("down") else jugador.siguienteaDondeIr()})
		    keyboard.left().onPressDo({if (not (jugador.siguienteaDondeIr() == "right")) jugador.siguienteaDondeIr("left") else jugador.siguienteaDondeIr()})
			keyboard.right().onPressDo({if (not (jugador.siguienteaDondeIr() == "left")) jugador.siguienteaDondeIr("right") else jugador.siguienteaDondeIr()})
			
			
			game.onTick(200, "movimientoDelJugador",{lasPartesDeSnake.forEach({a => a.moverse()})})
		}
	
		method sumarPuntos(){
			puntos += 1 
			puntaje.cambiarTexto(puntos)
		}
		
		method mejorPuntuacion() = if (puntuaciones.isEmpty()) 0 else 
							       if (puntuaciones.max() < puntos) puntos else
							           puntuaciones.max()
	
		method gameOver() {
			game.removeTickEvent("movimientoDelJugador")
    		game.removeVisual(puntaje)
    		puntuaciones.add(puntos)
			game.addVisual(gameOver) 
			puntaje.queDecir(self.mejorPuntuacion())
			puntaje.position(game.at(10, 6))
			game.addVisual(puntaje)
		
			keyboard.space().onPressDo({
				game.removeVisual(gameOver)
				lasPartesDeSnake.forEach({cuerpo => game.removeVisual(cuerpo)})
				game.removeVisual(item)
				game.removeVisual(puntaje)
				puntaje.position(game.at(15, 11))
				puntos = 0
				puntaje.quePoner(puntos)
				item = null
				lasPartesDeSnake.clear()
				game.removeVisual(fondoNivel)                           
				pantallaDeInicio.iniciar()			
			})
		}
}

object pantallaDeInicio {
	var property position = game.at(0, 0)
	var property image = "fondoInicio11.jpg"
		
	method iniciar() {
		game.addVisual(self)
		keyboard.enter().onPressDo({
			game.removeVisual(self)
			snake.personaje()	
		})
	}
}

object gameOver {
	var property image = "fondoGameOver.jpeg"
	var property position = game.at(0, 0)
}

object fondoNivel {
	var property image = "fondoNivel.jpeg"
	var property position = game.at(0, 0)
}