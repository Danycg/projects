# Crea un VPC personalizado
## Introducción
La idea de este manual es el mostrar como crear un VPC (Virtual Private Cloud) de forma personalizada.
Para ello vamos a empezar a entender que es un VPC (segun AWS):
Con Amazon Virtual Private Cloud (Amazon VPC), puede lanzar recursos de AWS en una red virtual aislada de manera lógica que haya definido. Esta red virtual es muy similar a la red tradicional que usaría en su propio centro de datos, pero con los beneficios que supone utilizar la infraestructura escalable de AWS.

En el siguiente diagrama se muestra una VPC de ejemplo. La VPC tiene una subred en cada zona de disponibilidad de la región, instancias de EC2 en cada subred y una puerta de enlace de Internet para permitir la comunicación entre los recursos en su VPC y la Internet.

![](./assets/aws_vpc.png)

### Características

Las siguientes funciones lo ayudan a configurar una VPC para proporcionar la conectividad que necesitan sus aplicaciones:

#### Nubes virtuales privadas (VPC)

    Una VPC es una red virtual prácticamente idéntica a una red tradicional que podría operar en su propio centro de datos. Una vez creada una VPC, podrá agregar las subredes.
#### Subredes

    Una subred es un rango de direcciones IP en su VPC. Una subred debe residir en una sola zona de disponibilidad. Después de agregar subredes, puede implementar recursos de AWS de su VPC.
#### Direccionamiento IP

    Puede asignar direcciones IP, IPv4 y IPv6, a las VPC y las subredes. También puede incorporar sus direcciones IPv4 públicas y GUA IPv6 a AWS y asignarlas a los recursos de su VPC, como las instancias de EC2, las puertas de enlace NAT y los equilibradores de carga de red.
#### Enrutamiento

    Use las tablas de enrutamiento para determinar dónde se dirige el tráfico de red de su subred o puerta de enlace.
#### Puertas de enlace y puntos de conexión

    Una puerta de enlace conecta su VPC a otra red. Por ejemplo, use una puerta de enlace de Internet para conectar la VPC a Internet. Use un punto de conexión de VPC para conectarse a Servicios de AWS de forma privada, sin el uso de una puerta de enlace de Internet o un dispositivo NAT.
#### Conexiones de emparejamiento

    Use una conexión de emparejamiento de VPC para enrutar el tráfico entre los recursos de dos VPC.
#### Replicación de tráfico

    Copie el tráfico de red desde las interfaces de red y envíelo a dispositivos de seguridad y monitoreo para una inspección profunda de paquetes.
#### Puertas de enlace de tránsito

    Use una puerta de enlace de tránsito, que actúa como un concentrador central, para enrutar el tráfico entre sus VPC, las conexiones de VPN y las conexiones de AWS Direct Connect.
#### Logs de flujo de VPC

    Los registros de flujo capturan información acerca del tráfico IP entrante y saliente de las interfaces de red en su VPC.
#### Conexiones de VPN

    Conecte sus VPC a las redes en las instalaciones mediante AWS Virtual Private Network (AWS VPN).

## Pasos

Vamos a crear un VPC con dos subredes.

Para ello vamos a seguir los siguientes pasos:

### Crear la VPC
En todos los laboratorios hay una VPC creada por defecto, nosotros vamos a crear una personalizada.

Dentro del laboratorio buscamos la palabra **VPC**, para que nos salga el panel con todas las opciones.

![](./assets/vpc_panel.png)

Pulsamos en la esquina superior la opción: `Crear VPC`.

![](./assets/vpc_crear.png)

En esta opción, seleccionamos:
- Solo la VPC
- Le damos un nombre en nuestro caso `2N
- Seleccionamos un bloque de IP's, en mi caso he elegido el de: 192.168.10.0/24
- Ir hasta el final y pulsar `Crear VPC`

Veremos un resumen de la VPC que acabamos de crear, junto con el mensaje de que se ha creado con éxito.

![](./assets/vpc_creada.png)

### Crear el gateway

Como hemos podido observar en la primera imagen necesitamos un gateway (puerta de enlace) con internet.

Para ello en nuestro panel de VPC de la izquierda elegimos: `Puertas de enlace de internet`.

Una vez abierto el panel pulsamos `Crear gateway de Internet` arriba a la derecha.

Nos mostrará el siguiente panel.
 
 ![](./assets/gateway_crear.png)

 En este panel completamos simplemente el nombre, en nuestro caso `2N-GATEWAY` y pulsamos el botón de  `Crear gateway de internet`.

 Una vez creada el `gateway` nos saldrá el siguiente panel.

 ![](./assets/gateway_creado.png)

 En este panel, arriba a la derecha, tenemos un botón de `Acciones`. 

 Una de las acciones es `Conectar a la VPC`, pulsamos esa opción, para unir la puerta de enlace (gateway) de internet con la **VPC** que hemos creado en el punto anterior.

![](./assets/gateway_vpc.png)

En este paso, sólo tenemos que seleccionar la `VPC` y pulsar `Conectar gateway de Internet`.

Aquí puedes ver como la configuración completa del gateway.

![](./assets/gateway_finail.png)

### Crear subredes

En este punto vamos a crear las subredes que van a utilizar los servicios de AWS dentro de nuestra VPC.

Nosotros vamos a crear cuatro subredes a partir de nuestra `192.168.10.0/24`.

Las subredes van a ser las siguientes:
- 192.168.10.0/26 (2N-A)
- 192.168.10.64/26 (2N-B)
- 192.168.10.128/26 (2N-C)
- 192.168.10.192/26 (2N-D)

Como seguimos dentro del `Panel de VPC` elegimos la opción de `Subredes` de entre las opciones de la izquierda.

En el nuevo panel, seleccionamos arriba a la derecha `Crear subred`.

![](./assets/subred_crear.png)

Aquí elegimos nuestra **VPC** y pulsamos `Crear subred`.

Se abre nuevos campos.

![](./assets/subred_crear2.png)

Aquí simplemente le damos un nombre a nuestra `subred`, elegimos una `Zona de disponibilidad` y configuramos la subred, según la tabla anterior.

Repetir estos pasos para las subredes: `2N-B`, `2N-C` y `2N-D`.

> Al terminar, deberiamos tener nuestras 4 subredes definidas.

![](./assets/subred_creada.png)

### Tabla de enrutamiento

Sólo nos queda configurar la tabla de enrutamiento para permitir el tráfico de internet hacia nuestra red interna.

En las opciones de la izquierda seleccionamos `Tablas de enrutamiento`.  
Vemos que se ha creado una entrada.

![](./assets/enruta_lista.png)

Pulsamos sobre el `ID de la tabla de enrutamiento` y pasamos a agregar reglas de direccionamiento.

> En nuestro caso hay que añadir `0.0.0.0/0` a nuestro gateway `2N-GATEWAY`.  

Vamos a ello.

A la derecha-abajo tenemos la opción de `Editar rutas`, pulsamos sobre ella y ahora pulsamos sobre `Agregar ruta`.  

Esto nos abrirá una nueva entrada para completar.

![](./assets/enruta_crea.png)

Como podemos ver completamos los campos resaltados y pulsamos `Guardar cambios`.

Ahora tenemos la siguiente imagen.

![](./assets/enruta_creado.png)

En la que podemos ver nuestra nueva regla.


## Resumen

Si pulsamos sobre la `VPC` creada, nos saldrá un resumen como el que se muestra a continuación.

![](./assets/vpc_completa.png)

En la parte inferior, se puede ver un mapa de las conexiones.




