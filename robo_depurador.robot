*** Settings ***
Library    Process
Library    OperatingSystem
Library    DateTime

*** Variables ***
${ROBO_ALVO}    robo_alvo.robot

*** Test Cases ***
Executar e Capturar Resultado do Robô Alvo
    [Documentation]    Executa um robô e, se ele falhar, coleta as evidências e as compacta em um arquivo .zip.
    
    ${resultado}=    Run Process
    ...    robot ${ROBO_ALVO}
    ...    shell=True
    ...    stdout=PIPE
    ...    stderr=PIPE

    Run Keyword If    '${resultado.rc}' != '0'    Coletar e Compactar Evidências    ${resultado}

*** Keywords ***
Coletar e Compactar Evidências
    [Arguments]    ${resultado_da_falha}
    
    Log To Console    FALHA DETECTADA! Coletando e compactando evidências...
    
    # 1. Criar a pasta de destino
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d_%H-%M-%S
    ${nome_da_pasta}=    Set Variable    debug_${timestamp}
    ${pasta_destino}=    Set Variable    ${CURDIR}${/}reports${/}${nome_da_pasta}
    Create Directory    ${pasta_destino}

    # 2. Coletar os arquivos de evidência
    Create File    ${pasta_destino}${/}erro_terminal.txt    ${resultado_da_falha.stderr}
    Copy File    ${ROBO_ALVO}  ${pasta_destino}${/}${ROBO_ALVO}
    Run Keyword And Ignore Error    Copy File    log.html      ${pasta_destino}${/}log.html
    Run Keyword And Ignore Error    Copy File    report.html   ${pasta_destino}${/}report.html

    # 3. Compactar a pasta de evidências usando o PowerShell (Plano B)
    ${comando_zip}=    Set Variable    Compress-Archive -Path "${pasta_destino}" -DestinationPath "${pasta_destino}.zip"
    Run    powershell -Command "${comando_zip}"

    Log To Console    Evidências compactadas com sucesso em: ${pasta_destino}.zip