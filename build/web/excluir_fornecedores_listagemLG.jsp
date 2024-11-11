<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    
        <link rel="stylesheet" href="styleExcep.css" />
        <link rel="stylesheet" href="stylesTabela.css"> 
        <link rel="stylesheet" href="cardsProducts.css"> 
    </head>
    <body>
        <%
            Connection conn;
            PreparedStatement st;
            int codigo = 0;

            try {
                //Receber o código digitado no formulário de cadastro
                codigo = Integer.parseInt(request.getParameter("codigo"));

                //Conectar com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

                //Exclui o código do produto recebido na tabela produtos do BD
                st = conn.prepareStatement("DELETE from fornecedores WHERE cod_forn=?");
                st.setInt(1, codigo);

                /*variável status usada para verificar se foi excluído ou não*/
                int status = st.executeUpdate(); //Executa o DELETE na tabela

                if (status == 1) {
                    response.sendRedirect("listar_fornecedoresLG.jsp");
                }
            } catch (SQLException e) {
                if (e.getErrorCode() == 1451) {
        %>

        
        <div class="container-excep">
        <h1>Relatório de Fornecedores - La Goiabinna</h1> 

        <p>O fornecedor não pode ser excluído pois um ou mais produtos estão atrelados a esse fornecedor.</p>
       
        <button><a href="listar_fornecedoresLG.jsp">Voltar</a></button>
        </div>
        

        <%
                }
            }
        %>

    </body>
</html>
