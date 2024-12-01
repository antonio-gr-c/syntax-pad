<template>
  <div>
    <!-- Menú -->
    <Menu />

    <!-- Banner -->
    <div class="banner" :style="{ backgroundImage: 'url(' + bannerImage + ')' }">
      <h1 class="banner-text">Calendario</h1>
    </div>

    <!-- Contenido dividido en dos columnas -->
    <div class="content">
      <div class="left-column">
        <div class="tabla">
          <table class="table">
            <thead>
              <tr>
                <th>Tarea</th>
                <th>Materia</th>
                <th>Prioridad</th>
                <th>Fecha de Entrega</th>
              </tr>
            </thead>
            <tbody>
              <!-- Renderizamos las tareas pendientes -->
              <tr v-for="(task, index) in filteredTasks" :key="index">
                <td>{{ task.tarea }}</td>
                <td>{{ task.materia }}</td>
                <td>{{ task.prioridad }}</td>
                <td>{{ task.fecha_entrega }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="right-column">
        <div class="calendario">
          <vue-cal
            :events="calendarEvents"
            :disable-nav="true"
            :disable-event-click="true"
            :disable-event-edit="true"
            :disable-event-delete="true"
            :locale="'es'"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "@/components/Menu.vue";
import VueCal from "vue-cal";
import "vue-cal/dist/vuecal.css";
import axios from "axios";

export default {
  components: {
    Menu, // Registramos el componente Menu
    VueCal, // Registramos la librería VueCal
  },
  data() {
    return {
      bannerImage: "https://cdn.pixabay.com/photo/2020/04/30/15/34/code-5113374_1280.jpg", // Imagen inicial
      tasks: [],
      calendarEvents: [], // Este array será llenado con las tareas pendientes convertidas en eventos del calendario
    };
  },
  computed: {
    // Filtro para tareas, basado en el estado de completado
    filteredTasks() {
      return this.tasks.filter(task => task.completado === 0); // Tareas no completadas (completado = 0)
    },
  },
  watch: {
    tasks: {
      handler() {
        this.updateCalendarEvents();
      },
      deep: true,
    },
  },
  mounted() {
    this.updateCalendarEvents();
    this.CargarPendientes();
  },
  methods: {
    CargarPendientes() {
      const idusuario = localStorage.getItem("id_usuario");
      axios
        .get(`https://backend-syntaxpad.onrender.com/api/pendientes/${idusuario}`)
        .then((response) => {
          this.tasks = response.data;
        })
        .catch((error) => {
          console.error("Error al obtener pendientes:", error);
        });
    },
    // Actualizar los eventos del calendario con las tareas pendientes
    updateCalendarEvents() {
      this.calendarEvents = this.tasks
        .filter(task => task.completado === 0) // Filtramos solo tareas no completadas (completado = 0)
        .map(task => ({
          start: task.fecha_entrega,
          end: task.fecha_entrega,
          title: task.tarea,
          description: `Materia: ${task.materia}, Prioridad: ${task.prioridad}`,
          color: task.prioridad === "Alta" ? "red" : task.prioridad === "Media" ? "orange" : "green",
        }));
    },
  },
};
</script>
  
  <style scoped>
  /* Banner con la imagen de fondo */
  .calendario{
    padding: 10px;
    border-radius: 10px;
    background-color: #eaedf0;
    width: 100%;
    height: 60%;
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
  }


  .banner {
    width: 100%;
    height: 350px;
    background-size: cover;
    background-position: center;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
    position: relative;
  }

  .banner-text {
    position: absolute;
    bottom: 10px;
    left: 20px;
    font-size: 50px;
    font-weight: bold;
    padding: 5px;
    border-radius: 10px;
    background: rgb(237, 237, 237, .1);
    backdrop-filter: blur(10px);
  }

  /* Estilos para el contenido */
  .content {
    display: flex;
    margin-top: 20px;
  }

  /* Columna izquierda */
  .left-column {
    flex: 1;
    padding: 20px;
  }

  /* Columna derecha */
  .right-column {
    flex: 2;
    padding: 20px;
    border-radius: 10px;
    
  }

  /* Tabla de tareas */
  .table-wrapper {
    max-height: 400px; /* Altura fija para la tabla */
    overflow-y: auto; /* Scroll vertical */
    margin-top: 20px;
  }

  .table {
    width: 100%;
    border-collapse: collapse; /* Para que los bordes no se dupliquen */
    box-shadow: 9px 19px 32px -5px rgba(0, 0, 0, 0.79);
    -webkit-box-shadow: 9px 19px 32px -5px rgba(0, 0, 0, 0.79);
    -moz-box-shadow: 9px 19px 32px -5px rgba(0, 0, 0, 0.79);
  }

  .table th,
  .table td {
    padding: 12px 15px; /* Añadir más espacio en las celdas */
    text-align: left;
    vertical-align: middle;
    border: 1px solid #ddd; /* Bordes suaves */
  }

  .table th {
    background-color:#343a40; /* Fondo claro para la cabecera */
    font-weight: bold;
    color: #f5f5f5;
  }

  .table td {
    background-color: #909ca8;
  }

  .table-striped tbody tr:nth-child(odd) {
    background-color: #f9f9f9; /* Colores alternados en filas */
  }

  .table-striped tbody tr:nth-child(even) {
    background-color: #ffffff;
  }

  .table-hover tbody tr:hover {
    background-color: #f1f1f1; /* Cambio de fondo cuando se pasa el mouse */
  }
</style>