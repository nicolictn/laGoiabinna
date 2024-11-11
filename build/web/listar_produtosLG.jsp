<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%><!-- importar o drive manager que é a ferramenta q permite apontar qual banco de dados vc quer usar -->  
<%@page import="java.sql.Connection"%>  
<%@page import="java.sql.PreparedStatement"%>  
<%@page import="java.sql.ResultSet"%>  
<!DOCTYPE html>  
<html>  
    <head>  
        <!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  -->
        <meta charset="ISO-8859-1">
        <title>Listagem De Produtos</title>  
        <link rel="stylesheet" href="cardsProducts.css"> 
    </head>  
    <body>  
        <h1>Relatório de Produtos - La Goiabinna</h1> 

        <% /*
            Connection conn;/*tem q importar*/
 /*PreparedStatement st; 
            ResultSet resultado; //se ficar vermelho tem q importar. resultSet é uma variavel que guarda os dados que trouxe do BD  
            /*Conectar com Banco de Dados*/
 /*Class.forName("com.mysql.cj.jdbc.Driver");/*dentro das aspas, aponta para biblioteca que baixou, mysql e acha a pasta com.mysql.cj.jdbc e depois Driver.class*/
 /*conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna?useUnicode=true&characterEncoding=UTF-8", "root", "");/*vamos ter q importar. escolher o getconnection q tem as variáveis. busca os dados digitados,na respectiva tabela no BD*/
 /*st = conn.prepareStatement("SELECT * FROM produtos ORDER BY nomeProduto"); 
            /*resultado = st.executeQuery(); 
            /*Executa o SELECT*/
 /* out.print("<main>");
            while (resultado.next()) {
            out.print("<div class=\"cardProduct\">"); 
            out.print("<img src=\"img_inicial.png\" alt=\"\">"); 
            out.print("<p><strong>Código:</strong> " + resultado.getString("codigo") + "</p>");
            out.print("<p><strong>Nome:</strong> " + resultado.getString("nomeProduto") + "</p>");
            out.print("<p><strong>Preço:</strong> R$ " + String.format("%.2f", resultado.getDouble("preco")) + "</p>");
            out.print("<a href=excluir_produtosLG.jsp?codigo=" + resultado.getString("codigo") + ">Excluir</a>  "); 
            out.print("<a href=carregar_produtosLG.jsp?codigo=" + resultado.getString("codigo") + ">Alterar</a>"); 
            out.print("</div>"); 
            } 
            out.print("</main>"); 

            /*resultado.close();
            st.close();
            conn.close(); */


            Connection cnn;
            PreparedStatement st;
            ResultSet resultado;

            Class.forName("com.mysql.cj.jdbc.Driver");
            cnn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lagoiabinna", "root", "");
            st = cnn.prepareStatement("select produtos.codigo, produtos.nomeProduto, produtos.quantidade, produtos.preco, produtos.imgProduto, fornecedores.nome_forn from produtos inner join fornecedores on produtos.cod_forn = fornecedores.cod_forn order by produtos.codigo asc");
            resultado = st.executeQuery();

            out.print("<div class='card-container'>"); // abre container

            while (resultado.next()) {
                out.print("<div class='card'>"); // abre card
                out.print("<div class='conteudo-card'>"); // abre conteudo

                // card info
                out.print("<div class='img-produto'><img src='logo_footer.png' alt=''></div>");
                out.print("<div class='cod-produto'>ID: " + resultado.getString("codigo") + "</div>");
                out.print("<div class='nome-produto'>" + resultado.getString("nomeProduto") + "</div>");
                out.print("<div class='qtd-produto'>QUANTIDADE: " + resultado.getString("quantidade") + " UNIDADES</div>");
                out.print("<div class='forn-produto'>FORNECEDOR: " + resultado.getString("nome_forn").toUpperCase() + "</div>");
                out.print("<div class='preco-produto'>R$ " + String.format("%.2f", resultado.getDouble("preco")).replace('.', ',') + "</div>");
                // fim card info

                // botao excluir
                out.print("<div class='botoes'>");
                out.print("<button onclick='confirmarEscolha(\"" + resultado.getString("codigo") + "\")'>Excluir</button>");
                out.print("</div>");
                // fim botao excluir

                out.print("</div>"); // fecha conteudo
                out.print("</div>"); // fecha card
            }

            out.print("</div>"); // fecha container

        %>

        <script>
            function confirmarEscolha(codigo) {
                var conf = window.confirm("Deseja realmente excluir o produto " + codigo + "? Essa ação é irreversível.");

                if (conf) {
                    // redireciona ao JSP da exclusão e realiza a operação
                    window.location.href = 'excluir_produtos_listagemLG.jsp?codigo=' + codigo;
                    window.alert("O produto foi excluído.");
                } else {
                    window.alert("Produto não foi excluído.");
                }
            }
        </script>
    </body>  
</html>  