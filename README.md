# Networking2
Repository for the Networking2 project

Per provare il progetto:
- clona la repository
- vai nella cartella di riferimento con due terminali
- sudo mn -c
- chmod +x di tutti i file sh
- nel primo terminale ryu-manager controller.py
- nel secondo terminale suo python3 topology.py
- nel secondo terminale pingall

Scenario di default:
![](images/default.jpg)

Scenario 1 con switch 5 rotto:
![](images/scenario1.jpg)

scenario 2 con 4 host in più collegati:
![](images/scenario2.jpg)

Queste sono le quatità di banda richieste teoriche (se barrata vuol dire che non riesco ad ottenerla e c'è quella sostitutiva):
![](images/QoS.jpg)


##NB
import pillow library to run graphics