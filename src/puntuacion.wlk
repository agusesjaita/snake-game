import wollok.game.*
import jugador.*
import manzana.*

class Puntaje {
	var property position = game.center()
	var property quePoner 
	method text() = quePoner.toString()
	method cambiarTexto(nuevo){
		quePoner = nuevo.toString()
	}
	method colisionar(){}
}
