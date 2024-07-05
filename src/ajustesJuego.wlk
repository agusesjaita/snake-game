import wollok.game.*
import jugador.*
import manzana.*
import sprites.*
import instancias.*

object snake {
 		
 		method iniciar() {
			game.cellSize(32)
			game.height(20)
			game.width(15)
			pantallaDeInicio.iniciar()
	    	game.start()
	    }
	
	
    	method juegoIniciar() {
			const parte1 = new ParteDeSnake(position = game.at(3,5), nroDeParte = 1, siguienteaDondeIr = "right")
			const parte2 = new ParteDeSnake(position = game.at(2,5), nroDeParte = 2, siguienteaDondeIr = "right")
			
			game.addVisual(fondoNivel)
			game.addVisual(puntaje)
			game.addVisual(cabezaDeSnake)
			game.addVisual(parte1)
			game.addVisual(parte2)
			game.addVisual(manzana)
		
			cabezaDeSnake.cuerpo().add(cabezaDeSnake)
			cabezaDeSnake.cuerpo().add(parte1)
			cabezaDeSnake.cuerpo().add(parte2)
			
			game.onCollideDo(cabezaDeSnake, {a => a.colisionar()})
		
			keyboard.up().onPressDo({if (not (cabezaDeSnake.siguienteaDondeIr() == "down")) cabezaDeSnake.siguienteaDondeIr("up") else cabezaDeSnake.siguienteaDondeIr()})
			keyboard.down().onPressDo({if (not (cabezaDeSnake.siguienteaDondeIr() == "up")) cabezaDeSnake.siguienteaDondeIr("down") else cabezaDeSnake.siguienteaDondeIr()})
		    keyboard.left().onPressDo({if (not (cabezaDeSnake.siguienteaDondeIr() == "right")) cabezaDeSnake.siguienteaDondeIr("left") else cabezaDeSnake.siguienteaDondeIr()})
			keyboard.right().onPressDo({if (not (cabezaDeSnake.siguienteaDondeIr() == "left")) cabezaDeSnake.siguienteaDondeIr("right") else cabezaDeSnake.siguienteaDondeIr()})
			
			game.onTick(200, "movimientoDelJugador", {cabezaDeSnake.cuerpo().forEach({a => a.moverse()})})
		}
}
