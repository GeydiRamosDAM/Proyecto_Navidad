<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>ADMINISTRACION GESTION LIBROS</title>
</head>
<body>
	<%@ page import="java.sql.*" %>
	<h1>ADMINISTRACION GESTION LIBROS</h1>
	<table border=1>
	<thead>
		<tr>
			<th>ID</th>
			<th>Titulo</th>
			<th>Genero</th>
			<th>Autor</th>
			<th>Año Publicación</th>
		</tr>
	</thead>	
	<tbody>
	         <%
				Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conexion2 =null;
                
                if(request.getParameter("operacion")!=null)
    			{
	                try{
	                   String url = "jdbc:mysql://127.0.0.1/libros_para_todos";
	                   String usuario= "proyecto_libros";
	                   String contrasena = "proyecto_libros";
	                   conexion2 = DriverManager.getConnection(url,usuario,contrasena);
	             
	                   String peticionBorrar= "DELETE FROM libros WHERE ID_Libros = "+ request.getParameter("id");
	                   
	                   PreparedStatement borrado = conexion2.prepareStatement(peticionBorrar);
	                   borrado.executeUpdate();
	                
	                }catch(Exception e){
	                   e.printStackTrace();
	                }finally{
	                   if(conexion2 !=null){
	                   conexion2.close();
	                	}
	                }
			    }
	
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 Connection conexion =null;
                 try{
                    String url = "jdbc:mysql://127.0.0.1/libros_para_todos";
                    String usuario= "proyecto_libros";
                    String contrasena = "proyecto_libros";
                    
                    conexion = DriverManager.getConnection(url,usuario,contrasena);
                    Statement solicitud = conexion.createStatement();
                    ResultSet registroLibros = solicitud.executeQuery("SELECT * FROM libros");
                    
					Statement peticion2 = conexion.createStatement();
                    
                    
                    String genero = "";
                    
                    while(registroLibros.next()){
                    	//encontrar el valor de género dado su ID
                    	ResultSet generos = peticion2.executeQuery("SELECT * FROM genero");
						  	while (generos.next()){
						  		if(generos.getInt("ID_Genero") == registroLibros.getInt("ID_Genero")){
						  			genero = generos.getString("Clasificacion");
						  			break;}
						 	 }               	

							out.println(""+
		                        	"<tr>"+
		                        		"<td>"+registroLibros.getInt("ID_Libros")+"</td>"+
		                    			"<td>"+registroLibros.getString("Titulo")+"</td>"+
		                    			"<td>"+ genero +"</td>"+
										"<td>"+registroLibros.getString("Autor")+"</td>"+
		                    			"<td>"+registroLibros.getInt("A_Publicacion")+"</td>"+
		                    			"<td><a href='?operacion=borrar&id="+registroLibros.getInt("ID_Libros")+"'><button>Borrar</button></a>"+"</td>"+
										"<td><a href='Modificar.jsp?operacion=modificar&id="+registroLibros.getInt("ID_Libros")  +  "'><button>Modificar</button></a>" + "</td>" +		
		                    					
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
   
	</tbody>
	</table>
	
	<br>
  				<a href="../index.jsp">
    				<button ><b>Inicio</b></button>
  				</a>
            <br>
	
	
</body>
</html>