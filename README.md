# Funções Powershell
Apenas algumas funções que fiz para uso pessoal, em geral são para processamento de arquivos.\
Recomendo adicionar as funções em um dos perfis.\
**Aviso:** Eu traduzi os comentários, porém o texto mostrado no console e/ou as variaveis quase sempre serão em inglês.


## magickConvertAll:
Utiliza a ferramenta [imageMagick](https://imagemagick.org) para converter todos os arquivos png e jpg na pasta e subpastas para jpgs utilizando a qualidade informada. Pode facilmente ser modificado para trabalhar com outros formatos ou adaptado para realizar alguma operação diferente que também necessite de acesso a pastas e subpastas.\
O código não é completamente otimizado e pode se beneficiar de alguns ajustes.\
**AVISO:** O uso dessa função SUBSTITUI todos os arquivos afetados, caso não tenha certeza do que esta fazendo crie um backup da pasta antes.

Usagem:
> magickConvertAll "C:\CAMINHO\DA\PASTA" qualidadeDaImg tamanhoEmMB

Por exemplo, o comando a seguir converte todas as imgs png e jpg na pasta Pictures do usuário Default com 2MB ou mais para jpgs com 80% da qualidade original:
> magickConvertAll "C:\Users\Default\Pictures" 80 2

O processo pode ser demorado, utilizando um Ryzen 5 3500X observei que 30gb de imagens demoram cerca de 1 hora para serem convertidas.\
Não notei uso elevado de RAM ou CPU com imagens até 30MB~, não testei com nada acima disso. Vale mencionar que o uso de disco pode ser razoavelmente elevado, sistemas rodando em HDD possivelmente vão passar por certa lentidão durante o processamento de muitos arquivos.
