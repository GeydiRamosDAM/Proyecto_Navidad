<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insertar Nuevo Libro</title>
 <link rel="stylesheet" href="../css/estilo.css">
</head>
<body>

	<header>
		<h3>Insertar Nuevo Libro</h3>
	</header>
	
<main>

<%@ page import="java.sql.*" %>
	
	<form action="../index.jsp" method="POST">
	  <ul>
	    <li>
	      <label for="titulo">Título del Libro:</label>
	      <input type="text" name="libro_nombre" />
	    </li>
	    <li>
	      <label for="genero">Género:</label>
   
	      <select name="ID_generoInsertar" required>
  
    		     <% 
    		     
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 Connection conexion =null;
                 try{
                    String url = "jdbc:mysql://127.0.0.1/libros_para_todos";
                    String usuario= "proyecto_libros";
                    String contrasena = "proyecto_libros";
                    conexion = DriverManager.getConnection(url,usuario,contrasena);
                    Statement peticion3 = conexion.createStatement();
                    ResultSet list_generos = peticion3.executeQuery("SELECT * FROM genero");
       
                 //construyendo lista de opciones en el select   
       		     while(list_generos.next()){
     		    	 out.println(""+
       		     			"<option value=" + list_generos.getString("ID_Genero") + ">" + list_generos.getString("Clasificacion") +" </option>" +
       		    			 "");
       		     }
                    
                    
                 }catch(Exception e){
                    e.printStackTrace();
                 }finally{
                    if(conexion !=null){
                    conexion.close();
                 }
                 }    		     
    		     

    		    %>
      </select>
	      
	      
	      
	    </li>
	   <li>
	      <label for="autor">Autor:</label>
	      <input type="text" id="autor" name="libro_autor" />
	   </li>
	   <li>
	      <label for="aPublicacion">Año de Publicación:</label>
	      <input type="number" id="aPublicacion" name="libro_aPublicacion" />
	   </li>
	      
	      <li class="button">
	  		<button type="submit">Insertar</button>
		 </li>
	 
	    
	  </ul>
	
	</form>

</main>

</body>
</html>