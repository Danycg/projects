# EC2
## ¿Qué es Amazon Elastic Compute Cloud (Amazon EC2)?

Amazon EC2 es un servicio web que proporciona capacidad de computación en la nube y de tamaño modificable. Está diseñado para facilitar a los desarrolladores recursos de computación escalables basados en web.

Amazon Elastic Compute Cloud (Amazon EC2) ofrece la plataforma de computación más amplia y completa, con más de 750 instancias y la posibilidad de elegir el procesador, almacenamiento, redes, sistema operativo y modelo de compra más reciente, en función de lo que mejor se ajuste a las necesidades que plantea su carga de trabajo. Somos el primer proveedor de servicios en la nube destacado que admite procesadores Intel, AMD y ARM, la única nube con instancias Mac de EC2 bajo demanda y la única nube con redes Ethernet de 400 Gbps. Ofrecemos el mejor rendimiento por precio para la formación con machine learning, así como el menor costo por instancias de inferencia en la nube. Se ejecutan más cargas de trabajo de SAP, computación de alto rendimiento (HPC), ML y Windows en AWS que en cualquier otra nube. 

## Pasos
### 1.- Acceso
Primero de todo vamos al panel EC2 de nuestra cuenta.
Podemos acceder a nuestras **maquinas virtuales** por cualquiera de las dos opciones resaltadas en la imágen.

![](./assets/ec2_panel.png)

Una vez dentro nos sale el panel con las máquina virtuales que tengamos y su estado. En este caso está vacio.

![](./assets/ec2_instancias_vacia.png)

Para empezar nos vamos al botón ***Lanzar instancias***. Que podemos encontrar en la esquina superior derecha.

Para mostrarnos el panel para la creación de maquinas virtuales.
### 2.- Elección de sistema operativo.
En la ventana para elegir el sistems operativo, primero de todo, hay que darle un nombre a nuestra máquina, no es obligatorio, pero sí recomendable si vamos a tener más de una máquina virtual en nuestras instancias, para distinguirlas.
En nuestro caso vamos a seleccionar una máquina tipo `Ubuntu Server` y le vamos a poner de nombre `Linux` (nombre original).

![](./assets/ec2_nombre_so.png)

### 3.- Tipos de instancia
Una vez seleccionado el sistema operativo, nos toca elegir el tipo de instancias. Es decir, el `hardware` de la máquina, en este caso incluya memoria RAM y CPU. Hay que tener en cuenta que no se puede usar cualquier tipo de instancia, sólo la que nos permite nuestra capa gratuita. 
Como **recomendación** sugiero utilizar una instancia de tipo: `t3.` + micro, small, medium, large, ....

![](./assets/ec2_linuxserver.png)

En nuestro caso y para una instancia de `Ubuntu Server` con una instancia de tipo `t3.micro / t3.small` es suficiente, sin embargo para una máquina `Windows Server`, recomiendo una instancia de tipo `t3.medium / t3.large`.

![](./assets/ec2_instancia.png)

### 4.- Par de claves

Ahora nos toca seleccionar un par de claves para cifrar la información.
Un par de claves, que consta de una clave pública y una clave privada, es un conjunto de credenciales de seguridad que se utiliza para demostrar su identidad cuando se conecta a una instancia de Amazon EC2. En el caso de las instancias de Linux, la clave privada le permite utilizar SSH para conectarse de forma segura a la instancia. Para las instancias de Windows, se requiere la clave privada para descifrar la contraseña del administrador, que después utilizará para conectarse a la instancia.

## Windows
## Linux