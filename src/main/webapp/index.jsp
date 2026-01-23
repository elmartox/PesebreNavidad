<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pesebre Navideño</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&family=Mountains+of+Christmas:wght@700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="css/index.css">
</head>
<body>

<div class="stars"></div>

<div class="seccion-fondo">

    <button class="menu-btn" onclick="document.querySelector('.menu').classList.toggle('show')">
        ☰ Menú
    </button>

    <nav class="menu">
        <a href="index.jsp">Inicio</a>
        <a href="personajes.jsp">Personajes</a>
        <a href="historia.jsp">Historia</a>
        <a href="eventos.jsp">Eventos</a>
        <a href="mensajes.jsp">Mensajes</a>
        <a href="juegos.jsp">Juegos</a>
        <a href="registro.jsp">Registrarse</a>
        <a href="login.jsp">Iniciar Sesión</a>
    </nav>

    <div class="titulo">
        <h1>Bienvenido al pesebre navideño</h1>
        <p>Que la luz de la Navidad ilumine tu hogar con paz, amor y esperanza.</p>
    </div>

    <!-- CONTADOR -->
    <div id="contenedor-cuenta">
        <div class="caja-tiempo">
            <div class="numero" id="dias">00</div>
            <div class="texto">DÍAS</div>
        </div>
        <div class="caja-tiempo">
            <div class="numero" id="horas">00</div>
            <div class="texto">HORAS</div>
        </div>
        <div class="caja-tiempo">
            <div class="numero" id="minutos">00</div>
            <div class="texto">MIN</div>
        </div>
        <div class="caja-tiempo">
            <div class="numero" id="segundos">00</div>
            <div class="texto">SEG</div>
        </div>
    </div>

    <div id="mensaje-navidad">¡FELIZ NAVIDAD!</div>

    <div class="contenedor-superior">
        <img src="img/encima2.png" alt="Pesebre">
    </div>

</div>

<script>
function actualizarCuenta() {
    const anio = new Date().getFullYear();
    let navidad = new Date(anio, 11, 25, 0, 0, 0).getTime();
    const ahora = new Date().getTime();

    if (ahora > navidad + 86400000) {
        navidad = new Date(anio + 1, 11, 25, 0, 0, 0).getTime();
    }

    const diff = navidad - ahora;

    if (diff <= 0 && diff > -86400000) {
        document.getElementById("contenedor-cuenta").style.display = "none";
        document.getElementById("mensaje-navidad").style.display = "block";
        return;
    }

    const d = Math.floor(diff / (1000 * 60 * 60 * 24));
    const h = Math.floor((diff / (1000 * 60 * 60)) % 24);
    const m = Math.floor((diff / (1000 * 60)) % 60);
    const s = Math.floor((diff / 1000) % 60);

    document.getElementById("dias").innerText = d.toString().padStart(2, '0');
    document.getElementById("horas").innerText = h.toString().padStart(2, '0');
    document.getElementById("minutos").innerText = m.toString().padStart(2, '0');
    document.getElementById("segundos").innerText = s.toString().padStart(2, '0');
}

setInterval(actualizarCuenta, 1000);
actualizarCuenta();
</script>

</body>
</html>