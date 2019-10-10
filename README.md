# WAVEVISUALIZER

### MANUAL DE USUARIO

29 DE NOVIEMBRE DE 2 018
MARIO ACEBES CALZADA - GONZALO PARDO VILLALIBRE
ETSIT – UNIVERSIDAD DE VALLADOLID

```
ETSIT – UNIVERSIDAD DE VALLADOLID
```
```
ETSIT – UNIVERSIDAD DE VALLADOLID
```

## ÍNDICE

## PRELUDIO _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 1

## FUNCIONALIDADES

## INTERFAZ PRINCIPAL _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 3

## CREACIÓN DE UNA NUEVA ONDA DE SONIDO _ _ _ _ _ _ _ _ _ _ _ _ _ _ 6

## HERRAMIENTAS _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 9


## PRELUDIO

Bienvenido al manual de usuario de la máquina ‘ **Wavevisualizer** ’, la interfaz virtual con la que podrá realizar diferentes
tratamientos generalizados y específicos de señales. En esta guía ilustrada podrá encontrar toda la información
necesaria para el manejo avanzado de nuestra aplicación.

‘Wavevisualizer’ es una interfaz dedicada y pensada para usuarios de nivel medio-alto en conocimiento en tratamiento
y procesado de señales de comunicación.

Para la elaboración de esta interfaz hemos utilizado el lenguaje de programación Matlab (Matrix Laboratory), con la
herramienta de interfaz gráfica “GUIDE”. Además ‘Wavevisualizer’ sigue las enseñanzas de la escuela de Código Libre
por lo que se incluirá el código en la parte final de esta guía por si algún usuario quisiera modificarlo o implementarlo
de diferente manera en su propio sistema.

Sin nada más que añadir pasamos a la explicación detallada de todas las funcionalidades de nuestro sistema, cualquier
duda, mejora propuesta o consulta puede ser enviada al correo de los desarrolladores gonzalo.pardo@tel.uva.es y
mario.acebes@tel.uva.es, agradecemos su colaboración para que este proyecto llegue o más lejos posible.


## FUNCIONALIDADES

#### INTERFAZ PRINCIPAL

```
Interfaz principal de “Wavevisualizer”
```
A continuación, se procede con la descripción física y de uso de los elementos de la interfaz:

- **Etiqueta “Archivo”:** Sirve para manejar archivos:
    - **Abrir:** Permite al usuario cargar una señal de audio previamente creada.
    - **Nuevo:** Permite al usuario generar una nueva señal de audio.
    - **Guardar:** Permite al usuario guardar la señal que se encuentra en el display superior.
- **Etiqueta “Herramientas”:** Permite al usuario elegir una de las múltiples herramientas.


```
Puesto que el programa permite al usuario trabajar con varias señales de audio a la vez, cabe distinguir
entre dos tipos de herramientas:
o Herramientas que editan la señal principal :
▪ Datos.
▪ Interpolación y diezmado.
▪ Parámetros de reproducción.
Estas herramientas sólo podrán ser usadas si previamente se ha realizado la carga de una
señal de audio. Con la carga de una nueva señal estas herramientas estarán enfocadas a la
nueva señal, por tanto, antes de cargar una señal se recomienda al usuario guardar la antigua.
o Herramientas que conciernen a señales no mostradas en el display:
▪ Modulador
▪ Demodulador.
▪ Sumador.
▪ Concatenador.
▪ Filtrado de señales.
Estas herramientas no modifican el estado de la señal principal hasta que se realiza la
operación deseada, esto permite editar la señal principal siempre y cuando no se confirme la
una operación referida a estas herramientas. El programa se encargará de recordar al usuario
cuándo la señal principal va a “perderse” por si éste desea guardarla previamente.
```
- **Etiqueta “Help”:** Para más información se ha puesto a disposición del usuario la etiqueta “help” que
    redirecciona al usuario al canal de YouTube del programa donde podrá encontrar videos explicativos.
- **Display en tiempo:** Identificado en la figura con un recuadro de color rojo muestra la edición de la señal
    principal del sistema en tiempo.
- **Display en frecuencia:** Identificado en la figura con un recuadro de color amarillo muestra la edición de
    la señal principal del sistema en frecuencia. Presenta las siguientes opciones:
       o Espectrograma: muestra el espectrograma de la señal principal.
       o FFT: muestra la transformada de Fourier de la señal principal.
       o Densidad espectral de potencia: muestra la DEP de la señal principal.
    Además, para la opción de FFT y DEP el programa permite la representación de la señal en dBs además
    de en unidades naturales.
