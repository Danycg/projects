# Cómo instalar la pila Linux, Apache, MySQL y PHP (LAMP) en Ubuntu
### Introducción
Una pila “LAMP” es un conjunto de aplicaciones de software de código abierto que se suelen instalar juntas para que un servidor pueda alojar aplicaciones y sitios web dinámicos escritos en PHP. Este término es en realidad un acrónimo que representa al sistema operativo Linux, con el servidor web Apache. Los datos del sitio se almacenan en una base de datos MySQL y el contenido dinámico se procesa mediante PHP.

En esta guía, instalaremos una pila LAMP en un servidor Ubuntu 20.04 o superior.

## Paso 1: Instalar Apache y actualizar el firewall

El servidor web Apache está entre los más populares del mundo. Está bien documentado, tiene una comunidad de usuarios activa y ha sido muy utilizado durante gran parte de la historia de la web, por lo que es una excelente opción predeterminada para alojar sitios web.

Instale Apache usando el administrador de paquetes de Ubuntu, apt:

```sh
sudo apt update
sudo apt upgrade
sudo apt install apache2
```

Si es la primera vez que utiliza sudo en esta sesión, se le pedirá que proporcione su contraseña de usuario para confirmar que tenga los privilegios adecuados para administrar los paquetes del sistema con apt.  También se le solicitará que confirme la instalación de Apache al pulsar `Y` y `ENTER`.

Una vez que la instalación se complete, deberá ajustar la configuración de su firewall para permitir tráfico HTTP y HTTPS. UFW tiene diferentes perfiles de aplicaciones que puede aprovechar para hacerlo. Para enumerar todos los perfiles de aplicaciones de UFW disponibles, puede ejecutar lo siguiente:
```sh
sudo ufw app list
```

Verá un resultado como este:

![Salida ufw](./img/ufw.png)

A continuación, explicamos cada uno de estos perfiles:

   - Apache: este perfil abre solo el puerto `80` (tráfico web normal no cifrado).
   - Apache Full: este perfil abre los puertos `80` (tráfico web normal no cifrado) y `443` (tráfico TLS/SSL cifrado).
   - Apache Secure: este perfil abre solo el puerto `443` (tráfico TLS/SSL cifrado).

Por ahora, es mejor permitir conexiones únicamente en el puerto `80`, ya que se trata de una instalación nueva de Apache y todavía no tiene un certificado TLS/SSL configurado para permitir tráfico HTTPS en su servidor.

Para permitir tráfico únicamente en el puerto `80` utilice el perfil `Apache`, pero si queremos usar tanto el puerto `80` como el puerto `443` es necesario usar el perfil `Apache Full`, ten en cuenta que tambien se puede sustituir por  `http (80)` o por `https (443)`, en nuestro caso vamos a utilizar `Apache Full`:

```sh
sudo ufw allow "Apache Full"
```

Puede verificar el cambio con el siguiente comando:
```sh
sudo ufw status
```
Si nos sale que el error: `Status: inactive`

Eso significa que hay que activar **ufw**.

Para activar **ufw**, vamos a ejecutar el siguiente comando:
```sh
sudo ufw enable
```
Nos indicará que va a eliminar (disrupt) el puerto `ssh`.

Vamos a confirmar con `y`.

Al ejecutar de nuevo el comando:
```sh 
sudo ufw status
```
Ahora si vemos cual es el estado.
![Salida ufw](./img/ufw_status.png)

Para que en el futuro no tengamos problemas con el acceso remoto al equipo vamos a activar el puerto `22 (Open SSH)`, para ello vamos a ejecutar los siguientes comandos y luego veremos el estado.
```sh
sudo ufw allow openssh
```
La salida ahora sería:nu
![Ufw completo](./img/ufw_status_full.png)

Ahora, se permite tráfico en el puerto `80` a través del firewall.

Puede realizar una verificación rápida para comprobar que todo se haya realizado según lo previsto dirigiéndose a la dirección IP pública de su servidor en su navegador web (consulte la nota de la siguiente sección para saber cuál es su dirección IP pública si no dispone de esta información):
```sh
http://your_server_ip
```

Para ello vamos a ir a AWS y comprobar por una parte la configuración de seguridad de las reglas de entrada y por otra parte ver nuetra **IP pública**.

## Revisar configuración en AWS
Las reglas de configuración de seguridad de entrada, deben de ser la siguientes:
#### Reglas de seguridad de entrada
![Ufw completo](./img/grupo_seg_entrada.png)
### Ip pública
![Ufw completo](./img/ip_publica.png)

En este caso la ip pública es: **3.228.8.192**, con lo que si ejecutamos en el navegador de nuestro PC lo siguiente:
```sh
http://3.228.8.192
```
Nos debe aparecer la página inicial de nuestro servidor.

![Ufw completo](./img/default_page.png)

## Paso 2: Instalar MySQL
Ahora que dispone de un servidor web funcional, deberá instalar un sistema de base de datos para poder almacenar y gestionar los datos de su sitio. MySQL es un sistema de administración de bases de datos popular que se utiliza en entornos PHP.

Una vez más, utilice `apt` para adquirir e instalar este software:

```sh
sudo apt install mysql-server
```
Cuando se le solicite, confirme la instalación al escribir `Y` y, luego, `ENTER`.

Cuando la instalación se complete, se recomienda ejecutar una secuencia de comandos de seguridad que viene preinstalada en MySQL Con esta secuencia de comandos se eliminarán algunos ajustes predeterminados poco seguros y se bloqueará el acceso a su sistema de base de datos. Inicie la secuencia de comandos interactiva ejecutando lo siguiente:
```sh
sudo mysql_secure_installation
```


