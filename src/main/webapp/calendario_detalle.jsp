<%@ page contentType="text/html; charset=UTF-8" import="com.pesebreNavidad.seguridad.*, java.util.*" %>

<%
    int dia = Integer.parseInt(request.getParameter("dia"));
    Calendario c = new Calendario().obtener(dia);

    if (c == null) {
%>
        <div class="alert alert-danger">No se encontró información para este día.</div>
<%
        return;
    }
%>

<div class="card shadow p-4">

    <h3 class="text-center mb-3">Día <%= c.getDia() %> – <%= c.getFrase() %></h3>

    <%-- Imagen si existe --%>
    <% if (c.getImagen() != null && !c.getImagen().isEmpty()) { %>
        <img src="<%= c.getImagen() %>" class="img-fluid rounded mb-3">
    <% } %>

    <%-- Audio si existe --%>
    <% if (c.getAudio() != null && !c.getAudio().isEmpty()) { %>
        <audio controls class="w-100 mb-3">
            <source src="<%= c.getAudio() %>" type="audio/mpeg">
        </audio>
    <% } %>

    <%-- Villancico --%>
    <% if (c.getVillancico() != null) { %>
        <h5>🎵 <%= c.getVillancico() %></h5>
    <% } %>

    <%-- Letra --%>
    <% if (c.getLetra() != null) { %>
        <pre style="white-space: pre-wrap; background:#fff; padding:12px; border-radius:8px;"><%= c.getLetra() %></pre>
    <% } %>

    <%-- PDF si existe --%>
    <% if (c.getPdfNovena() != null && !c.getPdfNovena().isEmpty()) { %>
        <a href="<%= c.getPdfNovena() %>" class="btn btn-danger w-100 mt-3" target="_blank">
            📄 Descargar Novena
        </a>
    <% } %>

</div>
