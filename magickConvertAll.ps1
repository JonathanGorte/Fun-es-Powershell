function magickConvertAll($targetPath, $quality, $targetSize)
{

  ### AVISO ###
  # O código provavelmente esta funcional, porém traduzi os comentários e fiz alguns ajustes nos nomes das variaveis.
  # Sinceramente não testei depois desses ajustes, existe a possibilidade que algo ficou quebrado.
	$targetFormat = 'jpg'
	$sourceFormat = 'png'
	$totalSizeSelected = 0
	$totalSize = 0
	$totalCount = 0
	$webmFilesSize = 0
	$webmFilesCounter = 0
	$unknownFilesSize = 0
	$unknownFilesCounter = 0
	
	# Informa as opções selecionadas
	Write-Host "Caminho alvo:" $targetPath
	Write-Host "Qualidade selecionada:" $quality
	Write-Host "Tamanho minimo selecionado:" $targetSize
	
	dir -recurse -path $targetPath -include *.* | %{
		
		# Processa apenas arquivos jpg e png. Não coloquei como parametros pois no meu caso não havia necessidade.
		if (($_.Extension -eq '.'$targetFormat) -or ($_.Extension -eq '.'$sourceFormat)) {
			
			# Filtra os arquivos que não são grandes o suficiente.
			if (($_.length/1MB -ge $targetSize)) {
				$totalSizeSelected += ($_.length/1MB)
				$totalSize += ($_.length/1MB)
				$totalCount += 1
				
				magick $_.FullName -strip -quality $quality "$($_.Directory)\$($_.Basename).$targetFormat" # Converte os arquivos png para jpg usando a qualidade informada
				Write-Host "Converted file " $_.Name "|" ($_.length/1MB) "(tamanho antigo)"
				if ($_.Extension -eq '.png') {
					rm "$($_.Directory)\$($_.Basename).$sourceFormat" # Remove os arquivos pngs antigos
					Write-Host "PNG removed at " "$($_.Directory)\$($_.Basename).$sourceFormat"
				}
				
			# Adiciona os arquivos menores que $targetSize ao total
			} else {
				$totalSize += ($_.length/1MB)
				$totalCount += 1
			}
			
		# Formatos conhecidos que não são processados.		
		# Provavelmente ficaria melhor usando um array e um loop para verificar os formatos, mas não vi necessidade no meu caso.
		} elseif ($_.Extension -eq '.webm') {
			$webmFilesSize += ($_.length/1MB)
			$webmFilesCounter += 1	
			$totalCount += 1
		
		# Formatos desconhecidos. Também ocorre por erros devido a pontos no meio do nome do arquivo.
		# Talvez eu arrume um dia, mas não tenho necessidade no momento.
		} else {
			$unknownFilesSize += ($_.length/1MB)
			$unknownFilesCounter += 1	
			$totalCount += 1
		}
		
	}
	
	# Ficou em inglês msm, se alguem quiser traduzir fique a vontade.
	Write-Host "############FOLDER INFO BEFORE CONVERSION############"
	Write-Host "Total size of files: " $totalSize "|" ($totalSize/1GB) # A conversão de mb pra gb buga aqui, não sei o motivo e sinceramente não importa muito.
	Write-Host "Total size of selected files: " $totalSizeSelected "|" ($totalSizeSelected/1GB)
	Write-Host "Total size of files NOT in selection: " ($totalSize - $totalSizeSelected) "|" (($totalSize - $totalSizeSelected)/1GB)
	Write-Host  
	Write-Host "Number of webms: " $webmFilesCounter
	Write-Host "Total size of webms: " $webmFilesSize "|" ($webmFilesSize/1GB)
	Write-Host  
	Write-Host "Number of unknown file type: " $unknownFilesCounter
	Write-Host "Total size of unknown file type: " $unknownFilesSize "|" ($unknownFilesSize/1GB)	
	Write-Host  
	Write-Host "Number files: " $totalCount
	Write-Host "###################FOLDER INFO END###################"

	# Reseta as variaveis.
	$totalSizeSelected = 0
	$totalSize = 0
	$totalCount = 0
	$webmFilesSize = 0
	$webmFilesCounter = 0
	$unknownFilesSize = 0
	$unknownFilesCounter = 0
	
	# Checa o novo tamanho dos arquivos
	dir -recurse -path $targetPath -include *.* | %{
		
		# Processa apenas arquivos jpg e png. Não coloquei como parametros pois no meu caso não havia necessidade.
		if (($_.Extension -eq '.'$targetFormat) -or ($_.Extension -eq '.'$sourceFormat)) {
			
			# Filtra os arquivos que não são grandes o suficiente.
			if (($_.length/1MB -ge $targetSize)) {
				# Write-Host $_.Name "|" ($_.length/1MB)
				$totalSizeSelected += ($_.length/1MB)
				$totalSize += ($_.length/1MB)
				$totalCount += 1
			# Adiciona os arquivos menores que $targetSize ao total
			} else {
				$totalSize += ($_.length/1MB)
				$totalCount += 1
			}
			
		# Formatos conhecidos que não são processados.		
		# Provavelmente ficaria melhor usando um array e um loop para verificar os formatos, mas não vi necessidade no meu caso.
		} elseif ($_.Extension -eq '.webm') {
			$webmFilesSize += ($_.length/1MB)
			$webmFilesCounter += 1	
			$totalCount += 1
		
		# Formatos desconhecidos. Também ocorre por erros devido a pontos no meio do nome do arquivo.
		# Talvez eu arrume um dia, mas não tenho necessidade no momento.
		} else {
			$unknownFilesSize += ($_.length/1MB)
			$unknownFilesCounter += 1	
			$totalCount += 1
		}
		
	}
	

	Write-Host "############FOLDER INFO AFTER CONVERSION#############"
	Write-Host "Total size of files: " $totalSize "|" ($totalSize/1GB) # A conversão de mb pra gb buga aqui, não sei o motivo e sinceramente não importa muito.
	Write-Host "Total size of selected files: " $totalSizeSelected "|" ($totalSizeSelected/1GB)
	Write-Host "Total size of files NOT in selection: " ($totalSize - $totalSizeSelected) "|" (($totalSize - $totalSizeSelected)/1GB)
	Write-Host  
	Write-Host "Number of webms: " $webmFilesCounter
	Write-Host "Total size of webms: " $webmFilesSize "|" ($webmFilesSize/1GB)
	Write-Host  
	Write-Host "Number of unknown file type: " $unknownFilesCounter
	Write-Host "Total size of unknown file type: " $unknownFilesSize "|" ($unknownFilesSize/1GB)	
	Write-Host  
	Write-Host "Number files: " $totalCount
	Write-Host "###################FOLDER INFO END###################"


	# dir -recurse -path $targetPath -include *.jpg | %{}
}
