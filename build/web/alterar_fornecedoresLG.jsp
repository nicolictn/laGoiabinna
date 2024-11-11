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
        <title>Alteração de Fornecedores</title>
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
            int codigo = 0;
            String nomeFornecedor = null, cnpj = null;
            

            try {
                //Receber os dados digitados no formulário de cadastro
                codigo = Integer.parseInt(request.getParameter("codigo"));
                nomeFornecedor = request.getParameter("nomeFornecedor");
                cnpj = request.getParameter("cnpj");
               
                //Conectar com o banco de dados 
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");

                //Salvar os dados recebido na tabela produtos do BD 
                st = conn.prepareStatement("UPDATE fornecedores SET nome_forn=?, cnpj_forn=? WHERE cod_forn=?");
                st.setString(1, nomeFornecedor);
                st.setString(2, cnpj);
                st.setInt(3, codigo);
                int result = st.executeUpdate(); //Executa o update na tabela 

                // se deu certinho o update, surge o popup com o aviso que foi alterado corretamente
                if (result == 1) {

        %>

        <main>
            <h1>ALTERAÇÃO DE FORNECEDORES</h1>
            <section class="container_cadastro">
                <h2></h2>
                <form method="post" action="carregar_produtosLG.jsp">
                    <p>  
                        <label for="codigo">Código do Fornecedor:</label>  
                        <input id="codigo" type="number" name="codigo" min="0" required>  
                    </p>  
                    <input type="submit" value="Buscar" class="button_salvar_produtos">
                </form>
            </section>
        </main>


        <%                    
                    out.print("<div class='popup-container'>");
                    out.print("<div class='popup-caixinha'>");
                    out.print("<div class='popup-conteudo'>");
                    out.print("<p>O Fornecedor <strong>" + codigo + "</strong> foi alterado corretamente.</p>");
                    out.print("<p><button onclick='window.location.href=\"alterar_fornecedoresLG.html\"'>Alterar outro fornecedor</button>");
                    out.print("<button onclick='window.location.href=\"listar_fornecedoresLG.jsp\"'>Lista de fornecedores</button></p>");
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