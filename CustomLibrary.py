import os
import zipfile

def compactar_pasta_em_zip(caminho_da_pasta, caminho_do_zip):
    """
    Compacta todos os conteúdos de uma pasta em um arquivo .zip.

    :param caminho_da_pasta: O caminho completo da pasta a ser compactada.
    :param caminho_do_zip: O caminho completo do arquivo .zip a ser criado.
    """
    with zipfile.ZipFile(caminho_do_zip, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(caminho_da_pasta):
            for file in files:
                # Cria o caminho completo do arquivo
                caminho_completo = os.path.join(root, file)
                # Cria o caminho relativo para guardar no zip, para não criar a estrutura inteira de pastas
                caminho_relativo = os.path.relpath(caminho_completo, os.path.join(caminho_da_pasta, '..'))
                zipf.write(caminho_completo, arcname=caminho_relativo)