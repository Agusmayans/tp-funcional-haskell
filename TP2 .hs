import Text.Show.Functions
type Bebida = Cliente->Cliente
type Acciones = Cliente->Cliente 
data Cliente = Cliente {nombre::String, resistencia::Int, amigos::[Cliente],bebidas::[Bebida]} deriving (Show)
data Intinerario = Intinerario{horas::Float, acciones::[Acciones]}

--Decidimos utilizar este tipo de dato "data" porque es más declarativo e intuitivo que el tipo de data tuplas, y además 
--cualquier persona que lea el tipo de dato, puede identificar a que tipo de dato corresponde cada elemento de la "data Cliente".

--clientes:
rodri = Cliente {nombre="Rodri", resistencia=55,amigos=[], bebidas=[tintico]}
marcos = Cliente {nombre="Marcos", resistencia=40 ,amigos=[rodri], bebidas=[klusener "guinda"]}
cristian = Cliente {nombre="Cristian", resistencia=2 ,amigos=[], bebidas=[grogxd,jarraloca]}
ana = Cliente {nombre="Ana", resistencia=120 ,amigos=[marcos,rodri], bebidas=[]}
robertoCarlos = Cliente { nombre="Roberto Carlos", resistencia=165, amigos=[], bebidas=[]}

--itinerarios:
mezclaExplosiva = Intinerario{horas=2.5,acciones=[tomar grogxd,tomar grogxd,tomar (klusener "huevo"),tomar (klusener "frutilla")]}
itinerarioBasico = Intinerario{horas=5,acciones=[tomar jarraloca,tomar (klusener "chocolate"),rescatarse 2, tomar (klusener "huevo")]}
salidaDeAmigos = Intinerario{horas=1,acciones=[tomar (soda 1), tomar tintico, (flip reconocerAmigo) robertoCarlos,tomar jarraloca]}

cantidadAmigos persona = (length.amigos) persona
esAmigo cliente amigo =  elem (nombre amigo) (nombreAmigos cliente)
nombreAmigos cliente = map nombre (amigos cliente)
puedeAgregar cliente amigo = not(esAmigo cliente amigo) && (nombre cliente /= nombre amigo)
agregarAmigo cliente amigo = cliente{amigos = amigo : amigos cliente}

reconocerAmigo cliente amigo
    |puedeAgregar cliente amigo = agregarAmigo cliente amigo
    |otherwise = cliente

comoEsta cliente 
    |  ((>50).resistencia) cliente = "fresco"
    | ((>1).length.amigos) cliente = "piola"
    | otherwise = "duro"

bajarResistencia cant cliente  = cliente{resistencia = (resistencia cliente) - cant  } 
subirResistencia cant cliente  = cliente{resistencia = (resistencia cliente) + cant  } 

--bebidas
grogxd cliente = cliente{resistencia=0}

bajarResistenciaAmigos cliente = cliente{amigos=(map (bajarResistencia 10 ) (amigos cliente))}

jarraloca cliente =   bajarResistenciaAmigos(bajarResistencia 10 cliente)

klusener gusto = bajarResistencia  (length gusto)

tintico cliente = subirResistencia  (5* cantidadAmigos cliente) cliente  

soda  fuerza cliente= cliente{nombre = erepea fuerza++(nombre cliente)}

erepea fuerza = "e"++ (replicate fuerza 'r') ++ "p" 

--punto 1
tomar f cliente = (f cliente){bebidas=(bebidas cliente) ++ [f]} 
tomarTragos (f:fs) cliente = tomarTragos fs (tomar f cliente) 
tomarTragos [] cliente = cliente

cantidadBebidas cliente = (length.bebidas)cliente
ultimaBebida cliente=(last.bebidas)cliente



dameOtro cliente = ((tomar.ultimaBebida) cliente) cliente 

puedeTomar cliente trago = resistencia (tomar trago cliente) >0 
cualesPuedeTomar cliente tragos = filter(puedeTomar cliente) tragos 
cuantasPuedeTomar cliente tragos = (length.cualesPuedeTomar cliente)  tragos 
rescatarse horas 
    | horas > 3 = subirResistencia 200 
    | otherwise = subirResistencia 100  



itinerario (Intinerario h  (f:fs)) cliente = itinerario (Intinerario h  (fs)) (f cliente)
itinerario (Intinerario _  [] )cliente = cliente

--calcularIntensidad itinerario = length (acciones itinerario) / horas itinerario