- **Displays de herramientas:** Identificados en la figura con recuadros de color verde permiten al usuario
    desplegar las diferentes herramientas con las que quiera trabajar. El programa permite un máximo de
    tres herramientas a la vez que se irán desplegando dinámicamente.
    Cuando haya tres herramientas el usuario deberá indicar qué herramienta quiere eliminar para desplegar
    una nueva.


```
Ejemplo de apertura de una cuarta herramienta
```
La herramienta **“Filtrado de Señales”** por complejidad dispone de una interfaz particular y funciona de
forma independiente al resto de herramientas. Su explicación se realizará de manera más detallada a lo
largo del documento.


#### CREACIÓN DE UNA NUEVA ONDA DE SONIDO

Esta herramienta permite crear de forma fácil e intuitiva ondas de sonido a gusto de usuario. Para ello el
usuario deberá acceder a la funcionalidad mediante:

1. Archivo-> Nuevo - > (Seleccionar opción)
- **Grabación por micrófono**

```
El programa permite al usuario grabar por micrófono su propia voz en formato mono. La interfaz que
ve el usuario es la siguiente:
```
```
Display de la herramienta “grabar”
```
“ **Play** ”:

```
▪ Comenzar a grabar audio al principio de la grabación o reanudar la grabación (botón
lateral izquierdo).
▪ Reproducir pista grabada (botón en la posición central).
```
```
“ Reload ”:
▪ Realizar una nueva grabación.
```
```
” Pause ”:
▪ Pausar la grabación.
```
```
” Stop ”:
▪ Finalizar la grabación para ver el resultado.
Para guardar la nueva señal de audio se utilizará el botón guardar. En caso de querer abandonar la
grabación el usuario deberá pulsar el botón cancelar.
```

- **Creación de onda determinista**

```
La herramienta “Onda determinista” permite al usuario crear una onda de forma fácil y sencilla. El control
de la interfaz es el siguiente:
```
```
Display de la herramienta “Onda Determinista”
```
El usuario deberá decidir la **forma** de la onda y los diferentes parámetros antes de realizar la construcción
de la misma. Una vez todos hayan sido seleccionados, el fondo de la casilla pertinente se volverá de color
verde. Si el usuario desea construir una onda **periódica** debe marcar la casilla destinada a ese fin y
determinar un número de periodos.

Cuando todos los parámetros hayan sido seleccionados bastará con pulsar **“Dibujar”** para concluir la
construcción. Si el usuario quiere modificar cualquier parámetro deberá realizar los cambios pertinentes y
pulsar de nuevo el botón “ **Dibujar** ”.

Para guardar la onda creada el usuario deberá dirigirse al icono situado en la esquina superior
izquierda y seleccionar la ruta deseada.


- **Creación de onda personaliza**

```
Esta funcionalidad permite diseñar una onda en el dominio del tiempo a gusto del usuario, se advierte al
mismo de la complejidad de la misma. A continuación, se adjunta una explicación detallada de la
herramienta:
```
```
Display de la herramienta “Onda Personalizada”
```
Los puntos **inicio** y **final** marcan el intervalo donde se evalúa el FunctionHandle que debe ser introducido de
manera correcta en la casilla central marcada inicialmente con **“@(x)”.**

Es **muy importante** introducir el formato de la función de manera correcta, algunos ejemplos de uso son:

- @(x) cos(x).
- @(x) x +1.

Si el usuario desea introducir una función **constante** deberá realizarlo de la siguiente manera:

- @(x) A*ones(size(x)). A= valor constante deseado.

La herramienta también permite encadenar sucesivamente diferentes evaluaciones; cuando el usuario pulse
el botón se añadirá la nueva parte a la señal ya creada en anteriores sucesiones.

Con el objetivo de guardar su creación el usuario deberá pulsar el botón y, a continuación, seleccionar
la ruta deseada.

NOTA: El usuario no debe dudar sobre la validez de su functionhandle; en caso de no ser válido el programa
se encargará de notificarlo.


#### HERRAMIENTAS

