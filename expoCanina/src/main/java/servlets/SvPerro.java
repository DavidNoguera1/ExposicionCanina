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
import static com.umariana.mundo.ExposicionPerros.buscarPerroPorNombre;
import static com.umariana.mundo.ExposicionPerros.darPerros;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@WebServlet(name = "SvPerro", urlPatterns = {"/SvPerro"})
@MultipartConfig
public class SvPerro extends HttpServlet {

    public void init() throws ServletException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");

        // Verifica si se ha proporcionado un nombre de perro en la solicitud
        if (nombre != null && !nombre.isEmpty()) {
            Perro perro = buscarPerroPorNombre(nombre); // Implementa la lógica para buscar el perro en tu lista de perros
            if (perro != null) {
                // Genera la respuesta HTML con los detalles del perro encontrado
                String perroHtml = "<h2>Nombre: " + perro.getNombre() + "</h2>"
                        + "<p>Raza: " + perro.getRaza() + "</p>"
                        + "<p>Puntos: " + perro.getPuntos() + "</p>"
                        + "<p>Edad (meses): " + perro.getEdad() + "</p>"
                        + "<img src='imagenes/" + perro.getImagen() + "' alt='" + perro.getNombre() + "' width='100%'/>";
                response.setContentType("text/html");
                response.getWriter().write(perroHtml);
                return; // Finaliza la ejecución del servlet después de mostrar los detalles del perro
            } else {
                // Maneja el caso en el que no se encuentra el perro
                // Maneja el caso en el que no se encuentra el perro
                response.setContentType("text/plain");
                response.getWriter().write("Perro no encontrado");
            }
        }

        //Eliminacion de un perro de la tabla
        String nombrePerroAEliminar = request.getParameter("eliminarNombre");
        ExposicionPerros.eliminarPerro(nombrePerroAEliminar);

        // Guarda la lista actualizada de perros en el archivo.ser
        ServletContext servletContext = getServletContext();
        ExposicionPerros.guardarPerro(ExposicionPerros.darPerros, servletContext);

        //Ordenamiento de los perrso segun la opcion
        String ordenarCriterio = request.getParameter("ordenar");

        if (ordenarCriterio != null) {
            // Verifica el criterio seleccionado y llama a ordenarYGuardarPerros
            if (ordenarCriterio.equals("nombre")) {
                ExposicionPerros.ordenarYGuardarPerros(getServletContext(), "nombre");
            } else if (ordenarCriterio.equals("puntos")) {
                ExposicionPerros.ordenarYGuardarPerros(getServletContext(), "puntos");
            } else if (ordenarCriterio.equals("edad")) {
                ExposicionPerros.ordenarYGuardarPerros(getServletContext(), "edad");
            }

            // Redirecciona nuevamente a la página desde donde se hizo la solicitud
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "index.jsp");
            return;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener la parte del archivo      
        Part imagenPart = request.getPart("imagen");
        System.out.println("imagenPart" + imagenPart);

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

        // Obtener los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String raza = request.getParameter("raza");
        String imagen = fileName;
        String puntosStr = request.getParameter("puntos");
        String edadStr = request.getParameter("edad");

        // Try n Catch para los datos además de un casteo para puntos y edad
        try {
            int puntos = Integer.parseInt(puntosStr);
            int edad = Integer.parseInt(edadStr);

            // Obtener la lista actual de perros
            ServletContext servletContext = getServletContext();
            ArrayList<Perro> misPerros = ExposicionPerros.cargarPerros(servletContext);

            // Verificar si se proporciona un nombre válido (esto podría variar según tu lógica de negocio)
            if (nombre != null && !nombre.isEmpty()) {
                // Intentar encontrar el perro existente por nombre
                Perro perroExistente = ExposicionPerros.buscarPerroPorNombre(nombre);
                if (perroExistente != null) {
                    // Editar el perro existente con los nuevos datos
                    perroExistente.setRaza(raza);
                    perroExistente.setImagen(imagen);
                    perroExistente.setPuntos(puntos);
                    perroExistente.setEdad(edad);

                    // Guardar la lista actualizada de perros en el archivo.ser
                    ExposicionPerros.guardarPerro(misPerros, servletContext);

                    // Redireccionar a la página web index.jsp u otra página según tu lógica
                    response.sendRedirect("index.jsp");
                    return;
                } else {
                    // Manejar el caso en el que no se encuentra el perro a editar
                    response.setContentType("text/plain");
                    response.getWriter().write("Perro no encontrado para editar");
                }
            } else {
                // Crear un Perro si no se proporcionó un nombre válido (esto podría variar según tu lógica de negocio)
                Perro miPerro = new Perro(nombre, raza, imagen, puntos, edad);

                // Agregar el nuevo perro a la lista
                misPerros.add(miPerro);

                // Guardar la lista actualizada de perros en el archivo.ser
                ExposicionPerros.guardarPerro(misPerros, servletContext);

                // Agregar la lista de perros al objeto de solicitud
                request.setAttribute("misPerros", misPerros);

                // Redireccionar a la página web index.jsp u otra página según tu lógica
                response.sendRedirect("index.jsp");
            }
        } catch (NumberFormatException e) {
            // Manejo de la excepción si los valores de puntos o edad no son números válidos
            e.printStackTrace();
            System.out.println("Error al convertir puntos o edad a entero: " + e.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SvPerro.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
