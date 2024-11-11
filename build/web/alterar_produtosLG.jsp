<%@page contentType="text/html" pageEncoding="ISO-8859-1"%> 
<%@page import="java.sql.Connection"%> 
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.PreparedStatement"%> 
<%@page import="java.sql.ResultSet"%> 
<%@page import="java.sql.SQLException"%> 
<!DOCTYPE html> 
<html> 
    <head> 
        <meta charset="ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" href="logo_favicon.ico" type="image/x-icon">
        <title>Alteração de produtos</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css" />
        <link rel='stylesheet' type='text/css' href='styleAviso.css'>
        <link rel="stylesheet" type="text/css" href="stylesPopup.css">
    </head> 
    <body> 
        <%
            Connection conn = null;
            PreparedStatement st = null;
            ResultSet resultado = null;

            //Receber os dados digitados no formulário de alteração 
            String codigo = null, nomeProduto = null;
            int cod_forn = 0;
            double preco = 0.0;
            int quantidade = 0;

            try {
                //Receber os dados digitados no formulário de cadastro
                codigo = request.getParameter("codigo");
                nomeProduto = request.getParameter("nomeProduto");
                quantidade = Integer.parseInt(request.getParameter("quantidade"));
                cod_forn = Integer.parseInt(request.getParameter("cod_forn"));
                preco = Double.parseDouble(request.getParameter("preco"));

                //Conectar com o banco de dados 
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

                //Salvar os dados recebido na tabela produtos do BD 
                st = conn.prepareStatement("UPDATE produtos SET nomeProduto=?, quantidade=?, cod_forn=?, preco=? WHERE codigo=?");
                st.setString(1, nomeProduto);
                st.setInt(2, quantidade);
                st.setInt(3, cod_forn);
                st.setDouble(4, preco);
                st.setString(5, codigo);
                int result = st.executeUpdate(); //Executa o update na tabela 

                // se deu certinho o update, surge o popup com o aviso que foi alterado corretamente
                if (result == 1) {

        %>

        <main>
            <h1>ALTERAÇÃO DE PRODUTOS</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="alterar_produtosLG.jsp">  
                    <label for="codigo">Código:</label>
                    <input id="codigo" type="text" name="codigo" size="15" maxlength="15" readonly>
                    <label for="nomeProduto">Nome:</label>
                    <input id="nomeProduto" type="text" name="nomeProduto" size="50" maxlength="50" required>
                    <label for="quantidade">Quantidade:</label>
                    <input id="quantidade" type="number" name="quantidade" size="20" maxlength="20" min="1" required>
                    <label for="preco">Preço:</label>
                    <input id="preco" type="number" name="preco" min="1" step="0.01" required>
                    <label for="fornecedor">Fornecedor:</label>
                    <select name='cod_forn' id='fornecedores'>
                        <option value="Um">Fornecedor</option>
                    </select>
                    <input type="submit" value="Alterar" class="button_salvar_produtos">
                </form>  
            </section>
        </main>


        <%                    
                    out.print("<div class='popup-container'>");
                    out.print("<div class='popup-caixinha'>");
                    out.print("<div class='popup-conteudo'>");
                    out.print("<p>O produto " + nomeProduto + " foi alterado corretamente.</p>");
                    out.print("<p><button onclick='window.location.href=\"alterar_produtosLG.html\"'>Alterar outro produto</button>");
                    out.print("<button onclick='window.location.href=\"listar_produtosLG.jsp\"'>Lista de produtos</button></p>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");

                }

            } catch (SQLException e) {
                out.print("<div class='avisos-container'>");
                out.print("<div class='avisos'>Erro: " + e.getMessage() + "</div>");
                out.print("</div>");
            } catch (NumberFormatException erro) {
                out.print("<p style='color:#CC1E4A; font-family: Futura com book; padding-top: 20px'>O preço não pode ficar vazio</p>");
            }

        %> 


    </body> 

</html> 