- **Datos**
    Esta herramienta nos permite visualizar las magnitudes físicas más relevantes de la **señal principal** del
    sistema. El usuario podrá además generar un informe de los mismos que se guardará en la carpeta
    “Informes” bajo la referencia “Informe-NombrePista.wav.txt”.

```
Display de la herramienta “Datos”
```
- **Modulador**
    El sistema permite al usuario modular una señal de audio de dos formas diferentes “ **AM** ” y “ **FM** ”. La
    señal a modular es independiente de la señal principal del sistema de modo que el usuario podrá trabajar
    con ambas en paralelo y se podrá seleccionar mediante el botón “ **Seleccionar señal** ”. El valor de la
    portadora de la modulación ha sido seleccionado previamente por nuestros programadores de modo
    que la modulación sea óptima. Para modular cualquier señal el usuario sólo deberá pulsar el botón del
    tipo de demodulación que se tornará de color verde y continuación pulsar el botón “ **MODULAR** ”.

```
El usuario además tiene la posibilidad de añadir una cierta componente de ruido gaussiano blanco de
valor relativo, de tal forma que el usuario puede contemplar el efecto del un ruido leve que se añadiría
en una transmisión ficticia de la señal modulada. Del mismo modo el usuario deberá pulsar el botón
“ Añadir ruido blanco ” que adquiere un tono verde y pulsar modular.
```
```
La señal modulada sustituirá a la señal principal del sistema. El diseñador recomienda al usuario guardar
la señal principal que va a ser sustituida por la suma.
```
```
Display de la herramienta “Modulación”
```

- **Demodulador**
    El sistema permite al usuario demodular una señal de audio de dos formas diferentes “ **AM** ” y “ **FM** ”. La
    señal a demodular es independiente de la señal principal del sistema de modo que el usuario podrá
    trabajar con ambas en paralelo y se podrá seleccionar mediante el botón “ **Seleccionar señal** ”. El valor de
    la portadora de la demodulación concuerda con el valor de la modulación de manera que el método es
    prácticamente automático facilitando el trabajo del usuario. Para demodular cualquier señal el usuario
    deberá pulsar el botón del tipo de demodulación que se tornará de color verde y continuación pulsar el
    botón “ **DEMODULAR** ”.

```
La señal modulada sustituirá a la señal principal del sistema. El diseñador recomienda al usuario guardar
la señal principal que va a ser sustituida por la suma.
```
```
Display de la herramienta “Demodulación”
```
- **Sumador de señales**
    El sistema permite al usuario sumar hasta 6 señales entre sí. Para el usuario la suma se realizará de forma
    transparente; no obstante, es importante que el usuario sea consciente de que, a la hora de sumar
    señales con diferente frecuencia de muestro, el programa realiza un _resampling_ a una frecuencia común
    (44100Hz).

```
Para realizar la suma el usuario deberá pulsar cualquier tecla con el nombre “ Señal X ” y seleccionar el
path de una señal de audio. Si se produce un error en la carga el usuario visualiza un mensaje en este
mismo campo de “Error”; en caso de producirse la carga correctamente el usuario verá el nombre de la
pista seleccionada en este campo.
```
```
Cuando todas las señales deseadas hayan sido seleccionadas el usuario debe pulsar el botón “ SUMAR ”.
Hasta este punto las operaciones de carga de señales no han afectado a la señal principal, no obstante,
en este punto ésta se verá sustituida por la suma. El diseñador recomienda al usuario guardar la señal
principal que va a ser sustituida por la suma.
```
```
Display de la herramienta “Sumador de Señales”
```

- **Concatenador de señales**
    El sistema permite al usuario concatenar hasta 6 señales entre sí. Para el usuario la concatenación se
    realizará de forma transparente; no obstante, es importante que el usuario sea consciente de que, a la
    hora de concatenar señales con diferente frecuencia de muestro, el programa realiza un _resampling_ a
    una frecuencia común (44100Hz).
    Para realizar la concatenación el usuario deberá pulsar cualquier tecla con el nombre “ **Señal X** ” y
    seleccionar el path de una señal de audio. Si se produce un error en la carga el usuario visualiza un
    mensaje en este mismo campo de “Error”; en caso de producirse la carga correctamente el usuario verá
    el nombre de la pista seleccionada en este campo.
    Cuando todas las señales deseadas hayan sido seleccionadas el usuario debe pulsar el botón
    “ **CONCATENAR** ”. Hasta este punto las operaciones de carga de señales no han afectado a la señal
    principal, no obstante, en este punto ésta se verá sustituida por la concatenación. **El diseñador**
    **recomienda al usuario guardar la señal principal que va a ser sustituida por la suma.**

