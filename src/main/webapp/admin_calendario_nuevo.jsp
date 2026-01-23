<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="com.pesebreNavidad.seguridad.Calendario" %>

<%
    // Seguridad: solo admin
    if (session.getAttribute("usuario") == null || (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso restringido");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Nuevo Día - Calendario</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="css/adminUsuario.css">
<link rel="stylesheet" href="css/footer.css">
</head>

<body class="bg-light">
<div class="fondo-f1-blur"></div>

<%@ include file="includes/menu.jsp" %>

<div class="container mt-4">

    <!-- FORM NUEVO DÍA -->
    <div class="card shadow-sm mx-auto" style="max-width:900px;">
        <div class="card-header text-bg-success text-center fw-bold">
            <i class="bi bi-calendar-plus-fill me-2"></i> Registrar Nuevo Día del Calendario
        </div>

        <div class="card-body">

<form action="admin_calendario_accion.jsp" method="post" class="row g-3 needs-validation" novalidate>

    <input type="hidden" name="accion" value="nuevo">

    <!-- DIA -->
    <div class="col-md-3">
        <label class="form-label">Número de Día *</label>
        <input type="number" name="dia" class="form-control" min="1" max="31" required>
        <div class="invalid-feedback">Ingrese un día válido (1–31).</div>
    </div>

    <!-- FECHA VISIBLE -->
    <div class="col-md-4">
        <label class="form-label">Fecha Visible *</label>
        <input type="date" name="fecha_visible" class="form-control" required>
    </div>

    <!-- FRASE -->
    <div class="col-md-12 mt-3">
        <label class="form-label">Frase *</label>
        <textarea name="frase" class="form-control" rows="2" required></textarea>
    </div>

    <!-- IMAGEN -->
    <div class="col-md-6">
        <label class="form-label">Imagen (ruta)</label>
        <input type="text" name="imagen" class="form-control" placeholder="imgs/dia1.png">
    </div>

    <!-- AUDIO -->
    <div class="col-md-6">
        <label class="form-label">Audio (ruta)</label>
        <input type="text" name="audio" class="form-control" placeholder="sonido/villancico1.mp3">
    </div>

    <!-- Villancico -->
    <div class="col-md-6 mt-3">
        <label class="form-label">Villancico</label>
        <input type="text" name="villancico" class="form-control">
    </div>

    <!-- PDF -->
    <div class="col-md-6 mt-3">
        <label class="form-label">PDF Novena (ruta)</label>
        <input type="text" name="pdf_novena" class="form-control" placeholder="pdf/dia1.pdf">
    </div>

    <!-- LETRA -->
    <div class="col-md-12 mt-3">
        <label class="form-label">Letra del villancico</label>
        <textarea name="letra" class="form-control" rows="4"></textarea>
    </div>

    <!-- BOTONES -->
    <div class="col-12 text-center mt-4">
        <button class="btn btn-success px-4 fw-bold btn-guardar"><i class="bi bi-check-circle-fill"></i> Guardar</button>
        <a href="admin_calendario.jsp" class="btn btn-danger px-4 fw-bold"><i class="bi bi-x-circle-fill"></i> Cancelar</a>
    </div>

</form>

        </div>
    </div>

</div>

<%@ include file="includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
  const forms = document.querySelectorAll('.needs-validation');
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }
      form.classList.add('was-validated');
    });
  });
})();
</script>

</body>
</html>
