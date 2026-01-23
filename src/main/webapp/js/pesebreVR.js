const cam = document.getElementById("camaraJugador");

function mover(dx, dz) {
    const pos = cam.getAttribute("position");
    pos.x += dx;
    pos.z += dz;
    cam.setAttribute("position", pos);
}

btnUp.onclick = () => mover(0, -0.3);
btnDown.onclick = () => mover(0, 0.3);
btnLeft.onclick = () => mover(-0.3, 0);
btnRight.onclick = () => mover(0.3, 0);

const toggle = document.getElementById("menuToggle");
const menu = document.getElementById("navbarNav");

toggle.addEventListener("click", () => {
    menu.classList.toggle("show");
});
