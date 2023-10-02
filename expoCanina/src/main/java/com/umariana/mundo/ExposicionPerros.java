package com.umariana.mundo;

import com.umariana.mundo.Perro;
import java.io.*;
import java.util.ArrayList;
import java.util.Comparator;
import javax.servlet.ServletContext;

public class ExposicionPerros {

    // Creamos la lista darPerros y la definimos 
    // La definimos como "sttatic" para que este disponible en el todo el programa
    public static ArrayList<Perro> darPerros = new ArrayList<>();

    // Método para guardar la lista de perros en un archivo perros.ser
    public static void guardarPerro(ArrayList<Perro> perros, ServletContext context) throws IOException {

        //Definimos una ruta para buscar nuestro archivo perro.ser
        String relativePath = "/data/perros.ser";
        String absPath = context.getRealPath(relativePath);
        File archivo = new File(absPath);

        try {
            // Crear un archivo para guardar la lista de perros serializada
            FileOutputStream fos = new FileOutputStream(archivo);
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(perros);
            oos.close();
            System.out.println("Datos de perros guardados exitosamente en: perros.ser");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error al guardar los datos de perro: " + e.getMessage());
        }
    }

    // Método para cargar los perros desde el archivo deserializándolo
    public static ArrayList<Perro> cargarPerros(ServletContext context) throws IOException, ClassNotFoundException {

        //Reutilizamos la ruta previamente definida para perro.ser
        String relativePath = "/data/perros.ser";
        String absPath = context.getRealPath(relativePath);
        File archivo = new File(absPath);

        try {
            // Cargar la lista de perros desde el archivo
            FileInputStream fis = new FileInputStream(archivo);
            ObjectInputStream ois = new ObjectInputStream(fis);
            darPerros = (ArrayList<Perro>) ois.readObject();
            ois.close();
            System.out.println("Datos de perros cargados exitosamente desde: perros.ser");
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Error al cargar los datos de perros: " + e.getMessage());
        }
        return darPerros;
    }

    //Metodo para buscar un perro por nombre de lista
    public static Perro buscarPerroPorNombre(String nombre) {
        for (Perro perro : darPerros) {
            if (perro.getNombre().equals(nombre)) {
                return perro; // Retorna  el perro si se encuentra
            }
        }
        return null; // Retorna null si no se encuentra el perro
    }

    //Metodo para eliminar un perro del array
    public static void eliminarPerro(String nombre) {
        Perro perroAEliminar = null;

        //Busca al perro dentro del array existente
        for (Perro perro : darPerros) {
            if (perro.getNombre().equals(nombre)) {
                perroAEliminar = perro;
                break;
            }
        }

        //Si se encuentra al Perro se lo elimina del array
        if (perroAEliminar != null) {
            darPerros.remove(perroAEliminar);
        }
    }

    //Metodo para ordenar perros por puntos de mayor a menor
    public static void ordenarPorPuntos() {
        darPerros.sort(Comparator.comparingInt(Perro::getPuntos).reversed());
    }

    //Metodo para ordenar perros por Edad de mayor a menor
    public static void ordenarPorEdad() {
        darPerros.sort(Comparator.comparingInt(Perro::getEdad).reversed());
    }

    //Metodo para ordenar perros por Nombre alfabeticamente
    public static void ordenarPorNombre() {
        darPerros.sort(Comparator.comparing(Perro::getNombre));
    }

    //Metodo empleado para ordenar y guardar solo cuando se emplee una de las anteriores opciones
    public static void ordenarYGuardarPerros(ServletContext context, String criterio) throws IOException {
        if (criterio.equals("puntos")) {
            ordenarPorPuntos();
        } else if (criterio.equals("edad")) {
            ordenarPorEdad();
        } else if (criterio.equals("nombre")) {
            ordenarPorNombre();
        }

        guardarPerro(darPerros, context);
    }

    //Metodo para obetner el perro con mayor puntaje
    public static Perro obtenerPerroMayorPuntaje() {
        if (darPerros.isEmpty()) {
            return null; // Retorna null si la lista está vacía
        }

        Perro perroMayorPuntaje = darPerros.get(0); // Suponemos que el primer perro tiene el puntaje máximo

        for (Perro perro : darPerros) {
            if (perro.getPuntos() > perroMayorPuntaje.getPuntos()) {
                perroMayorPuntaje = perro; // Si encontramos un perro con un puntaje mayor, actualizamos el perro mayor
            }
        }

        return perroMayorPuntaje;
    }

    //Metodo para obtener el perro con menor Puntaje
    public static Perro obtenerPerroMenorPuntaje() {
        if (darPerros.isEmpty()) {
            return null; // Retorna null si la lista está vacía
        }

        Perro perroMenorPuntaje = darPerros.get(0); // Suponemos que el primer perro tiene el puntaje mínimo

        for (Perro perro : darPerros) {
            if (perro.getPuntos() < perroMenorPuntaje.getPuntos()) {
                perroMenorPuntaje = perro; // Si encontramos un perro con un puntaje menor, actualizamos el perro con el menor puntaje
            }
        }

        return perroMenorPuntaje;
    }

    //Metodo para obetner el perro con mayor puntaje
    public static Perro obtenerPerroMasViejo() {
        if (darPerros.isEmpty()) {
            return null; // Retorna null si la lista está vacía
        }

        Perro perroMasViejo = darPerros.get(0); // Suponemos que el primer perro es el más viejo

        for (Perro perro : darPerros) {
            if (perro.getEdad() > perroMasViejo.getEdad()) {
                perroMasViejo = perro; // Si encontramos un perro más viejo, actualizamos el perro más viejo
            }
        }

        return perroMasViejo;
    }

}
