# Ingresa una primera fila en la que se especifica la caracteristica de cada columna (se imprime unicamente una vez)
echo "Tiempo  %CPU_Libre  %Memoria_Libre  %Disco_Libre" > monitoreo.txt

#El siguiente proceso se realiza 5 veces
for i in {1..5}
 do
 #Para buscar la CPU usamos top, de lo que encuentra top filtramos lo correspondiente a la cpu y se usa el 8vo parametro
 cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
 #Cuando el octavo parametro es 100% hay un error e imprime "id," se soluciono asignando 100 cuando ocurre tal situacion
 if [ "$cpu" == "id," ]; then
  cpu=100
  fi
 #Para encontrar porcentaje de memoria y disco libre encontramos la memoria/disco libre, la multiplicamos *100 y se divide para el total de la misma 
 p_memoria_libre=$(($(free | grep Mem | awk '{print $4}')* 100 / $(free | grep Mem | awk '{print $2}'))) #Se usa free para ver datos varios incluido memoria, grep para filtrar aquellos de memoria y awk para tomar los parametros necesarios, para la libre es  el 4to parametro y para la total es el 2d0 parametro
 p_disco_libre=$(($(df / | tail -1 | awk '{print $4}') * 100 / $(df / | tail -1 | awk '{print $2}')))#Se usa df para ver datos varios incluido disco, tail -1 por que la ultima fila pertenece a disco y awk para tomar los parametros necesarios, para la libre es  el 4to parametro y para la total es el 2d0 parametro

#Ya recolectado todos los datos se ingresa una linea a monitoreo.txt con los datos obtenidos en el formato de la primera fila
 echo "$((i * 60))    $cpu    $p_memoria_libre    $p_disco_libre" >> monitoreo.txt

#pausa la ejecucion 60 segundos para tomar datos nuevamente luego
 sleep 60
#Unicamente imprime el numero de ciclo en el que está (no necesario)
 echo "Monitoreo N $i /5 completado"
 done
#Muestra el archivo en el que se guardaron los datos (no necesario)
cat monitoreo.txt
#Avisa que el proceso terminó y da el nombre del archivo donde se encuentran los datos (no necesario)
echo "Monitoreo completo. Los resultados se encuentran en monitoreo.txt"
