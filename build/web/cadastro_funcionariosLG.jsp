<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import= "java.sql.Statement"%>
<%@page import= "java.sql.ResultSet"%>
<%@page import= "java.sql.SQLException"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="stylesLogin_Cadastro.css">
        <link rel="stylesheet" type="text/css" href="stylesPopup.css">
        <title>Cadastro de Funcionários</title>
        <link rel="shortcut icon" href="logo_favicon.ico" type="image/x-icon">
        <!--
        <script> 
            
            //FAZER UM POP UP E ALTERAR O CSS DA CAIXA DE MENSAGEM!!!
            function nextPage() {
                addEventList()
                
            }
            
            function popUpIDMatricula() {
                var texto_matricula = document.getElementById(Mensagem_Matricula).value;
                texto_matricula.style.backgroundColor = white;
                
                
            }
        </script>
        -->
    </head>
    <body>
        <% /*
            Connection conn;
            PreparedStatement st;
            String primeiroNome, sobrenome, email, senha;
            ResultSet rs = null;
            //Receber os dados digitados no formulário de cadastro
            primeiroNome = request.getParameter("primeiroNome");
            sobrenome = request.getParameter("sobrenome");
            email = request.getParameter("email");
            senha = request.getParameter("senha");
            //Conectar com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "mysql");
            //Salvar os dados recebido na tabela users do BD
            String sql = "INSERT INTO usuario_funcionario (primeiroNome, sobrenome, email, senha) VALUES(?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // retorna PK gerada
            pstmt.setString(1, primeiroNome);
            pstmt.setString(2, sobrenome);
            pstmt.setString(3, email);
            pstmt.setString(4, senha);
            int affectedRows = pstmt.executeUpdate(); //Executa o INSERT na tabela

            if (affectedRows > 0) {
            // se o cadastro deu certo, retorna a pagina html de cadastro com "?status=success" na URL
                response.sendRedirect("cadastroFuncionarios.html?status=success");
            } else {
            // se o cadastro deu errado, retorna a pagina html de cadastro com "?status=error" na URL
                response.sendRedirect("cadastroFuncionarios.html?status=error");
            }

             */

        %>


        <img class="img_login" src="logo_footer.png" alt="">
        <section class="container_login">
            <h1>Cadastro</h1>
            <form method="post" action="cadastro_funcionariosLG.jsp">
                <label for="primeiroNome">Primeiro nome</label>
                <input id="primeiroNome" type="text" name="primeiroNome" maxlength="30" required>
                <label for="sobrenome">Sobrenome</label>
                <input id="sobrenome" type="text" name="sobrenome" maxlength="50" required>
                <label for="email">E-mail</label>
                <input id="email" type="email" name="email" maxlength="50" required>
                <label for="senha">Senha</label>
                <input id="senha" type="password" name="senha" maxlength="50" required>
                <input type="submit" value="Cadastrar" class="button_login">
            </form>
            <a href="validarFuncionario.jsp">Já tem uma conta? Faça seu login</a>
        </section>

        <%
            Connection conn;
            PreparedStatement st;
            String primeiroNome, sobrenome, email, senha;
            ResultSet rs = null;

            // só executa essa parte quando o form for enviado
            if (request.getMethod().equalsIgnoreCase("POST")) {
                primeiroNome = request.getParameter("primeiroNome");
                sobrenome = request.getParameter("sobrenome");
                email = request.getParameter("email");
                senha = request.getParameter("senha");

                try {
                    // Conectar com o banco de dados
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

                    // Salvar os dados recebidos na tabela users do BD
                    String sql = "INSERT INTO usuario_funcionario (primeiroNome, sobrenome, email, senha) VALUES(?,?,?,?)";
                    PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    pstmt.setString(1, primeiroNome);
                    pstmt.setString(2, sobrenome);
                    pstmt.setString(3, email);
                    pstmt.setString(4, senha);
                    int affectedRows = pstmt.executeUpdate(); // Executa o INSERT na tabela

                    if (affectedRows > 0) {
                        try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                int matriculaGerada = generatedKeys.getInt(1);
                                out.print("<div class='popup-container'>");
                                out.print("<div class='popup-caixinha'>");
                                out.print("<div class='popup-conteudo'>");
                                out.print("<p>Usuário com matrícula de <strong>ID " + matriculaGerada + "</strong> cadastrado com sucesso!</p>");
                                out.print("<p><button onclick='window.location.href=\"index.html\"'>Voltar ao início</button></p>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                        }
                    }
                } catch (SQLException e) {
                    if (e.getErrorCode() == 1062) { // erro de PK/UNIQUE duplicada
                        out.print("<div class='popup-container'>");
                        out.print("<div class='popup-caixinha'>");
                        out.print("<div class='popup-conteudo'>");
                        out.print("<p>Erro: o e-mail já consta no banco de dados.</p>");
                        out.print("<p><button onclick='window.location.href=\"cadastro_funcionariosLG.jsp\"'>Tentar novamente</button></p>");
                        out.print("</div>");
                        out.print("</div>");
                        out.print("</div>");
                    } else {
                        out.print("<script>alert('Erro ao inserir: " + e.getMessage() + "');</script>");
                    }
                }
            }
        %>

    </body>
</html>
