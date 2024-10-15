# ProjectAbarrotes

## Descripción
**ProjectAbarrotes** es una aplicación web que utiliza **Java Server Pages (JSP)**, **Java Beans**, y el patrón **DAO (Data Access Object)** para gestionar la lógica de negocio. El proyecto se ejecuta en el servidor **Apache Tomcat** y está diseñado para realizar operaciones CRUD (Crear, Leer, Actualizar y Eliminar) en una base de datos de abarrotes.

## Requisitos Previos
### Software Necesario
1. **JDK** (Java Development Kit) 8 o superior. [Instalar JDK](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) / ```sudo pacman -S jdk-openjdk```
2. **Apache Tomcat** 10.1.31 [Descargar Tomcat](https://tomcat.apache.org/download-10.cgi) / ```yay -S tomcat  ``` o tambien ```sudo pacman -S tomcat10   ``` (EN lo personal no me funciono desde pacman lol

3. **IntelliJ IDEA ULTIMATE EDITION** con soporte para **Java EE**. [Descargar IntelliJ](https://www.jetbrains.com/idea/download). Con correo de estudiante nos dan 1 año gratis
4. **MySQL** o cualquier otro gestor de base de datos relacional compatible. [Descargar MySQL](https://dev.mysql.com/downloads/)
5. **Maven** (opcional, para gestión de dependencias).

### Dependencias
- **JSP API** y **Servlet API** (se incluyen con Tomcat).
- **JDBC** driver (por ejemplo, MySQL Connector si usas MySQL).

## Estructura del Proyecto
El proyecto tiene la siguiente estructura:

```
ProjectAbarrotes/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── com.projectabarrotes.beans/  # Java Beans
│   │   │   ├── com.projectabarrotes.dao/    # Clases DAO
│   │   │   └── com.projectabarrotes.servlets/ # Servlets
│   │   ├── resources/
│   │   │   └── database.properties          # Configuración de base de datos
│   │   └── web/
│   │       ├── WEB-INF/
│   │       │  └── web.xml                  # Descriptor de despliegue
│   └── test/
├── out/
│   └── artifacts/
│       └── PruebasTomcat/                   # Generación de artefactos
└── pom.xml                                  # Archivo Maven (si aplica)
```

## Configuración de Base de Datos
### MySQL
Crea una base de datos llamada `abarrotes_db` e importa las tablas necesarias. Un ejemplo de script SQL para crear una tabla podría ser:

```sql
SHOW DATABASES;
USE abarrotes_db;
CREATE TABLE Producto (
                          idProducto INT AUTO_INCREMENT PRIMARY KEY,
                          nombreProducto VARCHAR(255) NOT NULL,
                          descripcion TEXT,
                          presentacion VARCHAR(100),
                          caducidad DATE,
                          precioProv FLOAT,
                          precioUni FLOAT,
                          existencias INT,
                          fech DATE,
                          marca VARCHAR(100),
                          idProveedor INT,
                          idPaquete INT, -- Clave foránea para la tabla Paquete
                          idInventario INT -- Clave foránea para la tabla Inventario
);
-- Producto prueba
INSERT INTO Producto (nombreProducto, descripcion, presentacion, caducidad, precioProv, precioUni, existencias, fech, marca, idProveedor, idPaquete, idInventario)
VALUES (
           'Galletas de Chocolate',
           'Galletas con chispas de chocolate',
           'Paquete de 200g',
           '2025-12-31',
           10.50,
           15.00,
           100,
           '2024-10-11',
           'MarcaGenérica',
           1,
           1,
           1
       );

SELECT * FROM abarrotes_db.Producto;
=======
USE abarrotes_db;

CREATE TABLE Producto (
idProducto INT AUTO_INCREMENT PRIMARY KEY,
nombreProducto VARCHAR(255) NOT NULL,
descripcion TEXT,
presentacion VARCHAR(100),
caducidad DATE,
precioProv FLOAT,
precioUni FLOAT,
existencias INT,
fech DATE,
marca VARCHAR(100),
idProveedor INT,
idPaquete INT, -- Clave foránea para la tabla Paquete
idInventario INT -- Clave foránea para la tabla Inventario
);

-- Producto prueba
INSERT INTO Producto (nombreProducto, descripcion, presentacion, caducidad, precioProv, precioUni, existencias, fech, marca, idProveedor, idPaquete, idInventario)
VALUES (
'Galletas de Chocolate',
'Galletas con chispas de chocolate',
'Paquete de 200g',
'2025-12-31',
10.50,
15.00,
100,
'2024-10-11',
'MarcaGenérica',
1,
1,
1
);

SELECT * FROM abarrotes_db.Producto;

describe Producto
```

Asegúrate de tener el archivo `database.properties` configurado correctamente en el directorio `src/main/resources/`. Ejemplo:

```properties
jdbc.url=jdbc:mysql://localhost:3306/abarrotes_db
jdbc.username=root
jdbc.password=tu_contraseña
jdbc.driverClassName=com.mysql.cj.jdbc.Driver
```

## Configuración en IntelliJ
### Configurar el Artefacto WAR
**NOTA:** Recomiendo usar el artefacto de PruebasTomcat
1. **Crear el Artefacto WAR**:
   - Ve a **File → Project Structure → Artifacts**. O ctrl + alt + shift + s
   - Añade un nuevo **artifact** y selecciona **Web Application: Archive**.
   - Asegúrate de incluir los módulos necesarios como las clases `Java`, `JSP` y las librerías externas (JDBC driver).
   - Establece el directorio de salida para el archivo `.war`.
     **OJO PIOJO** Ya esta incluido PruebasTomcat.war SE RECOMIENDA USAR ESE

2. **Configurar Tomcat Server**:
   - Ve a **Run → Edit Configurations → + → Tomcat Server → Local**.
   - Selecciona el **artifact** que creaste anteriormente (`PruebasTomcat.war`).
   - Define el **context path** y asegúrate de que el servidor Tomcat esté correctamente configurado.

3. **Compilar y Ejecutar el Proyecto**:
   - Usa **Build → Rebuild Project** para compilar todo el proyecto y generar el archivo **WAR**.
   - Ejecuta el servidor Tomcat seleccionando **Run** desde la configuración de Tomcat.

## Pasos para Ejecutar el Proyecto
1. Clona el repositorio o descarga el código fuente.
   ```bash
   git clone https://github.com/tu-usuario/ProjectAbarrotes.git
   cd ProjectAbarrotes
   ```

2. Configura la base de datos en `src/main/resources/database.properties`.

3. Configura Tomcat en IntelliJ como se describió en la sección anterior.

4. Ejecuta el servidor Tomcat desde IntelliJ:
   - Ve a **Run → Edit Configurations** y selecciona la configuración de Tomcat.
   - Haz clic en **Run** o **Debug**.

5. Abre tu navegador y navega a:
   ```
   http://localhost:8080/PruebasTomcat/
   ```

###ATENCION ATENCION!!!!!
- El artefacto PruebasTomcat es el que ha sido probado, si quieres crear unoa delante
```
    <!-- Conexión a la base de datos -->
    <property name="hibernate.connection.driver_class">com.mysql.cj.jdbc.Driver</property>
    <property name="hibernate.connection.url">jdbc:mysql://localhost:3306/abarrotes_db</property>
    <property name="hibernate.connection.username">dante</property>
    <property name="hibernate.connection.password">180818</property>

```
- username es el que pusieron en mysql igual la contraseña, o ponen el mio o lo cambian sino no Jala

## Solución de Problemas
- **El `.war` no se genera**: Asegúrate de que el artefacto esté configurado correctamente en **Project Structure → Artifacts** y realiza un **Rebuild Project**.
- **Error de base de datos**: Verifica las credenciales y la conexión a la base de datos en el archivo `database.properties`.
- **Error de despliegue en Tomcat**: Consulta los **logs de Tomcat** en IntelliJ para más detalles o revisa el archivo `hs_err_pid.log`.
```
Error during artifact deployment. See server log for details.
com.intellij.javaee.oss.admin.jmx.JmxAdminException: com.intellij.execution.ExecutionException: /Users/dantealegria/Downloads/ProjectAbarrotes/out/artifacts/unnamed/unnamed.war not found for the web module.
```
- Verifica haber agregado correctamente el proyecto al artefacto

## Autor
**Dante Alegría**  
[GitHub](https://github.com/tu-usuario) | [LinkedIn](https://www.linkedin.com/in/tu-usuario)

---

Este **README** proporciona una guía completa para configurar y ejecutar tu proyecto **ProjectAbarrotes** en **Tomcat** usando **IntelliJ**.
![WhatsApp Image 2024-10-12 at 12 41 34 AM](https://github.com/user-attachments/assets/501f0c62-29f4-41eb-9cf7-8367b66e19fe)
