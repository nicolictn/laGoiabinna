<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel="stylesheet" href="styleAviso.css" />
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
                hideAlert('fornExcluido');
                hideAlert('fornNaoExiste');
            };
        </script>
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

        %>

        <main>
            <h1>EXCLUIR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="excluir_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor</label>  
                        <input id="codigo" type="number" name="codigo" required>  
                    </p>  
                    <input type="submit" value="Excluir" class="button_salvar_produtos">
                    <div class="avisos-container" id="fornExcluido">
                        <div class="avisos">Fornecedor <%= codigo%> excluído.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
        } else {
        %>

        <main>
            <h1>EXCLUIR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="excluir_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="text" name="codigo" maxlength="4" required>  
                    </p>  
                    <input type="submit" value="Excluir" class="button_salvar_produtos">
                    <div class="avisos-container" id="fornNaoExiste">
                        <div class="avisos">Fornecedor não localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
            }
        } catch (SQLException e) {
            if (e.getErrorCode() == 1451) {
        %>

        <main>
            <h1>EXCLUIR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="excluir_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="text" name="codigo" maxlength="4" required>  
                    </p>  
                    <input type="submit" value="Excluir" class="button_salvar_produtos">
                    <div class="avisos-container" id="fornNaoExiste">
                        <div class="avisos">O fornecedor não pode ser excluído pois um ou mais produtos estão atrelados a esse fornecedor.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
            }

        %>

        <main>
            <h1>EXCLUIR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="excluir_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="text" name="codigo" maxlength="4" required>  
                    </p>  
                    <input type="submit" value="Excluir" class="button_salvar_produtos">
                    <div class="avisos-container" id="fornNaoExiste">
                        <div class="avisos">Fornecedor não localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%        } catch (Exception e) {

        %>

        <main>
            <h1>EXCLUIR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="excluir_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="text" name="codigo" maxlength="4" required>  
                    </p>  
                    <input type="submit" value="Excluir" class="button_salvar_produtos">
                    <div class="avisos-container" id="fornNaoExiste">
                        <div class="avisos">Fornecedor não localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%            }

        %>

        <script src="script.js"></script>
    </body>
</html>
