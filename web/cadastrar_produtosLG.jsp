<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.Connection"%>  
<%@page import="java.sql.PreparedStatement"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.SQLException"%>  
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" href="logo_favicon.ico" type="image/x-icon">
        <title>Cadastro de Produtos</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel='stylesheet' type='text/css' href='styleAviso.css'>
        <script>
            // função para esconder os avisos após alguns segundos
            function hideAlert(id) {
                const alertDiv = document.getElementById(id);
                if (alertDiv) {
                    setTimeout(() => {
                        alertDiv.style.display = 'none';
                    }, 5000); // 5 segundos
                }
            }

            // chama a função para esconder os avisos
            window.onload = function () {
                hideAlert('cadSucesso');
                hideAlert('cadDuplicado');
                hideAlert('cadAdmin');
            };
        </script>
    </head>
    <body>
        <main>
            <h1>CADASTRO DE PRODUTOS</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="cadastrar_produtosLG.jsp">
                    <label for="codigo">Código:</label>
                    <input id="codigo" type="text" name="codigo" required>
                    <label for="nomeProduto">Nome:</label>
                    <input id="nomeProduto" type="text" name="nomeProduto" required>
                    <label for="quantidade">Quantidade:</label>
                    <input id="quantidade" type="number" name="quantidade" min="1" required>

                    <%
                        Connection conn = null;
                        PreparedStatement st = null;
                        ResultSet resultado = null;

                        try {
                            // conexão com o bd    
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna?characterEncoding=UTF-8", "root", "");

                            // procura os fornecedores
                            st = conn.prepareStatement("SELECT cod_forn, nome_forn FROM fornecedores");
                            resultado = st.executeQuery();

                            // exibe os fornecedores
                            out.print("<div>");
                            out.print("<label for=''>Fornecedor:</label>");
                            out.print("<p><select name='cod_forn' id='fornecedores'>");
                            while (resultado.next()) {
                                out.print("<option value='" + resultado.getString("cod_forn") + "'>" + resultado.getString("nome_forn") + "</option>");
                            }
                            out.print("</p></select>");
                            out.print("</div>");

                            // tratamento de erros
                        } catch (SQLException e) {
                            out.print("<script>alert('Erro ao buscar fornecedores: " + e.getMessage() + ".');</script>");
                            // fecha as classes abertas
                        }

                    %>   

                    <label for="preco">Preço:</label>
                    <input id="preco" type="number" name="preco" min="1" step="0.01" required>
                    <!--
                    <label for="imgProduto">Imagem:</label>
                    <input id="imgProduto" type="text" name="imgProduto">
                    -->

                    <input type="submit" value="Salvar" class="button_salvar_produtos">

                    <%                        
                        // só executa esse codigo quando o formulario de cadastro de produtos for enviado
                        if (request.getMethod().equalsIgnoreCase("POST")) {
                            String codigo = null, nomeProduto = null, cod_forn = null, imgProduto = null;
                            int quantidade = 0;
                            double preco = 0.0;

                            try {

                                codigo = request.getParameter("codigo");
                                nomeProduto = request.getParameter("nomeProduto");
                                cod_forn = request.getParameter("cod_forn");
                                imgProduto = request.getParameter("imgProduto");
                                quantidade = Integer.parseInt(request.getParameter("quantidade"));
                                preco = Double.parseDouble(request.getParameter("preco"));

                                // insert do novo produto
                                st = conn.prepareStatement("INSERT INTO produtos (codigo, nomeProduto, quantidade, cod_forn, preco, imgProduto) VALUES(?,?,?,?,?,?)");
                                st.setString(1, codigo);
                                st.setString(2, nomeProduto);
                                st.setInt(3, quantidade);
                                st.setString(4, cod_forn);
                                st.setDouble(5, preco);
                                st.setString(6, imgProduto);
                                int result = st.executeUpdate();

                                // verifica se o insert foi bemsucedido
                                if (result == 1) {
                                    out.print("<div class='avisos-container' id='cadSucesso'>");
                                    out.print("<div class='avisos'>Produto cadastrado com sucesso!</div>");
                                    out.print("</div>");
                                }

                            } catch (SQLException e) {
                                if (e.getErrorCode() == 1062) { // erro de PK/UNIQUE duplicada
                                    out.print("<div class='avisos-container' id='cadDuplicado'>");
                                    out.print("<div class='avisos'>Código duplicado. O produto já existe.</div>");
                                    out.print("</div>");
                                } else {
                                    out.print("<div class='avisos-container' id='cadAdmin'>");
                                    out.print("<div class='avisos'>Erro inesperado:" + e.getMessage() + ".</div>");
                                    out.print("</div>");
                                } // fecha todas as conexões abertas
                            }
                        }
                    %>
                </form>
            </section>
        </main>
    </body>
</html>
