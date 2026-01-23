<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page session="true" %>

<!-- BOTÓN SOLO EN CELULAR -->
<button class="menu-btn d-lg-none" onclick="toggleMenu()">☰ Menú</button>

<!-- MENÚ PRINCIPAL -->
<nav class="menu navbar-expand-lg d-flex align-items-center justify-content-between px-4">

    <!-- LINKS DEL MENÚ -->
    <ul class="navbar-nav mx-auto">

        <% 
            // Si NO hay usuario → Invitado
            if (session.getAttribute("perfil") == null) { 
        %>

            <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
            <li class="nav-item"><a class="nav-link" href="personajes.jsp">Personajes</a></li>
            <li class="nav-item"><a class="nav-link" href="historia.jsp">Historia</a></li>
            <li class="nav-item"><a class="nav-link" href="eventos.jsp">Eventos</a></li>
            <li class="nav-item"><a class="nav-link" href="mensajes.jsp">Mensajes Navideños</a></li>
            <li class="nav-item"><a class="nav-link" href="juegos.jsp">Juegos</a></li>
            <li class="nav-item"><a class="nav-link" href="registro.jsp">Registrarse</a></li>
            <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>

        <% 
            } else { 
                int perfil = Integer.parseInt(session.getAttribute("perfil").toString());

                // ⭐ PERFIL ESTUDIANTE (2)
                if (perfil == 2) { 
        %>

            <li class="nav-item"><a class="nav-link" href="personajes.jsp">Personajes</a></li>
            <li class="nav-item"><a class="nav-link" href="historia.jsp">Historia</a></li>
            <li class="nav-item"><a class="nav-link" href="eventos.jsp">Eventos</a></li>
            <li class="nav-item"><a class="nav-link" href="juegoVR.jsp">Pesebre en Realidad Aumentada</a></li>
            
             <li class="nav-item"><a class="nav-link" href="juegos.jsp">Juegos</a></li>
            <li class="nav-item"><a class="nav-link" href="votar.jsp">Apoya tu pesebre</a></li>
            <li class="nav-item"><a class="nav-link" href="escribirMensajes.jsp">Mensajes Navideños</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="cerrarSesion.jsp">Cerrar Sesión</a></li>

        <% 
                }

                // ⭐ PERFIL ADMINISTRADOR (1)
                if (perfil == 1) { 
        %>

            <li class="nav-item"><a class="nav-link" href="panelAdmin.jsp">Panel</a></li>
            <li class="nav-item"><a class="nav-link" href="adminUsuarios.jsp">Usuarios</a></li>
            <li class="nav-item"><a class="nav-link" href="bitacora.jsp">Bitácora</a></li>
            <li class="nav-item"><a class="nav-link" href="mensajesAdmin.jsp">Mensajes Navideños</a></li>
            <li class="nav-item"><a class="nav-link" href="adminPesebres.jsp">Pesebres</a></li>
<<<<<<< HEAD
            <li class="nav-item"><a class="nav-link" href="juegos.jsp">Juegos</a></li>
=======
            <li class="nav-item"><a class="nav-link" href="admin_calendario.jsp">Calendario</a></li>
>>>>>>> branch 'main' of https://github.com/NicoleParedes24/PesebreNavidad.git
            <li class="nav-item"><a class="nav-link text-danger " href="cerrarSesion.jsp">Cerrar Sesión</a></li>

        <% 
                }
            } 
        %>

    </ul>

<!--     ⭐⭐ BOTONES DE ACCESIBILIDAD -->
<!--     <div class="d-flex align-items-center gap-2"> -->

<!--         Aumentar letra -->
<!--         <button class="btn btn-sm btn-light" onclick="aumentarLetra()" aria-label="Aumentar tamaño de texto"> -->
<!--             A+ -->
<!--         </button> -->

<!--         Disminuir letra -->
<!--         <button class="btn btn-sm btn-light" onclick="disminuirLetra()" aria-label="Disminuir tamaño de texto"> -->
<!--             A- -->
<!--         </button> -->

<!--         Alto contraste -->
<!--         <button class="btn btn-sm btn-warning" onclick="toggleContraste()" aria-label="Activar modo alto contraste"> -->
<!--             🌓 -->
<!--         </button> -->
<!--     </div> -->

</nav>

<script>
function toggleMenu() {
    document.querySelector(".menu").classList.toggle("show");
}

// -----------------------------
// ACCESIBILIDAD
// -----------------------------
let tamañoLetra = 100;

// Aumentar
function aumentarLetra() {
    tamañoLetra += 10;
    document.body.style.fontSize = tamañoLetra + "%";
}

// Disminuir
function disminuirLetra() {
    if (tamañoLetra > 70) {
        tamañoLetra -= 10;
        document.body.style.fontSize = tamañoLetra + "%";
    }
}

// Alto contraste
function toggleContraste() {
    document.body.classList.toggle("contraste");
}
</script>