```
Display del concatenador de señales
```
- **Interpolación y diezmado**
    El sistema permite al usuario interpolar y diezmar una señal, de este modo el usuario podrá modificar a
    su gusto la frecuencia de muestreo de la señal. Para ello el usuario deberá introducir en los campos de
    **“factor de interpolación”** o **“factor de diezmado”** un número entero. A continuación, deberá pulsar la
    tecla **“interpolar”** o **“diezmar”** dependiendo de la opción deseada.

```
En este caso el usuario está trabajando con la señal principal del sistema, por tanto, el programador se
abstiene de hacer recomendaciones.
```
```
Display de la herramienta de interpolación y diezmado
```

- **Parámetros de Reproducción**

```
Esta herramienta permite al usuario reproducir cualquier señal de audio que haya sido previamente
grabada. Los controles de reproducción son los siguientes:
```
“ **Play** ”:

```
▪ Comenzar la reproducción de audio
▪ Reproducir pista grabada (botón en la posición central).
```
```
“ Reload ”:
▪ Comenzar de nuevo con la reproducción.
```
```
”Pause”:
▪ Pausar la reproducción.
Además, esta herramienta también permite aumentar la velocidad de reproducción. Para ello el usuario
deberá meter un número racional en el apartado ocupado inicialmente por una ‘A’; que se tornará de
color verde, indicando que el programa ha realizado correctamente la lectura del parámetro. Acto
seguido el usuario deberá pulsar el botón “ Modificar velocidad de reproducción ” para confirmar el
cambio realizado sobre la señal principal.
En adición, la interfaz permite al usuario invertir temporalmente la señal principal sin más que pulsar el
botón “ Invertir temporalmente ”.
```
```
Ejemplos del display “Parámetros de reproducción” en diferentes estados
```
- **Filtrado de señales**

```
Llegados a este punto cabe destacar la importancia del filtrado en un procesado de señal, tanto procesos de
interpolado, modulación mediante portadora, además de procesados involuntarios como puede ser la adquisición
de ruido en un proceso de transmisión requieren un proceso de filtrado en pos de recuperar la señal original o
deseada. También puede ser empleada esta herramienta con el fin de separar frecuencias en el dominio de la
transformada de Fourier o en frecuencia para aplicaciones tales como un decodificador de radio FM, procedemos
a la explicación de las utilidades de esta herramienta:
o Barra de herramientas :
En la barra de Herramientas podemos encontrar dos pestañas iniciales, una de ellas desplegable con
otras 3 funciones más como podemos ver en la imagen 2.
```

```
Barra Herramientas Barra Herramientas Desplegada
```
o **Ventanas de visualización** :
Nuestro sistema de filtrado presenta 2 ventanas de visualización, la primera de ellas está destinada a la
presentación en frecuencia de la onda seleccionada, en ella podemos ver una escala en el eje X en Hercios
y un eje vertical escalado en potencia.

```
Gráfica 1 con señal de audio “Aguila00.wav” impresa en frecuencia.
```
```
Otra funcionalidad asociada a nuestra gráfica 1 es la de presentar el filtro construido sobre la señal en
frecuencia que queramos manipular, esto ocurrirá una vez se pulse el botón ‘Actualizar Filtro’, el cual
explicaremos posteriormente. El programa mostrará la respuesta al impulso del filtro en el eje positivo de las
frecuencias y se encuentra normalizado a la altura de la señal que quereos procesar para mayor comodidad y
facilidad de visualización. En la siguiente figura podemos ver un ejemplo sencillo.
```
```
Representación de un filtro pasa-banda de Chebyshev sobre ‘Aguila02.wav’.
```

