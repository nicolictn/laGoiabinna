<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="stylesLogin_Cadastro.css"/>
        <link rel="stylesheet" type="text/css" href="stylesPopup.css">
        <link rel="shortcut icon" href="logo_favicon.ico" type="image/x-icon">
    </head>
    <body>

        <main>
            <img class="img_login" src="logo_footer.png" alt="">
            <section class="container_login">
                <h1>Login</h1>
                <form method="post" action="validarFuncionario.jsp">
                    <label for="matricula" class="align_left">Matrícula</label>
                    <input id="matricula" class="align-center" type="text" name="matricula">

                    <label for="senha">Senha</label>
                    <input id="senha" type="password" name="senha">

                    <input type="submit" value="Entrar" class="button_login">

                </form>
                <a href="cadastro_funcionariosLG.jsp">Não tem uma conta? Cadastre-se</a>
            </section>
        </main>

        <%
            String matricula, senha;
            Connection conn;
            PreparedStatement st;
            ResultSet resultado;

            // só executa essa parte quando o form for enviado
            if (request.getMethod().equalsIgnoreCase("POST")) {
                /*Recebe o usuário e senha digitados no formulário*/
                matricula = request.getParameter("matricula");
                senha = request.getParameter("senha");
                /*Conectar com o banco de dados*/
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");
                /* Busca o usuário e senha digitados, na tabela users do BD */
                st = conn.prepareStatement("SELECT * FROM usuario_funcionario WHERE matricula=? AND senha=?");
                st.setString(1, matricula);
                st.setString(2, senha);
                resultado = st.executeQuery();
                /*Executa o SELECT */
                if (resultado.next()) {
                    /*se encontrou o usuário */
                    response.sendRedirect("restritoLG.jsp?primeiroNome=" + resultado.getString("primeiroNome"));
                } else {
                    /* Se não encontrou */
                    out.print("<div class='popup-container'>");
                    out.print("<div class='popup-caixinha'>");
                    out.print("<div class='popup-conteudo'>");
                    out.print("<p>Usuário e/ou senha não encontrados.</p>");
                    out.print("<p><button onclick='window.location.href=\"validarFuncionario.jsp\"'>Tentar novamente</button></p>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                }

            }

        %>    

    </body>
</html>
