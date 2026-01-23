<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Zona de Juegos Navideños</title>
    <link rel="stylesheet" href="css/index.css">
    <script src="js/estrellas.js" defer></script>
    
    <style>
        /* --- ESTRUCTURA FIJA PARA HEADER --- */
        html, body {
            margin: 0; padding: 0;
            height: 100%; width: 100%;
            background-color: #05110b;
            background-image: url("img/f1.png");
            background-size: cover;
            background-attachment: fixed;
            overflow-x: hidden;
        }

        /* MENU FIJO REFORZADO */
        .header-fijo {
            position: fixed !important;
            top: 0; left: 0;
            width: 100%;
            height: 60px;
            background: #0a1f16 !important;
            border-bottom: 2px solid #ffce00;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 10000 !important; /* Capa máxima */
        }

        .header-fijo a {
            color: #ffce00 !important;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
            font-size: 14px;
        }

        /* CONTENIDO DESPLAZADO POR EL MENU */
        .seccion-fondo {
            padding-top: 80px; /* Espacio para que el menu no tape el titulo */
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
        }

        .stars { position: fixed !important; z-index: -1 !important; }

        /* JUEGOS */
        .game-screen {
            background: #0a1f16 !important;
            border: 2px solid #bc9b6a;
            border-radius: 15px;
            padding: 10px;
            margin-bottom: 20px;
            display: none;
            flex-direction: column;
            align-items: center;
            width: 90%;
            max-width: 400px;
            z-index: 1000;
            position: relative;
        }

        .game-screen.active { display: flex; }

        canvas { 
            width: 100% !important; 
            height: auto !important; 
            background: #000; 
            touch-action: none; /* Bloquea gestos del navegador para usar los nuestros */
        }

        .btn-accion {
            background: #ffce00; color: #000; border: none;
            padding: 10px 20px; border-radius: 20px;
            font-weight: bold; margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="header-fijo">
        <a href="index.jsp">Inicio</a>
        <a href="juegos.jsp">Juegos</a>
        <% if (session.getAttribute("perfil") != null) { %>
            <a href="cerrarSesion.jsp" style="color: #ffaaaa !important;">Cerrar</a>
        <% } %>
    </div>

    <div class="seccion-fondo">
        <div class="stars"></div>
        
        <h2 style="color:white; margin: 0 0 15px 0;">Zona de Juegos</h2>

        <div style="display:flex; gap:5px; margin-bottom: 15px;">
            <button class="tab-btn active" id="btn-p" onclick="cambiarJuego('puzzle')" style="background:#ffce00; border:none; padding:8px 12px; border-radius:10px;">Puzzle</button>
            <button class="tab-btn" id="btn-t" onclick="cambiarJuego('trineo')" style="background:rgba(255,255,255,0.2); color:white; border:none; padding:8px 12px; border-radius:10px;">Trineo</button>
            <button class="tab-btn" id="btn-l" onclick="cambiarJuego('laberinto')" style="background:rgba(255,255,255,0.2); color:white; border:none; padding:8px 12px; border-radius:10px;">Santa</button>
            <button class="tab-btn" id="btn-m" onclick="cambiarJuego('memoria')" style="background:rgba(255,255,255,0.2); color:white; border:none; padding:8px 12px; border-radius:10px;">Memoria</button>
        </div>

        <div id="screen-puzzle" class="game-screen active">
            <canvas id="puzzleCanvas" width="450" height="450"></canvas>
            <button class="btn-accion" onclick="shufflePuzzle()">Barajar</button>
        </div>

        <div id="screen-trineo" class="game-screen">
            <div style="color:white; margin-bottom:5px;">Pts: <span id="score">0</span> | <span id="hearts">❤️❤️❤️</span></div>
            <canvas id="trineoCanvas" width="450" height="500"></canvas>
            <button class="btn-accion" onclick="toggleTrineo()">Iniciar</button>
        </div>

        <div id="screen-laberinto" class="game-screen">
            <div style="color:#ffce00; font-size:12px; margin-bottom:5px;">Desliza tu dedo para mover a Santa</div>
            <canvas id="labCanvas" width="450" height="450"></canvas>
            <button class="btn-accion" onclick="initLaberinto()">Nuevo Mapa</button>
        </div>

        <div id="screen-memoria" class="game-screen" style="width: 100%; max-width: 800px; height: 600px;">
            <iframe src="juego-navidad.jsp" style="width: 100%; height: 100%; border: none; border-radius: 15px;"></iframe>
        </div>
    </div>

    <div id="modal-overlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:20000;"></div>
    <div id="custom-modal" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); background:#fdf5e6; padding:20px; border-radius:15px; border:3px solid #1b4d3e; z-index:20001; text-align:center; width:80%;">
        <h3 id="modal-title" style="color:#1b4d3e; margin:0;"></h3>
        <p id="modal-body" style="color:#333; margin:10px 0;"></p>
        <button class="btn-accion" onclick="closeModal()">Cerrar</button>
    </div>

    <script>
        function showPop(t, b) { document.getElementById('modal-title').innerText = t; document.getElementById('modal-body').innerText = b; document.getElementById('modal-overlay').style.display = 'block'; document.getElementById('custom-modal').style.display = 'block'; }
        function closeModal() { document.getElementById('modal-overlay').style.display = 'none'; document.getElementById('custom-modal').style.display = 'none'; }
        
        function cambiarJuego(tipo) {
            gameRunning = false;
            document.querySelectorAll('.game-screen').forEach(s => s.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => { b.style.background = "rgba(255,255,255,0.2)"; b.style.color = "white"; });
            event.target.style.background = "#ffce00"; event.target.style.color = "black";
            if(tipo==='puzzle'){document.getElementById('screen-puzzle').classList.add('active');initPuzzle();}
            else if(tipo==='trineo'){document.getElementById('screen-trineo').classList.add('active');resetTrineoVariables();}
            else{document.getElementById('screen-laberinto').classList.add('active');initLaberinto();}
        }

        // --- LÓGICA SWIPE LABERINTO ---
        const lCanvas = document.getElementById('labCanvas'), lCtx = lCanvas.getContext('2d');
        let grid = [], santa = {x:0, y:0};
        let touchStartX = 0, touchStartY = 0;

        lCanvas.addEventListener('touchstart', e => {
            touchStartX = e.changedTouches[0].screenX;
            touchStartY = e.changedTouches[0].screenY;
        }, false);

        lCanvas.addEventListener('touchend', e => {
            let touchEndX = e.changedTouches[0].screenX;
            let touchEndY = e.changedTouches[0].screenY;
            handleSwipe(touchEndX, touchEndY);
        }, false);

        function handleSwipe(endX, endY) {
            let dx = endX - touchStartX;
            let dy = endY - touchStartY;
            let cell = grid[santa.y * 10 + santa.x];

            if (Math.abs(dx) > Math.abs(dy)) {
                if (dx > 30 && !cell.walls[1]) santa.x++; // Derecha
                else if (dx < -30 && !cell.walls[3]) santa.x--; // Izquierda
            } else {
                if (dy > 30 && !cell.walls[2]) santa.y++; // Abajo
                else if (dy < -30 && !cell.walls[0]) santa.y--; // Arriba
            }
            drawMaze();
            if(santa.x === 9 && santa.y === 9) { showPop("¡Bien!", "Llegaste a la meta."); initLaberinto(); }
        }

        // --- RESTO DE LÓGICA (Simplificada) ---
        const pCanvas = document.getElementById('puzzleCanvas'), pCtx = pCanvas.getContext('2d'), pImg = new Image(); pImg.src = 'img/puzzle.jpg';
        let pieces = [], empty = {x:2, y:2};
        function initPuzzle() { pieces = []; for(let y=0; y<3; y++) for(let x=0; x<3; x++) pieces.push({ox:x, oy:y, cx:x, cy:y}); drawPuzzle(); }
        function drawPuzzle() {
            pCtx.clearRect(0,0,450,450);
            pieces.forEach(p => {
                if(p.cx === empty.x && p.cy === empty.y) { pCtx.fillStyle="#1b4d3e"; pCtx.fillRect(p.cx*150, p.cy*150, 150, 150); }
                else pCtx.drawImage(pImg, p.ox*(pImg.width/3), p.oy*(pImg.height/3), pImg.width/3, pImg.height/3, p.cx*150, p.cy*150, 150, 150);
            });
        }
        function shufflePuzzle() { for(let i=0; i<30; i++) { let m = [{x:empty.x-1,y:empty.y},{x:empty.x+1,y:empty.y},{x:empty.x,y:empty.y-1},{x:empty.x,y:empty.y+1}].filter(p => p.x>=0 && p.x<3 && p.y>=0 && p.y<3); let move = m[Math.floor(Math.random()*m.length)]; let p = pieces.find(p => p.cx === move.x && p.cy === move.y); p.cx = empty.x; p.cy = empty.y; empty = move; } drawPuzzle(); }
        pCanvas.onclick = (e) => { let r=pCanvas.getBoundingClientRect(); let x=Math.floor((e.clientX-r.left)/(r.width/3)), y=Math.floor((e.clientY-r.top)/(r.height/3)); if(Math.abs(x-empty.x)+Math.abs(y-empty.y)===1){ let p=pieces.find(p=>p.cx===x&&p.cy===y); p.cx=empty.x; p.cy=empty.y; empty={x,y}; drawPuzzle(); } };

        const tCanvas = document.getElementById('trineoCanvas'), tCtx = tCanvas.getContext('2d');
        let score=0, lives=3, items=[], gameRunning=false, tX = 200;
        function resetTrineoVariables() { score=0; lives=3; items=[]; document.getElementById('score').innerText=0; document.getElementById('hearts').innerText="❤️❤️❤️"; }
        tCanvas.ontouchmove = (e) => { let r=tCanvas.getBoundingClientRect(); tX=(e.touches[0].clientX-r.left)*(450/r.width)-30; e.preventDefault(); };
        function toggleTrineo() { gameRunning=true; resetTrineoVariables(); tLoop(); }
        function tLoop() {
            if(!gameRunning) return; tCtx.clearRect(0,0,450,500); tCtx.font="50px Arial"; tCtx.fillText("🛷", tX, 480);
            if(Math.random()<0.015) items.push({x:Math.random()*400, y:-30, type:['🎁','⭐','💣'][Math.floor(Math.random()*3)]});
            items.forEach((it, i) => {
                it.y += (1.0+score/200); tCtx.fillText(it.type, it.x, it.y);
                if(it.y>440 && it.y<490 && it.x>tX-10 && it.x<tX+50) { if(it.type==='💣'){ lives--; document.getElementById('hearts').innerText="❤️".repeat(lives); if(lives<=0) gameRunning=false; } else score+=10; items.splice(i,1); document.getElementById('score').innerText=score; }
            });
            requestAnimationFrame(tLoop);
        }

        function initLaberinto() {
            grid = []; santa = {x:0, y:0}; for(let j=0; j<10; j++) for(let i=0; i<10; i++) grid.push({i,j,walls:[true,true,true,true],v:false});
            let curr = grid[0]; curr.v=true; let stack=[];
            while(true){
                let i=curr.i, j=curr.j, neighs = [];
                [[i,j-1,0,2],[i+1,j,1,3],[i,j+1,2,0],[i-1,j,3,1]].forEach(m=>{ let n = grid[m[1]*10+m[0]]; if(m[0]>=0&&m[0]<10&&m[1]>=0&&m[1]<10&&!n.v) neighs.push({n,w1:m[2],w2:m[3]}); });
                if(neighs.length>0){ let next = neighs[Math.floor(Math.random()*neighs.length)]; next.n.v=true; stack.push(curr); curr.walls[next.w1]=false; next.n.walls[next.w2]=false; curr=next.n; }
                else if(stack.length>0) curr=stack.pop(); else break;
            } drawMaze();
        }
        function drawMaze() {
            lCtx.clearRect(0,0,450,450); lCtx.strokeStyle="white"; lCtx.lineWidth=2;
            grid.forEach(c=>{ let x=c.i*45, y=c.j*45; if(c.walls[0]){lCtx.beginPath();lCtx.moveTo(x,y);lCtx.lineTo(x+45,y);lCtx.stroke();} if(c.walls[1]){lCtx.beginPath();lCtx.moveTo(x+45,y);lCtx.lineTo(x+45,y+45);lCtx.stroke();} if(c.walls[2]){lCtx.beginPath();lCtx.moveTo(x+45,y+45);lCtx.lineTo(x,y+45);lCtx.stroke();} if(c.walls[3]){lCtx.beginPath();lCtx.moveTo(x,y+45);lCtx.lineTo(x,y);lCtx.stroke();} });
            lCtx.font="25px Arial"; lCtx.fillText("🎅", santa.x*45+5, santa.y*45+35); lCtx.fillText("🏠", 9*45+5, 9*45+35);
        }

        pImg.onload = initPuzzle;

        function cambiarJuego(tipo) {
            gameRunning = false;
            document.querySelectorAll('.game-screen').forEach(s => s.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => { 
                b.style.background = "rgba(255,255,255,0.2)"; 
                b.style.color = "white"; 
    });

        // Resaltar el botón presionado
        event.target.style.background = "#ffce00"; 
        event.target.style.color = "black";

        if(tipo === 'puzzle') {
            document.getElementById('screen-puzzle').classList.add('active');
            initPuzzle();
            } else if(tipo === 'trineo') {
                document.getElementById('screen-trineo').classList.add('active');
                resetTrineoVariables();
            } else if(tipo === 'laberinto') {
                document.getElementById('screen-laberinto').classList.add('active');
                initLaberinto();
            } else if(tipo === 'memoria') { // NUEVO
                document.getElementById('screen-memoria').classList.add('active');
            }
        }
    </script>
</body>
</html>