```
Aparte de la primera ventana de visualización se presenta también otra ventana del mismo tamaño para la
impresión exclusiva de la señal resultante de nuestro procesamiento, séase la señal filtrada con el filtro
seleccionado en el dominio de la frecuencia. En la siguiente figura podemos observar el resultado de emplear
el filtro de la Figura 4 sobre la señal ‘Aguila02.wav’.
```
```
Señal resultante al aplicar la señal y el filtro de la Figura 4
```
o **Selección del filtro** :
Lo siguiente que podemos encontrar en la herramienta de filtrado serán dos pequeños formularios que
sirven para registrar el filtro que deseamos aplicar a nuestra señal. En el primer formulario encontramos
la ayuda “Seleccione el tipo de filtro” que hace referencia a la aproximación que queremos darle a nuestro
filtro. En él encontramos 3 opciones diferentes 1. Filtro de Butterworth: el cual hace una aproximación al
método de butterworth, que buscaba obtener como requisito principal una respuesta plana en la banda
de paso. 2. Filtro de Chebyshev: en este caso se busca una aproximación de nuestro filtro al que
conseguiríamos a través de las series de Chebyshev. 3. Filtro de Cauer: Esta es una aproximación a la
respuesta de la síntesis eléctrica de un filtro que propuso Wilhelm Cauer.

```
En el segundo formulario podemos observar la ayuda “Seleccione el tipo de filtrado”, el cual hace
referencia a si deseamos un filtro con características de Paso bajo, Paso alto de frecuencias o Paso de una
banda concreta de frecuencias.
```
```
Aproximación deseada del filtro Banda de paso del filtro
```
o **Características del filtro** :
Una vez escogido, pasamos a introducir los valores que queremos para nuestro filtro. En la parte superior
derecha de nuestra interfaz podemos encontrar otro formulario con cajas con valores a rellenar, existen
un total de 6 valores distintos a introducir, aunque dos de ellos no serán accesibles a no ser que se
seleccione la opción ‘Filtro Paso Banda’. Los valores a rellenar serán:


1. “Frecuencia de paso inicial”: este valor se encuentra inicialmente oculto para cualquier filtro que
    no sea paso banda, en estos casos tomará un valor prefijado de 0 para filtro paso bajo e infinito
    para paso alto. [Hz]
2. “Frecuencia de paso final”: es la frecuencia límite para la banda de paso de nuestro filtro, junto
    con la frecuencia de paso inicial conforma la banda de paso total [ὠ 1 ὠ2]. Inicialmente tomará un
    valor referencia de 3000. [Hz]
3. “Frecuencia de parada inicial”: este valor se encuentra inicialmente oculto para cualquier filtro
    que no sea paso banda, en estos casos tomará un valor prefijado de infinito para filtro paso bajo
    y 0 para paso alto. [Hz]
4. “Frecuencia de parada final”: es la frecuencia límite para la banda de parada de nuestro filtro,
    junto con la frecuencia de parada inicial conforma la banda de parada total [ὠs1 ὠs2]. Inicialmente
    tomará un valor referencia de 5000. Existe una condición imprescindible para el funcionamiento
    del filtro y es que la banda de paso debe estar comprendida entre la banda de parada, si no los
    parámetros del filtro no serán realizables (ὠs1 < ὠ1 < ὠ2 < ὠs2). [Hz]
5. “Atenuación en banda de paso”: Este campo hace referencia a cuanto puede estar reducida como
    mucho la señal en la banda de paso, si el valor de este campo es 3, la frecuencia de paso final
    coincidirá con la frecuencia de corte del filtro. [dB]
6. “Atenuación en la banda de parada”: Este campo hace referencia a cual es la atenuación mínima
    que ha de presentar nuestro filtro en la banda de parada. Inicialmente se muestra un valor guía
    de 20. [dB]

```
Características del filtro
Cabe señalar que para saber si el valor de las características ha sido actualizado se presentará la caja de color
verde, dando como válido el valor en su contenido.
```
```
Actualización de valores característicos del filtro
```
o **Botón de Actualizar filtro** :
En la esquina inferior derecha se presentan dos botones, uno de ellos presenta la etiqueta “Actualizar
filtro” y lo que hace es generar el filtro que se ajusta a un orden menor según las características y el tipo
proporcionados, acto seguido se mostrará la respuesta al impulso de dicho filtro sobre la ventana 1 como
se mostraba en la Figura 4.


**Botón Actualiza Filtro**
o **Botón de Filtrado** :
Debajo del botón anterior encontraremos otro de igual tamaño con la etiqueta Filtro. Este botón
desencadena la función de filtrado introduciendo la señal temporal seleccionada en el filtro anteriormente
diseñado y mostrando su nuevo contenido espectral en la ventana 2, tal y como se muestra en la figura 5.


