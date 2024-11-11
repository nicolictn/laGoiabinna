<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" href="logo_favicon.ico" type="image/x-icon">
        <title>Area Restrita</title>
        <link rel="stylesheet" href="stylesCRUD.css" />
        <link rel="stylesheet" href="stylesForms.css"/>
        <link rel="stylesheet" type="text/css" href="stylesPopup.css">
        <script>

            function gerenciarFornecedores() {
                document.getElementById("saudacaoFornecedores").style.display = "flex";
                document.getElementById("navFornecedores").style.display = "flex";

                document.getElementById("saudacaoProdutos").style.display = "none";
                document.getElementById("navProdutos").style.display = "none";

            }

            function gerenciarProdutos() {
                document.getElementById("saudacaoFornecedores").style.display = "none";
                document.getElementById("navFornecedores").style.display = "none";

                document.getElementById("saudacaoProdutos").style.display = "flex";
                document.getElementById("navProdutos").style.display = "flex";
            }

        </script>

    </head>
    <body>
        <header>
            <div class="logo_la_goiabinna">
                <img src="logo_goiabinha.png" alt="alt" />
            </div>
            <div class="saudacao">
                <p>
                    Olá, <%= request.getParameter("primeiroNome")%>! Seja muito bem-vindo(a).
                </p>
                
                <br><br>

                <p id="saudacaoProdutos" style="display: flex;">
                    <strong>
                        GERENCIADOR DE PRODUTOS
                    </strong>
                </p>

                <p id="saudacaoFornecedores" style="display: none;">
                    <strong>
                        GERENCIADOR DE FORNECEDORES
                    </strong>
                </p>

            </div>
            <div class="login_e_cadastro">
                <img src="icon_login.png" alt="alt" />
                <a href="index.html">Sair</a>
            </div>
        </header>
        <nav id="navProdutos" style="display: flex;">
            <a href="cadastrar_produtosLG.jsp" target="conteudoLG">Cadastrar</a>
            <a href="alterar_produtosLG.html" target="conteudoLG">Alterar</a>
            <a href="listar_produtosLG.jsp" target="conteudoLG">Listagem</a>
            <a href="excluir_produtosLG.html" target="conteudoLG">Excluir</a>
            <a href="consultar_produtosLG.html" target="conteudoLG">Consultar</a>
            <a href="#" onclick="gerenciarFornecedores()">Fornecedores</a>
        </nav>

        <nav id="navFornecedores" style="display: none;">
            <a href="salvar_fornecedoresLG.jsp" target="conteudoLG">Cadastrar</a>
            <a href="alterar_fornecedoresLG.html" target="conteudoLG">Alterar</a>
            <a href="listar_fornecedoresLG.jsp" target="conteudoLG">Listagem</a>
            <a href="excluir_fornecedoresLG.html" target="conteudoLG">Excluir</a>
            <a href="consultar_fornecedoresLG.html" target="conteudoLG">Consultar</a>
            <a href="#" onclick="gerenciarProdutos()">Produtos</a>
        </nav>
        <main>
            <iframe class="quadroLG" src="cadastrar_produtosLG.jsp" name="conteudoLG" ></iframe>
        </main>
        <footer>
            <img src="logo_footer.png" alt="" />
            <p>
                © 2024 La Goiabinna - Todos os direitos reservados. 
                <br>
                <a href="">
                    Política de
                    Privacidade
                </a> | 
                <a href="">
                    Termos de Uso
                </a>
            </p>
        </footer>
    </body>
</html>
