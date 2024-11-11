<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>  
<%@page import="java.sql.DriverManager"%><!-- importar o drive manager que é a ferramenta q permite apontar qual banco de dados vc quer usar -->  
<%@page import="java.sql.Connection"%>  
<%@page import="java.sql.PreparedStatement"%>  
<%@page import="java.sql.ResultSet"%>  
<!DOCTYPE html>  
<html>  
    <head>  
        <!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  -->
        <meta charset="ISO-8859-1">
        <title>Listagem De Produtos</title>  
        <link rel="stylesheet" href="stylesTabela.css"> 
        <link rel="stylesheet" href="cardsProducts.css"> 
    </head>  
    <body>  
        <h1>Relatório de Fornecedores - La Goiabinna</h1> 

        <%
            Connection cnn;
            PreparedStatement st;
            ResultSet resultado;

            Class.forName("com.mysql.cj.jdbc.Driver");
            cnn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");
            st = cnn.prepareStatement("select * from fornecedores order by cod_forn asc");
            resultado = st.executeQuery();

            out.print("<div class='container-tabela'>"); // abre container
            out.print("<table>");

            out.print("<tr>");
            out.print("<th>Código</th>");
            out.print("<th>CNPJ</th>");
            out.print("<th>Nome fantasia</th>");
            out.print("<th>Excluir</th>");
            out.print("</tr>");

            while (resultado.next()) {
                out.print("<tr>"); // gera uma nova linha na tabela
                out.print("<td>" + resultado.getInt("cod_forn") + "</td>");
                out.print("<td>" + resultado.getString("cnpj_forn") + "</td>");
                out.print("<td>" + resultado.getString("nome_forn") + "</td>");
                out.print("<td> <a href='#' onclick='confirmarEscolha(\"" + resultado.getString("cod_forn") + "\")'>Excluir</a></td>");
                out.print("</tr>"); // fecha a linha
            }

            out.print("</table>");
            out.print("</div>"); // fecha container

        %>

        <script>
            function confirmarEscolha(codigo) {
                var conf = window.confirm("Deseja realmente excluir o fornecedor " + codigo + "? Essa ação é irreversível.");

                if (conf) {
                    // redireciona ao JSP da exclusão e realiza a operação
                    window.location.href = 'excluir_fornecedores_listagemLG.jsp?codigo=' + codigo;
                } else {
                    window.alert("Fornecedor não foi excluído.");
                }
            }

        </script>
    </body>  
</html>  