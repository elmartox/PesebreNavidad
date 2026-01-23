<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="com.pesebreNavidad.seguridad.Calendario" %>

<%
    if (session.getAttribute("usuario") == null || (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=No tienes permisos");
        return;
    }

    int dia = Integer.parseInt(request.getParameter("dia"));
    Calendario c = new Calendario().obtener(dia);

    if (c == null) {
        out.println("<h2 class='text-danger text-center mt-5'>Día no encontrado</h2>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Editar Día</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="css/adminUsuario.css">
<link rel="stylesheet" href="css/footer.css">

</head>

<body class="bg-light">

<div class="fondo-f1-blur"></div>

<%@ include file="includes/menu.jsp" %>

<div class="container mt-4">

<!-- CARD EDITAR -->
<div class="card shadow-sm mx-auto" style="max-width:900px;">

    <div class="card-header text-bg-primary text-center fw-bold">
        <i class="bi bi-pencil-square me-2"></i> Editar Día <%= c.getDia() %>
    </div>

    <div class="card-body">

<form action="admin_calendario_accion.jsp" method="post" class="row g-3">

    <input type="hidden" name="accion" value="editar">
    <input type="hidden" name="dia" value="<%= c.getDia() %>">

    <!-- FRASE -->
    <div class="col-md-12">
        <label class="form-label">Frase *</label>
        <textarea name="frase" class="form-control" rows="2" required><%= c.getFrase() %></textarea>
    </div>

    <!-- IMAGEN -->
    <div class="col-md-6">
        <label class="form-label">Imagen</label>
        <input type="text" name="imagen" class="form-control" value="<%= c.getImagen() %>">
    </div>

    <!-- AUDIO -->
    <div class="col-md-6">
        <label class="form-label">Audio</label>
        <input type="text" name="audio" class="form-control" value="<%= c.getAudio() %>">
    </div>

    <!-- Villancico -->
    <div class="col-md-6 mt-3">
        <label class="form-label">Villancico</label>
        <input type="text" name="villancico" class="form-control" value="<%= c.getVillancico() %>">
    </div>

    <!-- PDF -->
    <div class="col-md-6 mt-3">
        <label class="form-label">PDF Novena</label>
        <input type="text" name="pdf_novena" class="form-control" value="<%= c.getPdfNovena() %>">
    </div>

    <!-- LETRA -->
    <div class="col-md-12 mt-3">
        <label class="form-label">Letra del villancico</label>
        <textarea name="letra" class="form-control" rows="4"><%= c.getLetra() %></textarea>
    </div>

    <!-- FECHA VISIBLE -->
    <div class="col-md-4 mt-3">
        <label class="form-label">Fecha visible *</label>
        <input type="date" name="fecha_visible" class="form-control" 
               value="<%= new java.sql.Date(c.getFechaVisible().getTime()) %>" required>
    </div>

    <!-- BOTONES -->
    <div class="col-12 text-center mt-4">
        <button class="btn btn-primary px-4 fw-bold">
            <i class="bi bi-save-fill me-2"></i> Guardar Cambios
        </button>

        <a href="admin_calendario.jsp" class="btn btn-danger px-4 fw-bold">
            <i class="bi bi-x-circle-fill"></i> Cancelar
        </a>
    </div>

</form>
    </div>
</div>

</div>

<%@ include file="includes/footer.jsp" %>

</body>
</html>
