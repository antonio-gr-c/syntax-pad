<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import 'prismjs/themes/prism-tomorrow.css';

export default {
}
</script>

<style>
#app {
  font-family: "Host Grotesk", sans-serif;
  font-optical-sizing: auto;
  font-weight: 200;
  font-style: normal;
  background-color: #333; /* Color de fondo */
  min-height: 100vh; /* Asegura que ocupe toda la altura de la pantalla */
  margin: 0; /* Elimina cualquier margen predeterminado */
}

/* Personalización de los íconos de añadir (+) y ajustes (tune) */
.editor-content .ce-toolbar__plus,
.editor-content .ce-settings__button,
.editor-content .ce-toolbar__settings-btn {
  color: #f5f5f5 !important; /* Cambia el color del ícono a blanco */
  background-color: transparent !important; /* Fondo transparente */
}

/* Efecto hover para los íconos */
.editor-content .ce-toolbar__plus:hover,
.editor-content .ce-settings__button:hover,
.editor-content .ce-toolbar__settings-btn:hover {
  color: #00bcd4 !important; /* Cambia el color al pasar el mouse (opcional) */
  background-color: rgba(255, 255, 255, 0.1) !important; /* Fondo translúcido */
}

</style>