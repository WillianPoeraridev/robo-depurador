@echo off
echo ===========================================
echo    Executando o Robo Depurador Fenix...
echo ===========================================
echo.

:: Este comando garante que o terminal navegue para a pasta onde o script está
cd /d "%~dp0"

:: Executa o robo usando o python
python -m robot robo_depurador.robot

echo.
echo ===========================================
echo    Execucao Finalizada.
echo ===========================================
pause