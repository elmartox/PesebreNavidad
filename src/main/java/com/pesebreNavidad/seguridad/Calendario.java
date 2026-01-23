package com.pesebreNavidad.seguridad;

import com.pesebreNavidad.datos.Conexion;
import java.sql.*;
import java.util.*;
import java.util.Date;

public class Calendario {

    private int dia;
    private String frase;
    private String audio;
    private String imagen;
    private String villancico;
    private String letra;
    private String pdfNovena;
    private Date fechaVisible;
    private int estado;

    // Getters
    public int getDia() { return dia; }
    public String getFrase() { return frase; }
    public String getAudio() { return audio; }
    public String getImagen() { return imagen; }
    public String getVillancico() { return villancico; }
    public String getLetra() { return letra; }
    public String getPdfNovena() { return pdfNovena; }
    public Date getFechaVisible() { return fechaVisible; }
    public int getEstado() { return estado; }

    // Setters
    public void setDia(int d) { dia = d; }
    public void setFrase(String f) { frase = f; }
    public void setAudio(String a) { audio = a; }
    public void setImagen(String i) { imagen = i; }
    public void setVillancico(String v) { villancico = v; }
    public void setLetra(String l) { letra = l; }
    public void setPdfNovena(String p) { pdfNovena = p; }
    public void setFechaVisible(Date fv) { fechaVisible = fv; }
    public void setEstado(int e) { estado = e; }

    // ============================================================
    // LISTAR TODO — ADMIN
    // ============================================================
    public List<Calendario> listar() {
        List<Calendario> lista = new ArrayList<>();

        try {
            Conexion cx = new Conexion();
            ResultSet rs = cx.Consulta("SELECT * FROM tb_calendario ORDER BY dia ASC");

            while (rs.next()) {
                Calendario c = new Calendario();
                c.dia = rs.getInt("dia");
                c.frase = rs.getString("frase");
                c.audio = rs.getString("audio");
                c.imagen = rs.getString("imagen");
                c.villancico = rs.getString("villancico");
                c.letra = rs.getString("letra");
                c.pdfNovena = rs.getString("pdf_novena");
                c.fechaVisible = rs.getDate("fecha_visible");
                c.estado = rs.getInt("estado");
                lista.add(c);
            }

        } catch (Exception e) {
            System.out.println("Error listar calendario: " + e.getMessage());
        }
        return lista;
    }

    // ============================================================
    // LISTAR DISPONIBLES — USUARIO
    // ============================================================
    public List<Calendario> listarDisponibles(Date hoy) {
        List<Calendario> lista = new ArrayList<>();

        try {
            Conexion cx = new Conexion();
            PreparedStatement ps = cx.getConexion().prepareStatement(
                "SELECT * FROM tb_calendario WHERE estado = 1 AND fecha_visible <= ? ORDER BY dia"
            );
            ps.setDate(1, new java.sql.Date(hoy.getTime()));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Calendario c = new Calendario();
                c.dia = rs.getInt("dia");
                c.frase = rs.getString("frase");
                c.audio = rs.getString("audio");
                c.imagen = rs.getString("imagen");
                c.villancico = rs.getString("villancico");
                c.letra = rs.getString("letra");
                c.pdfNovena = rs.getString("pdf_novena");
                c.fechaVisible = rs.getDate("fecha_visible");
                c.estado = rs.getInt("estado");
                lista.add(c);
            }

        } catch (Exception e) {
            System.out.println("Error listar disponibles: " + e.getMessage());
        }
        return lista;
    }

    // ============================================================
    // OBTENER 1 DÍA
    // ============================================================
    public Calendario obtener(int d) {

        try {
            Conexion cx = new Conexion();
            PreparedStatement ps = cx.getConexion().prepareStatement(
                "SELECT * FROM tb_calendario WHERE dia=?"
            );

            ps.setInt(1, d);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Calendario c = new Calendario();
                c.dia = rs.getInt("dia");
                c.frase = rs.getString("frase");
                c.audio = rs.getString("audio");
                c.imagen = rs.getString("imagen");
                c.villancico = rs.getString("villancico");
                c.letra = rs.getString("letra");
                c.pdfNovena = rs.getString("pdf_novena");
                c.fechaVisible = rs.getDate("fecha_visible");
                c.estado = rs.getInt("estado");
                return c;
            }

        } catch (Exception e) {
            System.out.println("Error obtener dia: " + e.getMessage());
        }

        return null;
    }

    // ============================================================
    // INSERTAR NUEVO DÍA
    // ============================================================
    public String insertar() {

        try {
            Conexion cx = new Conexion();
            PreparedStatement ps = cx.getConexion().prepareStatement(
                "INSERT INTO tb_calendario (dia, frase, audio, imagen, villancico, letra, pdf_novena, fecha_visible, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)"
            );

            ps.setInt(1, dia);
            ps.setString(2, frase);
            ps.setString(3, audio);
            ps.setString(4, imagen);
            ps.setString(5, villancico);
            ps.setString(6, letra);
            ps.setString(7, pdfNovena);
            ps.setDate(8, new java.sql.Date(fechaVisible.getTime()));

            return ps.executeUpdate() > 0 ? "Día registrado correctamente" : "Error al registrar";

        } catch (Exception e) {
            return "Error insertar: " + e.getMessage();
        }
    }

    // ============================================================
    // ACTUALIZAR
    // ============================================================
    public String actualizar() {

        try {
            Conexion cx = new Conexion();
            PreparedStatement ps = cx.getConexion().prepareStatement(
                "UPDATE tb_calendario SET frase=?, audio=?, imagen=?, villancico=?, letra=?, pdf_novena=?, fecha_visible=? WHERE dia=?"
            );

            ps.setString(1, frase);
            ps.setString(2, audio);
            ps.setString(3, imagen);
            ps.setString(4, villancico);
            ps.setString(5, letra);
            ps.setString(6, pdfNovena);
            ps.setDate(7, new java.sql.Date(fechaVisible.getTime()));
            ps.setInt(8, dia);

            return ps.executeUpdate() > 0 ? "Día actualizado" : "Error al actualizar";

        } catch (Exception e) {
            return "Error actualizar: " + e.getMessage();
        }
    }

    // ============================================================
    // CAMBIAR ESTADO (ACTIVO / INACTIVO)
    // ============================================================
    public String cambiarEstado(int d, int nuevoEstado) {

        try {
            Conexion cx = new Conexion();
            PreparedStatement ps = cx.getConexion().prepareStatement(
                "UPDATE tb_calendario SET estado=? WHERE dia=?"
            );

            ps.setInt(1, nuevoEstado);
            ps.setInt(2, d);

            return ps.executeUpdate() > 0 ? "Estado actualizado" : "Error al cambiar estado";

        } catch (Exception e) {
            return "Error estado: " + e.getMessage();
        }
    }
}
