# Cómo instalar la pila Linux, Apache, MySQL y PHP (LAMP) en Ubuntu
### Introducción
Una pila “LAMP” es un conjunto de aplicaciones de software de código abierto que se suelen instalar juntas para que un servidor pueda alojar aplicaciones y sitios web dinámicos escritos en PHP. Este término es en realidad un acrónimo que representa al sistema operativo Linux, con el servidor web Apache. Los datos del sitio se almacenan en una base de datos MySQL y el contenido dinámico se procesa mediante PHP.

En esta guía, instalaremos una pila LAMP en un servidor Ubuntu 20.04 o superior.

## Paso 1: Instalar Apache y actualizar el firewall

El servidor web Apache está entre los más populares del mundo. Está bien documentado, tiene una comunidad de usuarios activa y ha sido muy utilizado durante gran parte de la historia de la web, por lo que es una excelente opción predeterminada para alojar sitios web.

Instale Apache usando el administrador de paquetes de Ubuntu, apt:

```sh
sudo apt update
sudo apt install apache2
```

Si es la primera vez que utiliza sudo en esta sesión, se le pedirá que proporcione su contraseña de usuario para confirmar que tenga los privilegios adecuados para administrar los paquetes del sistema con apt.  También se le solicitará que confirme la instalación de Apache al pulsar `Y` y `ENTER`.

Una vez que la instalación se complete, deberá ajustar la configuración de su firewall para permitir tráfico HTTP y HTTPS. UFW tiene diferentes perfiles de aplicaciones que puede aprovechar para hacerlo. Para enumerar todos los perfiles de aplicaciones de UFW disponibles, puede ejecutar lo siguiente:
```sh
sudo ufw app list
```

Verá un resultado como este:

