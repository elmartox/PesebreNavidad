<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<%
    if (session.getAttribute("usuario") == null || session.getAttribute("perfil") == null) {
        response.sendRedirect("login.jsp?error=Debe iniciar sesión");
        return;
    }

    int perfil = (Integer) session.getAttribute("perfil");
    if (perfil != 2) {
        response.sendRedirect("panelAdmin.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");

    java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("EEEE dd 'de' MMMM yyyy");
    String fecha = formato.format(new java.util.Date());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Estudiante</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Estilos originales -->
    <link rel="stylesheet" href="css/panelEstudiante.css">
    <script src="js/estrellas.js" defer></script>
</head>

<body>

    <!-- ⭐ Estrellas -->
    <div class="stars"></div>

    <div class="seccion-fondo">

        <!-- ⭐ MENÚ CON BOOTSTRAP (MISMO ESTILO NAVIDEÑO) -->
        <nav class="navbar navbar-expand-lg menu" style="z-index:20; position: relative;">
            <div class="container-fluid justify-content-center">

                <!-- Botón hamburguesa -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuEstudiante"
                        aria-controls="menuEstudiante" aria-expanded="false" aria-label="Toggle navigation"
                        style="background: rgba(255,255,255,0.12); border: 1px solid rgba(255,255,255,0.5);">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Contenido del menú -->
                <div class="collapse navbar-collapse justify-content-center" id="menuEstudiante">

                    <ul class="navbar-nav text-center">

                        <li class="nav-item">
                            <a class="nav-link" href="personajes.jsp">Personajes</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="historia.jsp">Historia</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="eventos.jsp">Eventos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="juegoVR.jsp">Pesebre en Realidad Aumentada</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="escribirMensajes.jsp">Mensajes Navideños</a>
                        </li>

							
							<li class="nav-item">
                            <a class="nav-link" href="votar.jsp">Apoya tu pesebre</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cerrarSesion.jsp">Cerrar Sesión</a>
                        </li>

                        <!-- Usuario -->
                        <li class="nav-item">
                            <a class="nav-link" style="color:white; font-weight:bold;">
                                👤 <%= usuario %>
                            </a>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>

        <!-- ⭐ Bienvenida -->
        <div class="bienvenida text-center">
            <div class="caja-bienvenida">
                <h1>✨ Bienvenido(a), <%= usuario %> ✨</h1>
                <p>Estudiante – Pesebre Navideño</p>
                <p>📅 Hoy es <%= fecha %></p>
            </div>
        </div>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
