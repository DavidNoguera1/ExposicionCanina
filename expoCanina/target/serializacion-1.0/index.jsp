<%-- 
    Document   : agregarPerro
    Created on : 20/09/2023, 4:50:03 p. m.
    Author     : Sistemas (Grupo Portilla, Noguera y Bolaños)
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.umariana.mundo.ExposicionPerros"%>
<%@page import="com.umariana.mundo.Perro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@include file= "templates/header.jsp" %>


<!-- Empleamos una NavBar de Bootstrap para evitar interferencias de la imagen -->


<div class="container p-4"> <!-- clase contenedora -->
    <div class="row">
        <div class="col-md-4">  <!-- clase division por 4 columnas -->
            <div class="card card-body"> 
                <!-- tarjeta de trabajo -->
                <h3>Insertar nuevo perro</h3>
                <!-- Enctype sirve para subir archivos-->
                <form action="SvPerro" method="POST" enctype="multipart/form-data" > 
                    <!-- Input para el nombre-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="nombre">Nombre:</label>
                        <input type="text" name ="nombre" class="form-control">
                    </div>                                            
                    <!-- Input para la raza-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="raza">Raza:</label>
                        <input type="text" name="raza" class="form-control">
                    </div>
                    <!-- Input para la foto-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="imagen">Imagen:</label>
                        <input type="file" name="imagen" class="form-control"  >
                    </div>
                    <!-- Input para los puntos-->                   
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="puntos">Puntos:</label>
                        <select name="puntos" class="form-select" >
                            <option selected>Selecione...</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>                          
                        </select>                  
                    </div>
                    <!-- Input para la edad-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="edad">Edad:</label>
                        <input type="text" name="edad"  class="form-control"   >
                    </div>
                    <!-- Boton para agregar perros --> 
                    <input type="submit" value="Agregar perro" class ="form-control"/>
                </form><br>


                <a href="index.jsp">Volver al Menu</a> 
            </div>    
        </div> 
        <!-- Tabla de datos -->


        <div class="col-md-8">
            <table class="table table-bordered table-dark">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Raza</th>
                        <th>Imagen</th>
                        <th>Puntos</th>
                        <th>Edad</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Obtener array list de la solicitud utilizando el método cargarPerros
                        ServletContext context = request.getServletContext();
                        ArrayList<Perro> darPerros = ExposicionPerros.cargarPerros(context);

                        // Recorrido de la lista y asignacion de los datos en las casillas
                        if (darPerros != null) {
                            for (Perro perro : darPerros) {
                    %>
                    <tr>
                        <td><%= perro.getNombre()%></td>
                        <td><%= perro.getRaza()%></td>
                        <td><%= perro.getImagen()%></td>
                        <td><%= perro.getPuntos()%></td>
                        <td><%= perro.getEdad()%></td>
                        <td>
                            <!-- Agrega íconos FontAwesome para vista, editar y borrar -->
                            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-nombre="<%= perro.getNombre()%>"><i class="fas fa-eye"></i></a> <!-- Icono para vista -->
                            <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editarModal"
                               data-nombre="<%= perro.getNombre() %>"
                               data-raza="<%= perro.getRaza() %>"
                               data-imagen="<%= perro.getImagen() %>"
                               data-puntos="<%= perro.getPuntos() %>"
                               data-edad="<%= perro.getEdad() %>">
                                <i class="fas fa-pencil-alt"></i>
                            </a>

                            <a href="index.jsp" class="btn btn-danger" onclick="confirmarEliminacion('<%= perro.getNombre()%>');"><i class="fas fa-trash-alt"></i></a>

                        </td>

                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody> 
            </table>
        </div>
    </div>  
</div>    

<!-- ventana Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Detalles del Perro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="perro-details">
                    <!-- Aqui se mostraran los detalles del perro -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>



<!-- Ventana Modal para Editar -->
<div class="modal fade" id="editarModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Editar Perro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="SvEditarPerro" method="POST" enctype="multipart/form-data">
                    <!-- Campo oculto para almacenar el nombre del perro -->
                    <input type="hidden" name="perro-edit-nombre" id="perro-edit-nombre" value="">


                    <!-- Input para la raza con el valor actual del perro -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="raza">Raza:</label>
                        <input type="text" name="raza" id="editar-raza" class="form-control">
                    </div>
                    <!-- Input para la foto (imagen actual del perro) -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="imagen">Imagen:</label>
                        <input type="file" name="imagen" class="form-control" id="imagen-perro-editar">
                    </div>
                    <!-- Input para los puntos con el valor actual del perro -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="puntos">Puntos:</label>
                        <select name="puntos" class="form-select" id="editar-puntos">
                            <option selected>Seleccione...</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>  
                            <!-- Agrega todas las opciones necesarias aqu? -->
                        </select>
                    </div>
                    <!-- Input para la edad con el valor actual del perro -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="edad">Edad:</label>
                        <input type="text" name="edad" id="editar-edad" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<script>
    $('#editarModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Bot?n que desencaden? el evento
        var nombre = button.data('nombre'); // Obt�n el nombre del perro
        var raza = button.data('raza'); // Obt?n la raza del perro
        var imagen = button.data('imagen'); // Obt?n la imagen del perro
        var puntos = button.data('puntos'); // Obt?n los puntos del perro
        var edad = button.data('edad'); // Obt?n la edad del perro

        // Rellena los campos del formulario con los datos del perro
        $('#perro-edit-nombre').val(nombre);
        $('#editar-raza').val(raza);
        $('#editar-puntos').val(puntos);
        $('#editar-edad').val(edad);
        // Rellena otros campos del formulario de la misma manera

        // Actualiza la imagen del perro en el formulario (si lo deseas)
        // Esto es opcional y depende de c?mo quieras mostrar la imagen

        $('#imagen-perro-editar').attr('src', './imagenes/' + imagen);
    });
</script>



<script>
    $(document).ready(function () {
        $('.edit-button').click(function () {
            var nombrePerro = $(this).data('nombre');
            $('#perro-edit-nombre').val(nombrePerro);
        });
    });
</script>


<script>


    // funcion para mostrar los datos en la ventana modal
    $('#exampleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Bot?n que desencaden? el evento
        var nombre = button.data('nombre'); // Obt?n el nombre del perro

        // Realiza una solicitud AJAX al servlet para obtener los detalles del perro por su nombre
        $.ajax({
            url: 'SvPerro?nombre=' + nombre, // Cambia 'id' por el nombre del par?metro que esperas en tu servlet
            method: 'GET',
            success: function (data) {
                // Actualiza el contenido del modal con los detalles del perro
                $('#perro-details').html(data);
            },
            error: function () {
                // Maneja errores aqu? si es necesario
                console.log('Error al cargar los detalles del perro.');
            }
        });
    });




</script>

<script>
    //Funcion que muestra una opcion Si/No para borrar el perro
    function confirmarEliminacion(nombre) {
        // Muestra un cuadro de di?logo de confirmaci?n
        if (confirm("?Est? seguro de querer eliminar este perro?")) {
            // Si el usuario confirma, llama a la funci?n eliminarPerro
            eliminarPerro(nombre);
        }
    }
</script>

<script>
    //Funcion para eliminar un perro de la tabla
    function eliminarPerro(nombre) {
        // Realiza una solicitud AJAX para eliminar el perro
        $.ajax({
            type: "GET",
            url: "SvPerro?eliminarNombre=" + nombre,
            success: function (response) {
                // Redirige a index.jsp despu?s de eliminar el perro
                window.location.href = "index.jsp";
            }
        });
    }
</script>



<%@include file= "templates/fooder.jsp" %>