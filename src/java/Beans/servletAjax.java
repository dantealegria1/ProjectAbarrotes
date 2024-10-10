/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Thor
 */
public class servletAjax extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public String getServletInfo() {
        return "Short description";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection conexion = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost", "root", "");
            Statement stmt = conexion.createStatement();
            ResultSet resultado = stmt.executeQuery("SELECT * FROM producto "
                    + "WHERE Nombre_producto LIKE '" + request.getParameter("Nombre_producto").toUpperCase() + "%'");
            out.println("<table border=\"1\">");
            while (resultado.next()) {
                out.println("<tr>");
                out.println("<td>ID: " + resultado.getInt("id_producto") + "</td>");
                out.println("<td>Nombre: " + resultado.getString("Nombre_producto") + "</td>");
                out.println("<td>Presentacion: " + resultado.getString("Presentacion") + "</td>");
                out.println("<td>Caducidad: " + resultado.getString("Caducidad") + "</td>");
                out.println("<td>Precio: " + resultado.getString("Precio_uni") + "</td>");
                out.println("<td>Existencias: " + resultado.getString("Existencias") + "</td>");
                out.println("<td>Marca: " + resultado.getString("marca") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } catch (SQLException e) {
            System.out.println("Error de MySQL: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Error inesperado: " + e.getMessage());
        }


    }
}
