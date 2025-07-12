*** Settings ***
Library    OperatingSystem

*** Test Cases ***
Teste que Propositalmente Falha
    Log    Este teste foi desenhado para falhar.
    Directory Should Exist    C:\\diretorio\\inexistente\\para\\teste
    Log    Se esta mensagem aparecer, algo deu errado no plano.