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
            } else if (ordenarCriterio.equals("raza")) {
                ExposicionPerros.ordenarYGuardarPerros(getServletContext(), "raza");
            }

            // Redirecciona nuevamente a la página desde donde se hizo la solicitud
            String referer = request.getHeader("Referer");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        // Obtener al perro con el mayor puntaje
        Perro perroMayorPuntaje = ExposicionPerros.obtenerPerroMayorPuntaje();

            // Obtener al perro con el menor puntaje
        Perro perroMenorPuntaje = ExposicionPerros.obtenerPerroMenorPuntaje();

        //Obtiene el perro con mayor edad del concurso
        Perro perroMasViejo = ExposicionPerros.obtenerPerroMasViejo();

        if (perroMayorPuntaje != null) {
            // Hacer algo con el perro encontrado, por ejemplo, mostrar sus detalles
            System.out.println("Perro con el mayor puntaje: " + perroMayorPuntaje.getNombre() + " - Puntos: " + perroMayorPuntaje.getPuntos());
        } else {
            // Manejar el caso en el que no haya perros en la lista
            System.out.println("No hay perros en la lista.");
        }

        if (perroMenorPuntaje != null) {
            // Hacer algo con el perro encontrado, por ejemplo, mostrar sus detalles
            System.out.println("Perro con el menor puntaje: " + perroMenorPuntaje.getNombre() + " - Puntos: " + perroMenorPuntaje.getPuntos());
        } else {
            // Manejar el caso en el que no haya perros en la lista
            System.out.println("No hay perros en la lista.");
        }

        if (perroMasViejo != null) {
            // Hacer algo con el perro encontrado, por ejemplo, mostrar sus detalles
            System.out.println("Perro con la mayor edad es: " + perroMasViejo.getNombre() + " - Edad: " + perroMasViejo.getEdad());
        } else {
            // Manejar el caso en el que no haya perros en la lista
            System.out.println("No hay perros en la lista.");
        }

        // Luego, puedes realizar las redirecciones aquí
        response.sendRedirect("ganador.jsp");
        response.sendRedirect("perdedor.jsp");
        response.sendRedirect("perroMasViejo.jsp");

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

        // Directorio donde se almacenara el archivo
        String uploadDirectory = getServletContext().getRealPath("imagenes");
        System.out.println("uploadDirectory: " + uploadDirectory);

        //Ruta completa del archivo
        String filePath = uploadDirectory + File.separator + fileName;
        System.out.println("filePath: " + filePath);

        //Guardar el archivo en el sistemaa de archivos
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

            // Verificar si el nombre ya existe en la lista
            boolean nombreExistente = false;
            for (Perro perro : misPerros) {
                if (perro.getNombre().equalsIgnoreCase(nombre)) { // IgnoreCase para ser insensible a mayúsculas y minúsculas
                    nombreExistente = true;
                    break;
                }
            }

            if (!nombreExistente) {
                // Crear un Perro solo si el nombre no existe en la lista
                Perro miPerro = new Perro(nombre, raza, imagen, puntos, edad);

                // Agregar el nuevo perro a la lista
                misPerros.add(miPerro);

                // Guardar la lista actualizada de perros en el archivo.ser
                ExposicionPerros.guardarPerro(misPerros, servletContext);
            } else {
                // Si el nombre ya existe, enviar un mensaje de texto plano al cliente
                response.setContentType("text/plain");
                response.getWriter().write("Ya existe un perro con ese nombre, empleamos los nombres como identificadores unicos ,"
                        + "por favor escoja otro nombre o un apodo que le permita identificar al Perro. Muchas Gracias");
                return; // Detener la ejecución adicional
            }

            // Agregar la lista de perros al objeto de solicitud
            request.setAttribute("misPerros", misPerros);

            // Redireccionar a la página web agregarPerro
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
