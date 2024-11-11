<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%--TRATA ERROS/EXCEÇÕES--%>
<%@page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel="stylesheet" href="styleAviso.css" />
        <link rel="stylesheet" href="stylesPopup.css" />
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
                hideAlert('fornCadastrado');
                hideAlert('fornContatoAdmin');
                hideAlert('fornDuplicado');
            };
        </script>
    </head>
    <body>

        <main>
            <h1>CADASTRO DE FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="salvar_fornecedoresLG.jsp">
                    <label for="nomeFornecedor">Nome do Fornecedor:</label>
                    <input id="nomeFornecedor" type="text" name="nomeFornecedor" maxlength="50" required>
                    <label for="cnpj">CNPJ:</label>
                    <input id="cnpj" type="text" name="cnpj" maxlength="14" required>
                    <input type="submit" value="Salvar" class="button_salvar_produtos">
                </form>


                <%
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        Connection conn = null;
                        PreparedStatement st = null;
                        String nomeFornecedor = null, cnpj = null;
                        int result = 0;

                        try {
                            //Receber os dados digitados no formulário de cadastro
                            nomeFornecedor = request.getParameter("nomeFornecedor");
                            cnpj = request.getParameter("cnpj");
                            /*teste para verificar se há erro*/

                            //Conectar com o banco de dados
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

                            // Salvar os dados recebidos na tabela users do BD
                            String sql = "INSERT INTO fornecedores (cnpj_forn, nome_forn) VALUES(?,?)";
                            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                            pstmt.setString(1, cnpj);
                            pstmt.setString(2, nomeFornecedor);
                            int affectedRows = pstmt.executeUpdate(); // Executa o INSERT na tabela

                            if (affectedRows > 0) {
                                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                                    if (generatedKeys.next()) {
                                        int idGerado = generatedKeys.getInt(1);
                                        out.print("<div class='popup-container'>");
                                        out.print("<div class='popup-caixinha'>");
                                        out.print("<div class='popup-conteudo'>");
                                        out.print("<p>Fornecedor com ID de <strong>ID " + idGerado + "</strong> cadastrado com sucesso!</p>");
                                        out.print("<p><button onclick='window.location.href=\"salvar_fornecedoresLG.jsp\"'>Cadastrar outro fornecedor</button>");
                                        out.print("<button onclick='window.location.href=\"listar_fornecedoresLG.jsp\"'>Lista de fornecedores</button></p>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                    }
                                }
                            }

                            //o catch irá tratar o erro, uma exceção. ERRO = variável
                        } catch (SQLException e) {
                            /*o código abaixo pega uma mensagem de erro e verifica se contém uma parte, que no caso é "Duplicate entry"*/
                            if (e.getMessage().contains("Duplicate entry")) {

                %>


                <div class="avisos-container" id="fornDuplicado">
                    <div class="avisos">O CNPJ deste fornecedor já está cadastrado.</div>
                </div>
            </section>

            <%
                } else {

            %>


            <div class="avisos-container" id="fornContatoAdmin">
                <div class="avisos">Entre em contato com o administrador. Código do erro: <%= e.getMessage()%>.</div>
            </div>


            <%

                    }
                }

                if (result == 1) {

            %>


            <div class="avisos-container" id="fornCadastrado">
                <div class="avisos">Fornecedor cadastrado com sucesso!</div>
            </div>

        </section>

    </main>

    <%            }
        }
    %>

</body>
</html>
