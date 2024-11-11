<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel="stylesheet" href="styleAviso.css" />
    </head>
    <body>
        <%
            Connection conn;
            PreparedStatement st;
            String codigo;

            //Receber o código digitado no formulário de cadastro
            codigo = request.getParameter("codigo");

            //Conectar com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

            //Exclui o código do produto recebido na tabela produtos do BD
            st = conn.prepareStatement("DELETE from produtos WHERE codigo=?");
            st.setString(1, codigo);

            /*variável status usada para verificar se foi excluído ou não*/
            int status = st.executeUpdate(); //Executa o DELETE na tabela

            if (status == 1) {
                response.sendRedirect("listar_produtosLG.jsp");
            }

        %>

    </body>
</html>
