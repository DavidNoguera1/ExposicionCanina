<%-- 
    Document   : perroMasViejo
    Created on : 2/10/2023, 8:59:55 a. m.
    Author     : David Noguera
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.umariana.mundo.ExposicionPerros"%>
<%@page import="com.umariana.mundo.Perro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@include file="templates/header.jsp"%>

    <style>
        /* Estilo para reducir el tamaño del container */
        .custom-container {
            max-width: 600px; /* Ajusta el tamaño según tus necesidades */
            margin: 0 auto; /* Centra el container en la página horizontalmente */
            background-color: black; /* Color de fondo negro/gris para el contenedor */
            color: white; /* Texto en color blanco dentro del contenedor */
            padding: 20px; /* Espaciado interior del contenedor */
            border-radius: 10px; /* Bordes redondeados del contenedor */
            margin-top: 30px; /* Espaciado superior para evitar la barra de navegación */
        }
        /* Estilo para reducir el tamaño de la imagen */
        .custom-card-img {
            max-width: 500px; /* Ajusta el tamaño según tus necesidades */
            margin: 0 auto; /* Centra la imagen en la tarjeta */
        }
    </style>
      
    <div>
        
    </div>
    <div class="container custom-container">
        <%
            // Obtener al perro con el mayor puntaje
            com.umariana.mundo.Perro perroMasViejo = com.umariana.mundo.ExposicionPerros.obtenerPerroMasViejo();

            if (perroMasViejo != null) {
        %>
        <h1 class="mt-4">El perro con mayor edad del concurso es: <%= perroMasViejo.getNombre() %></h1>
        <div class="mt-4">
            <div class="card">
                <img src="imagenes/<%= perroMasViejo.getImagen() %>" class="card-img-top custom-card-img" alt="<%= perroMasViejo.getNombre() %>">
                <div class="card-body">
                    <p class="card-text">Raza: <%= perroMasViejo.getRaza() %></p>
                    <p class="card-text">Puntos: <%= perroMasViejo.getPuntos() %></p>
                    <p class="card-text">Edad (meses): <%= perroMasViejo.getEdad() %></p>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="alert alert-warning mt-4" role="alert">
                No hay perros en la lista o aún no se ha definido un ganador.
            </div>
            <%
                }
            %>
        </div>
        <a href="index.jsp" class="btn btn-primary mt-4">Volver a la lista completa</a>
    </div>


<%@include file="templates/fooder.jsp"%>