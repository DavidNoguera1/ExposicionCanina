<%-- 
    Document   : searchPerro
    Created on : 1/10/2023, 10:39:45 a. m.
    Author     : David Noguera
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.umariana.mundo.ExposicionPerros"%>
<%@page import="com.umariana.mundo.Perro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@include file="templates/header.jsp"%>


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
                        Dropdown
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <%
                            String ordenarPor = request.getParameter("ordenar");
                            if (ordenarPor != null) {
                                ExposicionPerros.ordenarYGuardarPerros(getServletContext(), ordenarPor);
                            }
                        %>
                        <li><a class="dropdown-item" href="searchPerro.jsp?ordenar=nombre">Nombre</a></li>
                        <li><a class="dropdown-item" href="searchPerro.jsp?ordenar=puntos">Puntos</a></li>
                        <li><a class="dropdown-item" href="searchPerro.jsp?ordenar=edad">Edad</a></li>
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
        <!-- Copia el formulario de inserción de perros aquí -->
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


                <a href="index.jsp">Volver a la lista </a> 
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
                        // Obtener el perro buscado por su nombre desde el parámetro "nombre" en la solicitud
                        String nombreBuscado = request.getParameter("nombre");
                        // Obtener el array list de la solicitud utilizando el método buscarPerroPorNombre
                        Perro perroBuscado = ExposicionPerros.buscarPerroPorNombre(nombreBuscado);

                        // Si se encontró un perro con ese nombre, muéstralo en la tabla
                        if (perroBuscado != null) {
                    %>
                    <tr>
                        <td><%= perroBuscado.getNombre()%></td>
                        <td><%= perroBuscado.getRaza()%></td>
                        <td><%= perroBuscado.getImagen()%></td>
                        <td><%= perroBuscado.getPuntos()%></td>
                        <td><%= perroBuscado.getEdad()%></td>
                        <td>
                            <!-- Agrega íconos FontAwesome para vista, editar y borrar -->
                            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-nombre="<%= perroBuscado.getNombre()%>"><i class="fas fa-eye"></i></a> <!-- Icono para vista -->
                            <i class="fas fa-pencil-alt"></i> <!-- Icono para editar -->
                            <a href="#" class="btn btn-danger" onclick="confirmarEliminacion('<%= perroBuscado.getNombre()%>');"><i class="fas fa-trash-alt"></i></a>
                        </td>
                    </tr>
                    <%
                    } else {
                        // Si no se encontró el perro, muestra un mensaje
                    %>
                    <tr>
                        <td colspan="6">Perro no encontrado</td>
                    </tr>
                    <%
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

<script>
    //Funcion que muestra una opcion Si/No para borrar el perro
    function confirmarEliminacion(nombre) {
        // Muestra un cuadro de diálogo de confirmación
        var confirmacion = confirm("¿Está seguro de querer eliminar este perro?");
        if (confirmacion) {
            // Si el usuario confirma, llama a la función eliminarPerro
            eliminarPerro(nombre);
        } else {
            // Si el usuario cancela, no hace nada y se queda en la página
        }
    }
</script>

<%@include file="templates/fooder.jsp"%>

