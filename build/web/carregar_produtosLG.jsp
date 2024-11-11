<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.Connection" %>  
<%@page import="java.sql.PreparedStatement" %>  
<%@page import="java.sql.ResultSet" %> 
<%@page import="java.sql.SQLException" %> 
<!DOCTYPE html>  
<html>  
    <head>  
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel="stylesheet" href="styleAviso.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
        <title>Carrega produtos para alteração</title>  
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
            window.onload = function() {
                hideAlert('altNaoExiste');
            };
        </script>
    </head>  
    <body>  
        <%
            String codigo = null;
            Connection conn;
            PreparedStatement st;
            ResultSet resultado;

            /*Recebe o código digitado no formulário*/
            codigo = request.getParameter("codigo");

            /*Conectar com o banco de dados*/
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

            /* Busca o código digitado, na tabela produtos do BD */
            st = conn.prepareStatement("SELECT * FROM produtos WHERE codigo=?");
            st.setString(1, codigo);
            resultado = st.executeQuery();
            /*Executa o SELECT */

            if (resultado.next()) {
                /* se encontrou o produto tem que exibir em html*/
        %>  
        <!--finaliza o bloco java e abre outro para o form--> 
        <main>
            <h1>ALTERAÇÃO DE PRODUTOS</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="alterar_produtosLG.jsp">  
                    <label for="codigo">Código:</label>
                    <input id="codigo" type="text" name="codigo" size="15" maxlength="15" value="<%= resultado.getString("codigo")%>" style="background-color: #efefef;" readonly>
                    <label for="nomeProduto">Nome:</label>
                    <input id="nomeProduto" type="text" name="nomeProduto" size="50" maxlength="50" value="<%= resultado.getString("nomeProduto")%>" required>
                    <label for="quantidade">Quantidade:</label>
                    <input id="quantidade" type="number" name="quantidade" size="20" maxlength="20" min="1" value="<%= resultado.getString("quantidade")%>" required>
                    <label for="preco">Preço:</label>
                    <input id="preco" type="number" name="preco" min="1" step="0.01" value="<%= resultado.getString("preco")%>" required>
                        <%
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
                        %>
                    </select>
                    <!--
                    <label for="imgProduto">Imagem:</label>
                    <input id="imgProduto" type="file" name="imgProduto" value="</%= resultado.getBlob("imgProduto")%>">
                    -->

                    <input type="submit" value="Alterar" class="button_salvar_produtos">
                </form>  
            </section>
        </main>

        <%
        } else {
            // se nao encontrou
        %>

        <main>
            <h1>ALTERAÇÃO DE PRODUTOS</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="carregar_produtosLG.jsp">
                    <p>  
                        <label for="codigo">Código do Produto:</label>  
                        <input id="codigo" type="text" name="codigo" size="15" maxlength="15" required>  
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                    <div class="avisos-container" id="altNaoExiste">
                        <div class="avisos">Produto não localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
            }

        %>      



    </body>  
</html>  