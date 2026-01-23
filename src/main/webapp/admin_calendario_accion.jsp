<%@ page language="java" contentType="text/html; charset=UTF-8"
         import="com.pesebreNavidad.seguridad.Calendario" %>

<%
    request.setCharacterEncoding("UTF-8");

    String accion = request.getParameter("accion");
    Calendario c = new Calendario();

    int dia = Integer.parseInt(request.getParameter("dia"));
    c.setDia(dia);

    c.setFrase(request.getParameter("frase"));
    c.setAudio(request.getParameter("audio"));
    c.setImagen(request.getParameter("imagen"));
    c.setVillancico(request.getParameter("villancico"));
    c.setLetra(request.getParameter("letra"));

    // Los nombres correctos del formulario
    c.setPdfNovena(request.getParameter("pdf_novena"));
    c.setFechaVisible(java.sql.Date.valueOf(request.getParameter("fecha_visible")));

    String mensaje = "";

    if ("nuevo".equals(accion)) {
        mensaje = c.insertar();
    } else if ("editar".equals(accion)) {
        mensaje = c.actualizar();
    }
%>

<script>
alert("<%= mensaje %>");
window.location.href = "admin_calendario.jsp";
</script>
