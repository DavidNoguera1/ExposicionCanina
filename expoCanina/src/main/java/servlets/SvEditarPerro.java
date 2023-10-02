package servlets;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.umariana.mundo.Perro;
import com.umariana.mundo.ExposicionPerros;
import static com.umariana.mundo.ExposicionPerros.darPerros;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author PC
 */
@WebServlet(name = "SvEditarPerro", urlPatterns = {"/SvEditarPerro"})
@MultipartConfig
public class SvEditarPerro extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el nombre del perro a editar desde el campo oculto
        String nombrePerroEditar = request.getParameter("perro-edit-nombre");

        // Obtener la parte del archivo (imagen)
        Part imagenPart = request.getPart("imagen");
        System.out.println("imagenPart: " + imagenPart);

        // Nombre original del archivo
        String fileName = imagenPart.getSubmittedFileName();
        System.out.println("fileName: " + fileName);

        // Directorio donde se almacenará el archivo
        String uploadDirectory = getServletContext().getRealPath("imagenes");
        System.out.println("uploadDirectory: " + uploadDirectory);

        // Ruta completa del archivo
        String filePath = uploadDirectory + File.separator + fileName;
        System.out.println("filePath: " + filePath);

        // Guardar el archivo en el sistema de archivos
        try (InputStream input = imagenPart.getInputStream(); OutputStream output = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = input.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
        }

        // Obtener los nuevos valores de los campos del formulario de edición
        String raza = request.getParameter("raza");
        String imagen = fileName;
        String puntosStr = request.getParameter("puntos");
        String edadStr = request.getParameter("edad");

        // Try-Catch para manejar la conversión de puntos y edad a enteros
        try {
            int puntos = Integer.parseInt(puntosStr);
            int edad = Integer.parseInt(edadStr);

            // Obtener la lista actual de perros
            ServletContext servletContext = getServletContext();
            ArrayList<Perro> misPerros = ExposicionPerros.cargarPerros(servletContext);

            // Buscar el perro en la lista por nombre
            Perro perroAEditar = null;
            for (Perro perro : misPerros) {
                if (perro.getNombre().equals(nombrePerroEditar)) {
                    perroAEditar = perro;
                    break;
                }
            }

            if (perroAEditar != null) {
                // Actualizar los campos del perro con los nuevos valores
                perroAEditar.setRaza(raza);
                perroAEditar.setImagen(imagen);
                perroAEditar.setPuntos(puntos);
                perroAEditar.setEdad(edad);

                // Guardar la lista de perros actualizada en el archivo
                ExposicionPerros.guardarPerro(misPerros, servletContext);

                // Redireccionar al usuario a index.jsp
                response.sendRedirect("index.jsp");
            } else {
                // Manejar el caso en el que no se encuentra el perro
                response.setContentType("text/plain");
                response.getWriter().write("Perro no encontrado");
            }
        } catch (NumberFormatException e) {
            // Manejo de la excepción si los valores de puntos o edad no son números válidos
            e.printStackTrace();
            System.out.println("Error al convertir puntos o edad a entero: " + e.getMessage());
            // Aquí puedes redirigir al usuario a una página de error o mostrar un mensaje de error
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SvEditarPerro.class.getName()).log(Level.SEVERE, null, ex);
            // Manejo de excepción si ocurre un error al cargar la lista de perros
            // Aquí puedes redirigir al usuario a una página de error o mostrar un mensaje de error
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
