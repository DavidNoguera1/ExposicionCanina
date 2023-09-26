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
<nav class="navbar navbar-light bg-light">
  <a class="navbar-brand" href="#">
        <img src="imagenes/banner.jpeg" class="img-fluid max-height-100" alt="Banner">    
  </a>
</nav>
        <div class="container p-4"> <!-- clase contenedora -->
            <div class="row">
            <div class="col-md-4">  <!-- clase division por 4 columnas -->
                <div class="card card-body"> 
                    <!-- tarjeta de trabajo -->
                    <h3>Insertar nuevo perro</h3>
                  <form action="SvPerro" method="POST">         
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
                      <input type="text" name="imagen" class="form-control"  >
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
                      <input type="submit" value="Agregar perro" class ="form-control"</>
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
                                <td><%= perro.getNombre() %></td>
                                <td><%= perro.getRaza() %></td>
                                <td><%= perro.getImagen() %></td>
                                <td><%= perro.getPuntos() %></td>
                                <td><%= perro.getEdad() %></td>
                                <td>
                                <!-- Agrega íconos FontAwesome para vista, editar y borrar -->
                                <i class="fas fa-eye"></i> <!-- Icono para vista -->
                                <i class="fas fa-pencil-alt"></i> <!-- Icono para editar -->
                                <i class="fas fa-trash-alt"></i> <!-- Icono para borrar -->

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
        

        
        
        
               
 <%@include file= "templates/fooder.jsp" %>