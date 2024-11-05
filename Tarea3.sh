echo "Tiempo  %CPU_Libre  %Memoria_Libre  %Disco_Libre" > monitoreo.txt
for i in {1..5}
do
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
if [ "$cpu" == "id," ]; then
      cpu=100
fi
p_memoria_libre=$(($(free | grep Mem | awk '{print $4}')* 100 / $(free | grep Mem | awk '{print $2}')))
p_disco_libre=$(($(df / | tail -1 | awk '{print $4}') * 100 / $(df / | tail -1 | awk '{print $2}')))
echo "$((i * 60))    $cpu    $p_memoria_libre    $p_disco_libre" >> monitoreo.txt
sleep 1
echo "Monitoreo N $i /5 completado"
done
cat monitoreo.txt
echo "Monitoreo completo. Los resultados se encuentran en monitoreo.txt"
