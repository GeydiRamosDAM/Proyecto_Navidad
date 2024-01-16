<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LIBROS DISPONIBLES</title>
        <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
	<header>
		<h3>LIBROS DISPONIBLES</h3>
	</header>
	<main>
		<%@ page import="java.sql.*" %>
	
	<%
				Class.forName("com.mysql.cj.jdbc.Driver");
			    Connection conexion2 =null;		
                Connection conexion3 =null;
	
                if(request.getParameter("libro_nombre")!=null)
    			{
					
	               //INSERTAR REGISTROS DE LIBROS EN LA BBDD
                	try{
	                   String url = "jdbc:mysql://127.0.0.1/libros_para_todos";
	                   String usuario= "proyecto_libros";
	                   String contrasena = "proyecto_libros";
	                   conexion2 = DriverManager.getConnection(url,usuario,contrasena);
	             
	                    Statement peticion2 = conexion2.createStatement();
	                    ResultSet generos2 = peticion2.executeQuery("SELECT * FROM genero");

	                    int ID_generoLibroInsertar = Integer.parseInt(request.getParameter("ID_generoInsertar"));
	                    
	                   
	                   String peticionInsercion = "INSERT INTO libros VALUES (null, '" + ID_generoLibroInsertar + "','" + request.getParameter("libro_nombre") + "','" + request.getParameter("libro_autor") +
	                   			"','" + request.getParameter("libro_aPublicacion") + "')";
	                   
	                   PreparedStatement inserto = conexion2.prepareStatement(peticionInsercion);
	                   inserto.executeUpdate();
	                
	                }catch(Exception e){
	                   e.printStackTrace();
	                }finally{
	                   if(conexion2 !=null){
	                   conexion2.close();
	                	}
	                }
			    }
                else if(request.getParameter("libro_nombreModificar")!=null)
                {
                	             	
                	//MODIFICAR LOS REGISTROS 
                	//PREPARO LA CONEXION PARA INSERTAR LOS REGISTROS
                	try{
 	                   String url = "jdbc:mysql://127.0.0.1/libros_para_todos";
 	                   String usuario= "proyecto_libros";
 	                   String contrasena = "proyecto_libros";
 	                   conexion3 = DriverManager.getConnection(url,usuario,contrasena);
 	             
 	                   int ID_generoLibroModficar = Integer.parseInt(request.getParameter("ID_generoModificar"));
 	                   
//SIGUIENTE CODIGO REALIZO UNA PETICION PARA QUE EL SISTEMA ME TRAIGA LOS DATOS GUARDADOS PARA SU MODIFICACION
 	                 
 	                   String peticionUpdate = 
 	                		    "UPDATE libros" + " " +
 	                   		    "SET" + " " +
 	                   			"ID_Genero ="  + ID_generoLibroModficar + ", " + 
 	                   			"Titulo ='"  + request.getParameter("libro_nombreModificar") + "', " + 
 	                   			"Autor ='"  + request.getParameter("libro_autor") + "', " +  
 	                   			"A_Publicacion ="  + request.getParameter("libro_aPublicacion") + " " + 

							   "WHERE ID_Libros =" + request.getParameter("idLibroMOdificar");
 	                   
 	                   PreparedStatement update = conexion3.prepareStatement(peticionUpdate);
 	                   update.executeUpdate();
 	                
 	                }catch(Exception e){
 	                   e.printStackTrace();
 	                }finally{
 	                   if(conexion3 !=null){
 	                	  conexion3.close();
 	                	}
 	                }
                 }
                
	
		%>
	
		<table border=1>
		<thead>
		<tr>
			<th>Título</th>
			<th>ID Libro</th>
			<th>Género</th>
			<th>Autor</th>
			<th>Año de Publicación</th>
		</tr>
		</thead>	
             <%
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 Connection conexion =null;
                 try{
                    String url = "jdbc:mysql://127.0.0.1/libros_para_todos";
                    String usuario= "proyecto_libros";
                    String contrasena = "proyecto_libros";
                    conexion = DriverManager.getConnection(url,usuario,contrasena);
                    Statement peticion1 = conexion.createStatement();
                    Statement peticion3 = conexion.createStatement();
                    ResultSet libros = peticion1.executeQuery("SELECT * FROM libros");
                    
                    String genero2 = "";
                    
                    while(libros.next()){
                    	
                    	//encontrar el valor de género dado su ID
                    	ResultSet generos2 = peticion3.executeQuery("SELECT * FROM genero");
                    	while (generos2.next()){
                    		if(generos2.getInt("ID_Genero") == libros.getInt("ID_Genero")){
                    			genero2 = generos2.getString("Clasificacion");
                     			break;
							}
                    	}
                    	
                    	//pintar valores de la tabla		
                    	out.println(""+
                        "<tr>"+
                        	"<td>"+libros.getString("Titulo")+"</td>"+
                            "<td>"+libros.getString("ID_Libros")+"</td>"+
                            "<td>"+ genero2 +"</td>"+
                            "<td>"+libros.getString("Autor")+"</td>"+
                            "<td>"+libros.getString("A_Publicacion")+"</td>"+
	                    "</tr>"+
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
             </table>
             
              <br>
  				<a href="./admin/Insertar.jsp">
    				<button ><b>Insertar Nuevo Libro</b></button>
  				</a>
  				
  			<br>
  			<br>
  				<a href="./admin/admin.jsp">
    				<button ><b>Gestionar Libros</b></button>
  				</a>
            <br>
          
             
             </main>
</body>
</html> 