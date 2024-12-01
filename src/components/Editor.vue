<template>
  <div class="editor-page">
    <!-- Menú -->
    <Menu />

    <!-- Banner -->
    <div class="banner" :style="{ backgroundImage: 'url(' + bannerImage + ')' }">
      <h1 class="banner-text">{{ materia }}</h1>
    </div>

    <!-- Editor -->
    <div id="editorjs" class="editor-content"></div>
  </div>
</template>

<script>
import Menu from "@/components/Menu.vue";
import axios from "axios";
import EditorJS from "@editorjs/editorjs";
import Header from "@editorjs/header";
import Code from "@editorjs/code";
import NestedList from "@editorjs/nested-list";
import Table from "@editorjs/table";
import Embed from "@editorjs/embed";
import Marker from "@editorjs/marker";
import Underline from "@editorjs/underline";
import InlineCode from "@editorjs/inline-code";
import Alert from "editorjs-alert";
import Delimiter from "@editorjs/delimiter";
import Hyperlink from "editorjs-hyperlink"; // Para hipervínculos
import InlineSpoiler from "editorjs-inline-spoiler-tool"; // Para spoilers
import Undo from "editorjs-undo"; // Historial de cambios

export default {
  components: {
    Menu,
  },
  data() {
    return {
      bannerImage: "https://cdn.pixabay.com/photo/2020/04/30/15/34/code-5113374_1280.jpg",
      materia: "Cargando...",
      editor: null,
      noteContent: null, // Contenido dinámico del editor
      isNoteExisting: false, // Indica si la nota ya existe en la base de datos
    };
  },
  methods: {
    async fetchMateria() {
      try {
        const idMateria = this.$route.query.id_materia;
        if (!idMateria) {
          throw new Error("El parámetro id_materia no está presente en la URL.");
        }
        const response = await axios.get(`https://backend-syntaxpad.onrender.com/api/materias/detalle/${idMateria}`);
        this.materia = response.data.materia;
      } catch (error) {
        console.error("Error al obtener la materia:", error);
        this.materia = "Materia no encontrada";
      }
    },
    async fetchNoteContent() {
      try {
        const idMateria = this.$route.query.id_materia;
        if (!idMateria) {
          throw new Error("El parámetro id_materia no está presente en la URL.");
        }
        const response = await axios.get(`https://backend-syntaxpad.onrender.com/api/notas/${idMateria}`);
        if (response.data.length > 0) {
          this.noteContent = JSON.parse(response.data[0].contenido); // Parsear contenido
          this.isNoteExisting = true; // La nota ya existe
        } else {
          console.log("No hay notas para esta materia.");
          this.noteContent = null;
          this.isNoteExisting = false; // La nota no existe
        }
      } catch (error) {
        console.error("Error al obtener el contenido de la nota:", error);
        this.noteContent = null;
        this.isNoteExisting = false;
      }
    },
    async saveNote(content) {
      const idMateria = this.$route.query.id_materia;
      try {
        if (this.isNoteExisting) {
          // Usar PUT para actualizar la nota existente
          await axios.put(`https://backend-syntaxpad.onrender.com/api/notas/${idMateria}`, {
            contenido: content,
          });
          console.log("Nota actualizada con éxito.");
        } else {
          // Usar POST para crear una nueva nota
          await axios.post("https://backend-syntaxpad.onrender.com/api/notas", {
            id_materia: idMateria,
            contenido: content,
          });
          console.log("Nota creada con éxito.");
          this.isNoteExisting = true; // Actualizar estado de existencia
        }
      } catch (error) {
        console.error("Error al guardar la nota:", error);
      }
    },
    async initializeEditor() {
      if (this.editor) {
        this.editor.destroy(); // Destruir la instancia previa del editor
        this.editor = null;
      }

      await this.fetchNoteContent(); // Obtener contenido antes de inicializar el editor

      this.editor = new EditorJS({
        holder: "editorjs",
        placeholder: "Escribe algo aquí o escribe una / para ver más opciones...",
        tools: {
          header: {
            class: Header,
            inlineToolbar: true,
            config: {
              placeholder: "Encabezado",
            },
          },
          code: {
            class: Code,
          },
          hyperlink: {
            class: Hyperlink,
            config: {
              shortcut: "CMD+K",
              target: "_blank", // Abre en una nueva pestaña
              rel: "nofollow",
            },
          },
          inlineSpoiler: {
            class: InlineSpoiler,
          },
          list: {
            class: NestedList,
            inlineToolbar: true,
          },
          table: Table,
          embed: {
            class: Embed,
            config: {
              services: {
                youtube: true,
                twitter: true,
                codepen: true,
              },
            },
          },
          marker: Marker,
          underline: Underline,
          inlineCode: InlineCode,
          alert: {
            class: Alert,
            config: {
              defaultType: "primary",
              messagePlaceholder: "Escribe un mensaje",
            },
          },
          delimiter: Delimiter,
        },
        data: this.noteContent || undefined, // Configurar contenido inicial si existe
        onReady: () => {
          new Undo({ editor: this.editor }); // Habilitar historial de cambios
          console.log("Editor.js está listo");
        },
        onChange: async () => {
          const content = await this.editor.save();
          await this.saveNote(content); // Guardar automáticamente los cambios
        },
      });
    },
  },
  async mounted() {
    await this.fetchMateria();
    await this.initializeEditor();
  },
  beforeUnmount() {
    if (this.editor) {
      this.editor.destroy();
    }
  },
  watch: {
    "$route.query.id_materia": async function () {
      await this.fetchMateria();
      await this.initializeEditor();
    },
  },
};
</script>

<style scoped>
/* Fondo oscuro general */
.editor-page {
  background-color: #181818;
  color: #f5f5f5;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* Banner */
.banner {
  width: 100%;
  height: 250px;
  background-size: cover;
  background-position: center;
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.banner-text {
  font-size: 36px;
  font-weight: bold;
  background: rgba(0, 0, 0, 0.5);
  padding: 10px 20px;
  border-radius: 8px;
}

/* Contenedor del editor */
.editor-content {
  width: 100%;
  height: auto;
  background-color: #1e1e1e;
  border-radius: 0;
  padding: 30px 5%;
  margin: 0;
  box-sizing: border-box;
  font-family: "Inter", sans-serif;
}
</style>
