<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exposicion Canina</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="scripts/script.js" type="text/javascript"></script>

    </head>
    <body>

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
                            <a class="nav-link active" aria-current="page" href="index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="ganador.jsp">Ganador</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="perdedor.jsp">Perdedor</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="perroMasViejo.jsp">Perro mas viejo</a>
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
                        <input class="form-control me-2" type="search" name="nombre" placeholder="De el nombre de perro" aria-label="Search">
                        <button class="btn btn-outline-success" type="submit">Buscar</button>
                    </form>
                </div>
            </div>
        </nav>
