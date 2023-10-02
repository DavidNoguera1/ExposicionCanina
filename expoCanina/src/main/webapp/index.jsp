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
<div class="container-fluid p-0">
    <img src="imagenes/banner.jpeg" class="img-fluid max-height-100" alt="Banner">
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Ordenamiento
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="SvPerro?ordenar=nombre">Nombre</a></li>
                        <li><a class="dropdown-item" href="SvPerro?ordenar=puntos">Puntos</a></li>
                        <li><a class="dropdown-item" href="SvPerro?ordenar=edad">Edad</a></li>
                    </ul>
                </li>
            </ul>
            <<form class="d-flex" action="searchPerro.jsp" method="GET">
                <input class="form-control me-2" type="search" name="nombre" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>



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
                            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#edicionModal" data-nombre="<%= perro.getNombre()%>"><i class="fas fa-pencil-alt"></i></a>
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


<-<!-- Tabla modal de edicion -->
<div class="modal fade" id="edicionModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Editar Perro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="SvPerro" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="accion" value="editar"> <!-- Agrega un campo oculto para identificar la acción -->
                    <input type="hidden" name="nombre_original" id="nombre_original"> <!-- Campo oculto para el nombre original del perro -->
                    <!-- Los campos de edición: raza, edad, imagen, puntos -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="raza_edit">Raza:</label>
                        <input type="text" name="raza_edit" id="raza_edit" class="form-control">
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="imagen_edit">Imagen:</label>
                        <input type="file" name="imagen_edit" class="form-control"  >
                    </div>
                    
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="puntos_edit">Puntos:</label>
                        <select name="puntos_edit" id="puntos_edit" class="form-select">
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
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="edad_edit">Edad:</label>
                        <input type="text" name="edad_edit" id="edad_edit" class="form-control">
                    </div>
                    <!-- Botón para guardar la edición -->
                    <input type="submit" value="Guardar Edición" class="btn btn-primary">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>




<script>
    // funcion para mostrar los datos en la ventana modal
    $('#exampleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Botón que desencadenó el evento
        var nombre = button.data('nombre'); // Obtén el nombre del perro

        // Realiza una solicitud AJAX al servlet para obtener los detalles del perro por su nombre
        $.ajax({
            url: 'SvPerro?nombre=' + nombre, // Cambia 'id' por el nombre del parámetro que esperas en tu servlet
            method: 'GET',
            success: function (data) {
                // Actualiza el contenido del modal con los detalles del perro
                $('#perro-details').html(data);
            },
            error: function () {
                // Maneja errores aquí si es necesario
                console.log('Error al cargar los detalles del perro.');
            }
        });
    });
</script>


<script>
    //Funcion ventana modal de edicion
    $('#edicionModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Botón que desencadenó el evento
        var nombre = button.data('nombre'); // Obtén el nombre del perro

        // Actualiza el campo oculto con el nombre original del perro
        $('#nombre_original').val(nombre);

        // Realiza una solicitud AJAX para obtener los detalles del perro por su nombre
        $.ajax({
            url: 'SvPerro?accion=editar&nombre=' + nombre, // Cambia 'id' por el nombre del parámetro que esperas en tu servlet
            method: 'GET',
            success: function (data) {
                // Analiza la respuesta JSON para obtener los datos del perro
                var perro = JSON.parse(data);

                // Actualiza los campos de edición con los datos del perro
                $('#raza_edit').val(perro.raza);
                $('#puntos_edit').val(perro.puntos);
                $('#edad_edit').val(perro.edad);

                // Actualiza aquí los otros campos de edición
                // ...
            },
            error: function () {
                // Maneja errores aquí si es necesario
                console.log('Error al cargar los detalles del perro.');
            }
        });
    });
</script>


<script>
    //Funcion que muestra una opcion Si/No para borrar el perro
    function confirmarEliminacion(nombre) {
        // Muestra un cuadro de diálogo de confirmación
        if (confirm("¿Está seguro de querer eliminar este perro?")) {
            // Si el usuario confirma, llama a la función eliminarPerro
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
                // Redirige a index.jsp después de eliminar el perro
                window.location.href = "index.jsp";
            }
        });
    }
</script>



<%@include file= "templates/fooder.jsp" %>