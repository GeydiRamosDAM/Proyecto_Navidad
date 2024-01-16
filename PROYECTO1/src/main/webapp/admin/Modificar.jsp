<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MODIFICAR DATOS LIBROS</title>
 <link rel="stylesheet" href="../css/estilo.css">
</head>
<body>

	<header>
		<h3>MODIFICAR DATOS LIBROS</h3>
	</header>
	
<main>


<%@ page import="java.sql.*" %> 
	

  <% 
  				if(request.getParameter("operacion")!=null)
     			{
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 Connection conexion =null;
                 try{
                    String url = "jdbc:mysql://127.0.0.1/libros_para_todos";
                    String usuario= "proyecto_libros";
                    String contrasena = "proyecto_libros";
                    conexion = DriverManager.getConnection(url,usuario,contrasena);
                    Statement peticion5 = conexion.createStatement();
                    Statement peticion6 = conexion.createStatement();
                    ResultSet list_generos5 = peticion5.executeQuery("SELECT * FROM genero");
                    ResultSet list_libros6 = peticion6.executeQuery("SELECT * FROM libros");
       				

                    

                    while (list_libros6.next()){
                    	
                    	int idRequest =  Integer.parseInt(request.getParameter("id"));
                    	int idLibroBD =  Integer.parseInt(list_libros6.getString("ID_Libros"));
                        
	                	if( idRequest == idLibroBD)
                    	{
	                     	String etiquetasOptions = "";
	                    	while(list_generos5.next()){
	                    		int idGenTablaGenero = Integer.parseInt(list_libros6.getString("ID_Genero"));
	                    		int idGenTablaLibros = Integer.parseInt(list_generos5.getString("ID_Genero"));
	                    		
	                    		if( idGenTablaGenero != idGenTablaLibros ){
	                    		etiquetasOptions += ""+
	              		     	"<option " + "value=" + list_generos5.getString("ID_Genero") + ">" + list_generos5.getString("Clasificacion") +" </option>" +
	              		    			 "";
	                    		}
	                    		else{
	                   			etiquetasOptions += ""+
	               		     	"<option selected='selected' " + "value=" + list_generos5.getString("ID_Genero") + ">" + list_generos5.getString("Clasificacion") +" </option>" +
	                         		    			 "";	
	                    			
	                    		}
	              		     	
	              		     }	
	                		
	                		//pintar formulario de modificar
                        	out.println(""+
                                	"<form action='../index.jsp' method='POST'>"+
                                		"<ul>"+
	                                		"<li>"+
												"<input type='hidden' name='idLibroMOdificar' value =" + list_libros6.getString("ID_Libros") + " />"+
	                    					"</li>"+
	                    					"<li>"+
                    							"<label for='id'>ID Libro:</label>"+
												"<input disabled type='text' name='idLibro' value =" + list_libros6.getString("ID_Libros") + " />"+
                    						"</li>"+
                            				"<li>"+
                            					"<label for='titulo'>Título del Libro:</label>"+
        										"<input type='text' name='libro_nombreModificar' value ='" + list_libros6.getString("Titulo") + "' />"+
                            				"</li>"+
                            				"<li>"+
	                        					"<label for='genero'>Género:</label>"+
	                        					"<select name='ID_generoModificar' >"+
	                        					etiquetasOptions +
	                        					"</select>"+
	    										
                        					"</li>"+
                        					"<li>"+
                        						"<label for='autor'>Autor:</label>"+
    											"<input type='text' name='libro_autor' value ='" + list_libros6.getString("Autor") + "' />"+
                    						"</li>"+
                    						"<li>"+
                    							"<label for='titulo'>Año de Publicación:</label>"+
												"<input type='number' name='libro_aPublicacion' value =" + list_libros6.getString("A_Publicacion") + " />"+
                							"</li>"+
                							"<li class='button'>"+
												"<button type='submit'>Modificar</button>"+
            								"</li>"+
                            					
            								
 										
                            			
                            			
                            			"</form>"+
                            		"");
                        	break;	
                    	}
                    		
                     	
                    }

  
                 }catch(Exception e){
                    e.printStackTrace();
                 }finally{
                    if(conexion !=null){
                    conexion.close();
                 }
                 }    		     
    		     
     	}
    %>

	

</main>

</body>
</html>