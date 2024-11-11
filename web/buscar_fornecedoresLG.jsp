
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Busca código do produto no BD</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel='stylesheet' type='text/css' href='styleAviso.css'>
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

 /*select aguarda o código (codigo=?)*/
                st = conn.prepareStatement("SELECT * FROM fornecedores WHERE cod_forn=?");
                /*informa a variável C (código)*/
                st.setInt(1, codigo);
                /*EXECUTA O SELECT*/
                resultado = st.executeQuery();
                /*Executa o SELECT */
                if (resultado.next()) {
                    /*Se encontrou*/
 /*o que está dentro do parênteses é um parâmetro/campo do banco de dados/tabela*/

        %>

        <main>
            <h1>CONSULTAR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>

                <b>Código:</b> <%= resultado.getInt("cod_forn")%><br>
                <b>CNPJ:</b> <%= resultado.getString("cnpj_forn")%><br>
                <b>Nome:</b> <%= resultado.getString("nome_forn")%>

                <button onclick="window.location.href = 'consultar_fornecedoresLG.html'" class="button_salvar_produtos">Voltar</button>
            </section>
        </main>


        <%

        } else {

        %>

        <main>
            <h1>CONSULTAR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="buscar_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="text" name="codigo" size="10" maxlength="10">  
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                    <div class="avisos-container">
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
            <h1>CONSULTAR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="buscar_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="text" name="codigo" size="10" maxlength="10">  
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                    <div class="avisos-container">
                        <div class="avisos">Fornecedor não localizado.</div>
                    </div>
                </form>
            </section>
        </main>

        <%
            } catch (Exception e) {

        %>

        <main>
            <h1>CONSULTAR FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="buscar_fornecedoresLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="text" name="codigo" size="10" maxlength="10">  
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                    <div class="avisos-container">
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
