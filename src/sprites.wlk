import wollok.game.*

// cabeza direcciones
object izquierda {
	var property image = "assets/cabezaIzquierda.png"
	var property position = null
}

object derecha {
	var property image = "assets/cabezaDerecha.png"
	var property position = null
}

object arriba {
	var property image = "assets/cabeza.png"
	var property position = null
}

object abajo {
	var property image = "assets/cabezaAbajo.png"
	var property position = null
}


// cuerpo direcciones
object arribaAbajo {
	var property image = "assets/cuerpoArAb.png"
	var property position = null
}

object izquierdaDerecha {
	var property image = "assets/cuerpoIzqDer.png"
	var property position = null
}

// pantallas
object fondoFinDelJuego {
	const property image = "assets/fondoGameOver.jpg"
	const property position = game.at(0, 0)
}

object fondoNivel {
	const property image = "assets/fondoNivel.jpg"
	const property position = game.at(-1, -1)
}

object fondoMenu {
	const property position = game.at(0, 0)
	const property image = "assets/fondoInicio11.jpg"
}