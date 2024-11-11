<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel="stylesheet" href="styleAviso.css" />
        <script>
            // fun��o para esconder os avisos ap�s alguns segundos
            function hideAlert(id) {
                const alertDiv = document.getElementById(id);
                if (alertDiv) {
                    setTimeout(() => {
                        alertDiv.style.display = 'none';
                    }, 5000); // 5 segundos
                }
            }

            // chama a fun��o para esconder os avisos
            window.onload = function() {
                hideAlert('prodExcluido');
                hideAlert('prodNaoExiste');
            };
        </script>
    </head>
    <body>
        <%
            Connection conn;
            PreparedStatement st;
            String codigo;

            //Receber o c�digo digitado no formul�rio de cadastro
            codigo = request.getParameter("codigo");

            //Conectar com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

            //Exclui o c�digo do produto recebido na tabela produtos do BD
            st = conn.prepareStatement("DELETE from produtos WHERE codigo=?");
            st.setString(1, codigo);

            /*vari�vel status usada para verificar se foi exclu�do ou n�o*/
            int status = st.executeUpdate(); //Executa o DELETE na tabela

            if (status == 1) {

        %>

        <main>
            <h1>EXCLUIR PRODUTOS</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="excluir_produtosLG.jsp">
                    <p>  
                        <label for="codigo">C�digo do Produto:</label>  
                        <input id="codigo" type="text" name="codigo" size="10" maxlength="10">  
                    </p>  
                    <input type="submit" value="Excluir" class="button_salvar_produtos">
                    <div class="avisos-container" id="prodExcluido">
                        <div class="avisos">Produto <%= codigo %> exclu�do.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
            } else {
        %>

        <main>
            <h1>EXCLUIR PRODUTOS</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="excluir_produtosLG.jsp">
                    <p>  
                        <label for="codigo">C�digo do Produto:</label>  
                        <input id="codigo" type="text" name="codigo" size="10" maxlength="10">  
                    </p>  
                    <input type="submit" value="Excluir" class="button_salvar_produtos">
                    <div class="avisos-container" id="prodNaoExiste">
                        <div class="avisos">Produto n�o localizado.</div>
                    </div>
                </form>
            </section>

        </main>

        <%
            }
        %>

        <script src="script.js"></script>
    </body>
</html>
