<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.util.*, com.pesebreNavidad.seguridad.Calendario" %>

<%
    // Seguridad: solo Admin
    if (session.getAttribute("usuario") == null || (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso restringido");
        return;
    }

    Calendario cal = new Calendario();
    List<Calendario> lista = cal.listar();
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Administrar Calendario</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<!-- Mismo estilo que adminUsuarios -->
<link rel="stylesheet" href="css/adminUsuario.css">
<link rel="stylesheet" href="css/footer.css">

</head>
<body class="bg-light">

<div class="fondo-f1-blur"></div>

<!-- Menú -->
<%@ include file="includes/menu.jsp" %>

<div class="container mt-4">

    <!-- CARD FORM MÁS NUEVO -->
    <div class="card shadow-sm">

        <div class="card-header text-bg-success text-center fw-bold">
            <i class="bi bi-calendar-plus-fill me-2"></i> Registrar Nuevo Día
        </div>

        <div class="card-body">

            <form action="admin_calendario_nuevo.jsp" method="GET" class="text-center">
                <button class="btn btn-success px-4 fw-bold btn-guardar">
                    <i class="bi bi-plus-circle-fill me-2"></i> Crear nuevo día
                </button>
            </form>

        </div>
    </div>

    <!-- TABLA LISTADO -->
    <h4 class="text-center mt-5 mb-3 fw-bold">Días del Calendario Registrados</h4>

    <table class="table table-bordered table-striped text-center shadow-sm bg-white">
        <thead class="table-success">
            <tr>
                <th>Día</th>
                <th>Frase</th>
                <th>Fecha visible</th>
                <th>Estado</th>
                <th>Editar</th>
                <th>Activar / Desactivar</th>
            </tr>
        </thead>

        <tbody>

        <% for (Calendario c : lista) { 
               boolean activo = (c.getEstado() == 1);
        %>

        <tr>
            <td><%= c.getDia() %></td>
            <td><%= c.getFrase() %></td>
            <td><%= c.getFechaVisible() %></td>

            <!-- ESTADO -->
            <td>
                <% if (activo) { %>
                    <span class="badge text-bg-success">Activo</span>
                <% } else { %>
                    <span class="badge text-bg-danger">Inactivo</span>
                <% } %>
            </td>

            <!-- EDITAR -->
            <td>
                <a href="admin_calendario_editar.jsp?dia=<%= c.getDia() %>"
                   class="text-primary fs-5"
                   aria-label="Editar día <%= c.getDia() %>">

                    <i class="bi bi-pencil-square"></i>
                    <span class="visually-hidden">Editar</span>
                </a>
            </td>

            <!-- CAMBIAR ESTADO -->
            <td>
                <% if (activo) { %>
                    <a href="admin_calendario_estado.jsp?dia=<%= c.getDia() %>&estado=0"
                       class="text-danger fs-5"
                       aria-label="Desactivar día <%= c.getDia() %>"
                       onclick="return confirm('¿Desactivar este día?');">
                        <i class="bi bi-lock-fill"></i>
                        <span class="visually-hidden">Desactivar</span>
                    </a>
                <% } else { %>
                    <a href="admin_calendario_estado.jsp?dia=<%= c.getDia() %>&estado=1"
                       class="text-success fs-5"
                       aria-label="Activar día <%= c.getDia() %>"
                       onclick="return confirm('¿Activar este día?');">
                        <i class="bi bi-unlock-fill"></i>
                        <span class="visually-hidden">Activar</span>
                    </a>
                <% } %>
            </td>

        </tr>

        <% } %>

        </tbody>
    </table>

</div>

<!-- Footer -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>
