<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>  
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
        <title>Carrega fornecedores para alteração</title>  
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
                hideAlert('altNaoExiste');
            };
        </script>
    </head>  
    <body>  
        <%
            int codigo = 0;
            Connection conn = null;
            PreparedStatement st = null;
            ResultSet resultado = null;

            try {

                /*Recebe o código digitado no formulário*/
                codigo = Integer.parseInt(request.getParameter("codigo"));

                /*Conectar com o banco de dados*/
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

                /* Busca o código digitado, na tabela produtos do BD */
                st = conn.prepareStatement("SELECT * FROM fornecedores WHERE cod_forn=?");
                st.setInt(1, codigo);
                resultado = st.executeQuery();
                /*Executa o SELECT */

                if (resultado.next()) {
                    /* se encontrou o produto tem que exibir em html*/
        %>  
        <!--finaliza o bloco java e abre outro para o form--> 
        <main>
            <h1>ALTERAÇÃO DE FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="alterar_fornecedoresLG.jsp">  
                    <label for="codigo">Código:</label>
                    <input id="codigo" type="number" name="codigo" min="0" value="<%= resultado.getString("cod_forn")%>" style="background-color: #efefef;" readonly>
                    <label for="cnpj">CNPJ:</label>
                    <input id="cnpj" type="text" name="cnpj" size="20" maxlength="20" value="<%= resultado.getString("cnpj_forn")%>" required>
                    <label for="nomeFornecedor">Nome:</label>
                    <input id="nomeFornecedor" type="text" name="nomeFornecedor" size="50" maxlength="50" value="<%= resultado.getString("nome_forn")%>" required>

                    <input type="submit" value="Alterar" class="button_salvar_produtos">
                </form>  
            </section>
        </main>

        <%
        } else {
            // se nao encontrou
        %>

        <main>
            <h1>ALTERAÇÃO DE FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="carregar_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor</label>  
                        <input id="codigo" type="text" name="codigo" maxlength="4" required>  
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                    <div class="avisos-container" id="altNaoExiste">
                        <div class="avisos">Fornecedor não localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
            }
        } catch (SQLException e) {

        %>

        <main>
            <h1>ALTERAÇÃO DE FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="carregar_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor</label>  
                        <input id="codigo" type="text" name="codigo" maxlength="4" required>  
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                    <div class="avisos-container" id="altNaoExiste">
                        <div class="avisos">Fornecedor não localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
        } catch (Exception e) {

        %>

        <main>
            <h1>ALTERAÇÃO DE FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="carregar_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor</label>  
                        <input id="codigo" type="text" name="codigo" maxlength="4" required>
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                    <div class="avisos-container" id="altNaoExiste">
                        <div class="avisos">Fornecedor não localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%

            }

        %>      



    </body>  
</html>  