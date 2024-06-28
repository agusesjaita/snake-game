import wollok.game.*
import jugador.*
import manzana.*

object snake{
 var item = null
 
 method iniciar(){
		game.cellSize(32)
		game.height(20)
		game.width(15)
		pantallaDeInicio.iniciar()
	    game.start()
	}
	
    method personaje(){
		const jugador = new CabezaDeSnake(position = game.at(4,5), siguienteaDondeIr = "right", seMovio = true)
		const parte1 = new ParteDeSnake(position = game.at(3,5), nroDeParte = 1, siguienteaDondeIr = "right", jugadorV = jugador)
		const parte2 = new ParteDeSnake(position = game.at(2,5), nroDeParte = 2, siguienteaDondeIr = "right", jugadorV = jugador)
		const man = new Manzana()
		item = man
		
		game.addVisual(jugador)
		game.addVisual(parte1)
		game.addVisual(parte2)
		game.addVisual(man)
		
		
		lasPartesDeSnake.add(jugador)
		lasPartesDeSnake.add(parte1)
		lasPartesDeSnake.add(parte2)
		game.onCollideDo(jugador, {a => a.colisionar(jugador)})
		
		
		keyboard.up().onPressDo({jugador.siguienteaDondeIr("up")})
		keyboard.down().onPressDo({jugador.siguienteaDondeIr("down")})
		keyboard.left().onPressDo({jugador.siguienteaDondeIr("left")})
		keyboard.right().onPressDo({jugador.siguienteaDondeIr("right")})
		
		game.onTick(200, "movimientoDelJugador",{lasPartesDeSnake.forEach({a => a.moverse()})})
	}
	
	method reiniciarPartida() {
		lasPartesDeSnake.forEach({cuerpo => game.removeVisual(cuerpo)})
		game.removeVisual(item)
		item = null
		lasPartesDeSnake.clear()                           
		self.personaje()
	}
}