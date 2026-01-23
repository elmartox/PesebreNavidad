<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.*, com.pesebreNavidad.seguridad.*" %>

<%
    // ===================== CARGAR DATOS DEL CALENDARIO =====================
    Calendario cal = new Calendario();
    java.sql.Date hoy = new java.sql.Date(System.currentTimeMillis());

    List<Calendario> dias = cal.listarDisponibles(hoy);
    Map<Integer, Calendario> mapa = new HashMap<>();

    for (Calendario c : dias) {
        mapa.put(c.getDia(), c);
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Eventos Navideños</title>

<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- MODEL VIEWER -->
<script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="css/estilosEventos.css">
<link rel="stylesheet" href="css/footer.css">

<style>
/* Modal especial para calendario */
.modal-content {
    background: #fff7e6;
    border: 3px solid gold;
    border-radius: 15px;
}

.imagen-dia {
    width: 100%;
    max-width: 350px;     /* Tamaño ideal en celulares */
    height: auto;
    display: block;
    margin: 0 auto;       /* Centrada */
    border-radius: 12px;
    object-fit: contain;  /* No se deforma */
}
/* ======== FRASE DEL DÍA (texto principal) ======== */
.frase-dia {
    font-size: 1.3rem;
    font-weight: 600;
    color: #6b1d1d;          /* Vino navideño – legible y elegante */
    text-align: center;
    margin-bottom: 15px;
    padding: 10px 15px;
    background: #fff3e0;     /* Fondo suave */
    border-left: 4px solid #d43f3f;
    border-right: 4px solid #d43f3f;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}


/* TABLET */
@media (min-width: 600px) {
    .imagen-dia {
        max-width: 450px;
    }
}

/* ESCRITORIO */
@media (min-width: 992px) {
    .imagen-dia {
        max-width: 550px;
    }
}


/* Estilos acordeón */
.accordion-button {
    background-color: #b22222 !important;
    color: white !important;
    font-weight: bold;
}

.accordion-body {
    background: #fff3dd;
    border-radius: 10px;
    white-space: pre-line;
}
</style>

</head>

<body>

<!-- FONDO BORROSO -->
<div class="fondo-f1-blur"></div>

<!-- MENÚ -->
<%@ include file="includes/menu.jsp" %>

<!-- ============================ CONTENIDO ============================== -->

<div class="container mt-5">

    <h1 class="titulo text-center">🎄 Eventos Navideños 🎄</h1>
    <p class="text-center subtitulo mb-5">Explora música, tradiciones y actividades especiales</p>

<!-- ========================== CALENDARIO DINÁMICO =========================== -->

<div class="calendario-navidad">

    <h2 class="titulo-calendario">🕯 Novena de Aguinaldos — Diciembre 2025</h2>

    <div class="calendar-grid">

        <!-- Encabezados -->
        <div class="day-name">Lun</div>
        <div class="day-name">Mar</div>
        <div class="day-name">Mié</div>
        <div class="day-name">Jue</div>
        <div class="day-name">Vie</div>
        <div class="day-name">Sáb</div>
        <div class="day-name">Dom</div>

        <% 
            // Generar 1–31 utilizando el diseño de su compañero
            for (int d = 1; d <= 31; d++) {
                boolean desbloqueado = mapa.containsKey(d);
        %>

        <div class="day <%= desbloqueado ? "especial" : "" %>"
             <%= desbloqueado ? "onclick='abrirDia(" + d + ")'" : "" %>>
            <%= d %>
        </div>

        <% } %>

    </div>
</div>


<!-- ========================== MODAL DETALLE =========================== -->

<div class="modal fade" id="modalDia" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content p-3">

      <div class="modal-header">
        <h4 class="modal-title fw-bold text-danger">
            <i class="fa-solid fa-gift"></i> Día <span id="diaNumero"></span>
        </h4>
        <button class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <div id="fraseDia" class="frase-dia"></div>


        <img id="imgDia" class="imagen-dia d-none">

        <audio id="audioDia" controls class="d-none mt-3"></audio>

        <p id="villancicoDia" class="mt-3 fw-bold text-success"></p>

        <!-- LETRA EN ACORDEÓN -->
        <div id="acordeonLetra" class="accordion d-none mt-3">
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button" data-bs-toggle="collapse"
                        data-bs-target="#letraCollapse">
                        🎵 Mostrar letra del villancico
                    </button>
                </h2>
                <div id="letraCollapse" class="accordion-collapse collapse">
                    <div class="accordion-body" id="letraDia"></div>
                </div>
            </div>
        </div>

        <!-- PDF -->
        <a id="pdfBtn" class="btn btn-danger d-none mt-3" download>
            📄 Descargar Novena en PDF
        </a>

      </div>

    </div>
  </div>
</div>

<!-- ========================== REALIDAD VIRTUAL =========================== -->

<div class="tarjeta-seccion mt-5">

<h2 class="titulo-sub">🕶 Navidad en Realidad Virtual</h2>

<p class="texto">Explora experiencias navideñas inmersivas en 360°:</p>

<div class="text-center mt-3">
    <model-viewer
        src="3D/boy.glb"
        alt="Modelo 3D de un niño"
        camera-controls auto-rotate ar ar-scale="fixed"
        shadow-intensity="1"
        skybox-image="img/n1.jpg"
        camera-orbit="0deg 75deg 10m"
        camera-target="0m 1m 0m"
        field-of-view="31deg"
        scale="10 10 10"
        style="width:100%; max-width:700px; height:350px; margin:0 auto; border-radius:20px;">
    </model-viewer>
</div>

</div>


</div> <!-- FIN CONTAINER -->

<!-- Nieve -->
<script src="js/nieve.js"></script>
<script src="js/calendario.js"></script>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

<!-- BOOTSTRAP JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- ========================== PASAR DATOS A JS =========================== -->

<script>

const datos = {
<%
    for(Calendario c : dias) {

        String letra = (c.getLetra()==null ? "" :
                         c.getLetra()
                            .replace("\\","\\\\")
                            .replace("\"","\\\"")
                            .replace("\r","")
                            .replace("\n","\\n"));
%>

    <%= c.getDia() %> : {
        frase: "<%= c.getFrase().replace("\"","\\\"") %>",
        imagen: "<%= c.getImagen() %>",
        audio: "<%= c.getAudio() %>",
        villancico: "<%= c.getVillancico() %>",
        letra: "<%= letra %>",
        pdf: "<%= c.getPdfNovena() %>"
    },

<% } %>
};



// ============================ ABRIR MODAL ===============================
function abrirDia(dia) {

    const info = datos[dia];
    if (!info) return;

    document.getElementById("diaNumero").textContent = dia;
    document.getElementById("fraseDia").textContent = info.frase;

    // IMAGEN
    const img = document.getElementById("imgDia");
    img.classList.toggle("d-none", !info.imagen);
    if (info.imagen) img.src = info.imagen;

    // AUDIO
    const audio = document.getElementById("audioDia");
    audio.classList.toggle("d-none", !info.audio);
    if (info.audio) audio.src = info.audio;

    // VILLANCICO
    document.getElementById("villancicoDia").textContent =
        info.villancico ? "🎵 " + info.villancico : "";

    // LETRA EN ACORDEÓN
    const acordeon = document.getElementById("acordeonLetra");
    const letraDiv = document.getElementById("letraDia");

    if (info.letra && info.letra.trim().length > 0) {
        letraDiv.textContent = info.letra;
        acordeon.classList.remove("d-none");
    } else {
        acordeon.classList.add("d-none");
    }

    // PDF NOVENA — SOLO DÍAS 16–24
    const pdfBtn = document.getElementById("pdfBtn");
    if (dia >= 12 && dia <= 20 && info.pdf && info.pdf !== "null") {
        pdfBtn.href = info.pdf;
        pdfBtn.classList.remove("d-none");
    } else {
        pdfBtn.classList.add("d-none");
    }

    new bootstrap.Modal(document.getElementById("modalDia")).show();
}

</script>

</body>
</html>
