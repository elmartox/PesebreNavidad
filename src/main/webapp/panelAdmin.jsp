<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<%
    if (session.getAttribute("usuario") == null || session.getAttribute("perfil") == null) {
        response.sendRedirect("login.jsp?error=Debe iniciar sesión");
        return;
    }

    int perfil = (Integer) session.getAttribute("perfil");

    if (perfil != 1) {
        response.sendRedirect("panelEstudiante.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");

    java.text.SimpleDateFormat formato =
        new java.text.SimpleDateFormat("EEEE dd 'de' MMMM yyyy");
    String fecha = formato.format(new java.util.Date());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel del Administrador</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Estilos -->
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/panelAdministrador.css">
</head>

<body>

    <!-- ⭐ Estrellas -->
    <div class="stars"></div>

    <!-- Fondo -->
    <div class="seccion-fondo">

        <!-- ⭐ MENÚ NAVIDEÑO CON BOOTSTRAP -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark bg-opacity-50 px-4" 
             style="backdrop-filter: blur(6px); z-index:20; position:relative; width:100%;">

            <!-- Título o logo -->
            <a class="navbar-brand fw-bold text-white" href="panelAdmin.jsp">
                🎄 Admin
            </a>

            <!-- Botón hamburguesa -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                    data-bs-target="#menuNav" aria-controls="menuNav" aria-expanded="false" 
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Opciones del menú -->
            <div class="collapse navbar-collapse justify-content-center" id="menuNav">
                <ul class="navbar-nav mb-2 mb-lg-0">

                    <li class="nav-item">
                        <a class="nav-link text-white" href="panelAdmin.jsp">Panel</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white" href="adminUsuarios.jsp">Usuarios</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white" href="bitacora.jsp">Bitácora</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white" href="mensajesAdmin.jsp">Mensajes Navideños</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white" href="cerrarSesion.jsp">Cerrar Sesión</a>
                    </li>

					<li class="nav-item"><a class="nav-link" href="adminPesebres.jsp">Pesebres</a></li>
					<li class="nav-item"><a class="nav-link" href="admin_calendario.jsp">Calendario</a></li>
                </ul>

                <!-- Usuario a la derecha -->
                <span class="navbar-text ms-lg-3 text-white fw-bold">
                    👤 <%= usuario %>
                </span>
            </div>
        </nav>

        <!-- ⭐ CONTENIDO PRINCIPAL -->
        <main class="text-center mt-5">

            <div class="caja-bienvenida">
                <h1>🎄 Bienvenido Administrador 🎄</h1>
                <h2 class="visually-hidden">Panel de gestión del administrador</h2>

                <p aria-hidden="false">Panel de Gestión – Pesebre Navideño</p>
                <p aria-hidden="false">📅 Hoy es <%= fecha %></p>
            </div>

        </main>

    </div>

    <!-- ESTRELLAS ANIMADAS -->
    <div id="estrellas-container"></div>
    <script src="js/login.js"></script>

    <!-- BOOTSTRAP JS (IMPORTANTE PARA EL MENÚ) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
