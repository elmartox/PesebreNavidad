<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<% if (session.getAttribute("usuario") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pesebre en Realidad Aumentada</title>

<script src="https://aframe.io/releases/1.5.0/aframe.min.js"></script>
<script src="js/pesebreVR.js" defer></script>

<style>
body, html {
    margin: 0;
    padding: 0;
    height: 100%;
    overflow: hidden;
    background: #000;
}

.navbar {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 60px;
    background: rgba(0,0,0,0.8);
    backdrop-filter: blur(6px);
    z-index: 9999;
}


.menu-toggle {
    position: absolute;
    left: 20px;
    top: 15px;
    color: #fff;
    font-size: 22px;
    font-weight: bold;
    cursor: pointer;
    user-select: none;
}


.navbar-nav {
    position: absolute;
    top: 60px;
    left: 0;
    width: 100%;
    background: rgba(0,0,0,0.95);
    list-style: none;
    margin: 0;
    padding: 0;
    display: none;
    flex-direction: column;
}


.navbar-nav.show {
    display: flex;
}

.nav-item {
    text-align: center;
    padding: 15px 0;
    border-bottom: 1px solid rgba(255,255,255,0.15);
}

.nav-link {
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    text-decoration: none;
}

.nav-link:hover {
    color: #ffd700;
}

.text-danger {
    color: #ff5c5c;
}

a-scene[embedded] {
    position: absolute;
    top: 60px;
    left: 0;
    width: 100%;
    height: calc(100% - 60px);
}

.controls {
    position: fixed;
    bottom: 10px;          
    left: 50%;
    transform: translateX(-50%);
    z-index: 9999;

    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
}


.row {
    display: flex;
    gap: 10px;
}

.btn {
    width: 60px;
    height: 60px;
    background: rgba(255,255,255,0.25);
    border: 2px solid #fff;
    border-radius: 10px;
    color: #fff;
    font-size: 24px;
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
}

.btn:active {
    background: rgba(255,255,255,0.4);
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="menu-toggle" id="menuToggle">☰ Menú</div>

    <ul class="navbar-nav" id="navbarNav">
    <li class="nav-item"><a class="nav-link" href="panelEstudiante.jsp">Volver</a></li>
        <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
        <li class="nav-item"><a class="nav-link" href="historia.jsp">Historia</a></li>
        <li class="nav-item"><a class="nav-link" href="eventos.jsp">Eventos</a></li>
        <li class="nav-item"><a class="nav-link text-danger" href="cerrarSesion.jsp">Cerrar sesión</a></li>
    </ul>
</nav>

<!-- botones del jugador para la AR -->
<div class="controls">
    <div class="row"><div class="btn" id="btnUp">▲</div></div>
    <div class="row">
        <div class="btn" id="btnLeft">◀</div>
        <div class="btn" id="btnRight">▶</div>
    </div>
    <div class="row"><div class="btn" id="btnDown">▼</div></div>
</div>

<a-scene embedded>
    <a-sky src="img/fondo3.jpg"></a-sky>

    <a-entity gltf-model="3D/pesebreVR.glb"
              scale="3 3 3"
              position="0 0 -5"
              rotation="0 180 0"></a-entity>

    <a-light type="ambient" intensity="0.7"></a-light>
    <a-light type="directional" intensity="1.1" position="4 10 6"></a-light>

    <a-entity id="camaraJugador" camera look-controls position="0 1.6 -2">
        <a-cursor color="#ffd700"></a-cursor>
    </a-entity>
</a-scene>

</body>
</html>

