<%@ page language="java" import="com.pesebreNavidad.seguridad.Calendario" %>

<%
    if (session.getAttribute("usuario") == null || (Integer)session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=No autorizado");
        return;
    }

    int dia = Integer.parseInt(request.getParameter("dia"));
    int estado = Integer.parseInt(request.getParameter("estado"));

    Calendario c = new Calendario();
    String msg = c.cambiarEstado(dia, estado);
%>

<script>
alert("<%= msg %>");
window.location.href = "admin_calendario.jsp";
</script>
