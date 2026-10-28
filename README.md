# Alexis: análisis de reportes

Aplicación local que recibe un reporte, lo clasifica con Supervisor Alexis en
Microsoft Foundry y lo deriva al Analista Financiero o al Analista Técnico. La página
presenta el resultado y puede leerlo en voz alta con la voz del navegador.

La app se ejecuta en `127.0.0.1`; no crea un servicio público. Los agentes existentes
son Voice Agents y se invocan por el WebSocket de voz administrado de Foundry. La
aplicación local coordina las llamadas: los agentes no se comunican directamente
entre sí mediante A2A.

## Requisitos

- macOS y Python 3
- Azure CLI, con una cuenta que pueda invocar los agentes del proyecto
- Un proyecto de Microsoft Foundry con los agentes configurados

## Preparación

1. Copia `.env.example` a `.env` y configura el endpoint del proyecto de Foundry y
   los nombres de los tres agentes.
2. Instala las dependencias:

   ```sh
   ./install-macos.sh
   ```

3. Inicia sesión en Azure si aún no lo has hecho:

   ```sh
   az login
   ```

4. Inicia la aplicación:

   ```sh
   ./start-macos.sh
   ```

5. Abre <http://127.0.0.1:8000>.

Para detener el servidor, pulsa **Control+C** en la terminal. La Mac debe permanecer
encendida mientras se utiliza la aplicación.

## Reportes y privacidad

Se aceptan PDF con texto, DOCX y TXT de hasta 15 MB. Los PDF escaneados requieren
OCR. El texto extraído y la pregunta opcional se envían a Microsoft Foundry. La
aplicación no conserva deliberadamente archivos ni historial; el servidor puede usar
almacenamiento temporal durante la carga.

No agregues a GitHub archivos `.env`, `.env.local`, credenciales, claves ni reportes
reales. `.gitignore` los excluye del repositorio. Antes de compartir un reporte,
confirma que tienes permiso para procesarlo con los servicios de Foundry.

## Más información

Consulta [INSTRUCTIONS.md](./INSTRUCTIONS.md) para ver instrucciones de los agentes,
configuración detallada y pruebas del flujo.
