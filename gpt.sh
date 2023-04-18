#!/bin/bash

# Define la clave API del modelo de lenguaje
API_KEY="tu_clave_api"

# Función para enviar una solicitud HTTP a la API de OpenAI y obtener la respuesta
function send_request {
  RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${API_KEY}" \
       -d '{"prompt": "'"${1}"'", "max_tokens": 50, "temperature": 0.7}' \
       https://api.openai.com/v1/engines/davinci-codex/completions)
  echo $(echo $RESPONSE | jq -r '.choices[].text')
}

# Imprime un mensaje de bienvenida
echo "Bienvenido al ChatGPT de OpenAI. Ingresa tus mensajes a continuación (escribe 'salir' para salir)."

# Bucle infinito para leer la entrada del usuario y enviar solicitudes a la API de OpenAI
while true; do
  # Lee la entrada del usuario desde la consola
  read -p "Tú: " MESSAGE

  # Verifica si el usuario quiere salir
  if [ "$MESSAGE" == "salir" ]; then
    echo "¡Hasta luego!"
    exit 0
  fi

  # Envía la solicitud HTTP a la API de OpenAI y muestra la respuesta en la consola
  RESPONSE=$(send_request "$MESSAGE")
  echo "ChatGPT: $RESPONSE"
done
