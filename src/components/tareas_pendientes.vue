<template>
  <div>
    <!-- Menú -->
    <Menu />

    <!-- Banner -->
    <div class="banner" :style="{ backgroundImage: 'url(' + bannerImage + ')' }">
      <h1 class="banner-text">Tareas Pendientes</h1>
    </div>

    <!-- TO DO List -->
    <div class="content">
      <!-- Barra de búsqueda y filtro de tareas completadas -->
      <div class="search-bar">
        <input
          type="text"
          v-model="searchQuery"
          class="form-control"
          placeholder="Buscar tarea, materia, prioridad o fecha"
        />
        <label class="checkbox-container">
          <input type="checkbox" v-model="showCompleted" /> Mostrar solo completadas
        </label>
        <!-- Botón para agregar tareas -->
        <button class="btn btn-primary" data-toggle="modal" data-target="#addTaskModal">
          Agregar tarea
        </button>
      </div>

      <!-- Tabla de tareas -->
      <table class="table table-dark mt-5">
        <thead>
          <tr>
            <th>Tarea</th>
            <th>Materia</th>
            <th>Prioridad</th>
            <th>Fecha de Entrega</th>
            <th>Estado</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(task, index) in filteredTasks"
            :key="index"
            :class="{ completed: task.completado === 1 }"
          >
            <td>{{ task.tarea }}</td>
            <td>{{ task.materia }}</td>
            <td>{{ task.prioridad }}</td>
            <td>{{ task.fecha_entrega }}</td>
            <td>
              <button
                class="btn"
                :class="task.completado === 1 ? 'btn-secondary' : 'btn-success'"
                @click="toggleCompletion(task)"
              >
                {{ task.completado === 1 ? "Marcar como no completada" : "Marcar como completada" }}
              </button>
            </td>
            <td>
              <button @click="deleteTask(task, index)" class="btn btn-danger">
    <span class="material-symbols-outlined">delete</span>
  </button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Modal para agregar tarea -->
      <div
        class="modal fade"
        id="addTaskModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog" role="document">
          <div class="modal-content bg-dark text-white">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Agregar Tarea</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label for="tarea">Tarea</label>
                <input
                  type="text"
                  v-model="newTask.tarea"
                  class="form-control"
                  placeholder="Escribe la tarea"
                />
              </div>

              <div class="form-group">
                <label for="materia">Materia</label>
                <input
                  type="text"
                  v-model="newTask.materia"
                  class="form-control"
                  placeholder="Escribe la materia"
                />
              </div>

              <div class="form-group">
                <label for="prioridad">Prioridad</label>
                <select v-model="newTask.prioridad" class="form-control">
                  <option value="Alta">Alta</option>
                  <option value="Media">Media</option>
                  <option value="Baja">Baja</option>
                </select>
              </div>

              <div class="form-group">
                <label for="fechaEntrega">Fecha de Entrega</label>
                <input type="date" v-model="newTask.fecha_entrega" class="form-control" />
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">
                Cerrar
              </button>
              <button type="button" class="btn btn-primary" @click="addTask">Agregar</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../components/menu.vue";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  components: {
    Menu,
  },
  data() {
    return {
      bannerImage: "https://cdn.pixabay.com/photo/2020/04/30/15/34/code-5113374_1280.jpg",
      tasks: [],
      newTask: {
        tarea: "",
        materia: "",
        prioridad: "Alta",
        fecha_entrega: "",
        completado: 0,
      },
      searchQuery: "",
      showCompleted: false,
    };
  },
  computed: {
  filteredTasks() {
    const query = this.searchQuery.toLowerCase(); // Convertir la búsqueda a minúsculas para comparaciones insensibles a mayúsculas/minúsculas

    const filtered = this.tasks.filter((task) => {
      // Verificar si la tarea coincide con los criterios de búsqueda
      const matchesTask = task.tarea.toLowerCase().includes(query); // Buscar por tarea
      const matchesMateria = task.materia.toLowerCase().includes(query); // Buscar por materia
      const matchesPrioridad = task.prioridad.toLowerCase().includes(query); // Buscar por prioridad
      const matchesFecha = task.fecha_entrega.includes(query); // Buscar por fecha

      // Filtrar tareas completadas si la opción está activa
      const matchesCompletion = this.showCompleted ? task.completado === 1 : true;

      // Retornar tareas que cumplan al menos un criterio y el filtro de completadas
      return (matchesTask || matchesMateria || matchesPrioridad || matchesFecha) && matchesCompletion;
    });

    // Ordenar las tareas: primero no completadas, luego completadas
    return filtered.sort((a, b) => a.completado - b.completado);
  },
},
  methods: {
    CargarPendientes() {
  const idusuario = localStorage.getItem("id_usuario");
  axios
    .get(`https://backend-syntaxpad.onrender.com/api/pendientes/${idusuario}`)
    .then((response) => {
      if (response.data.length === 0) {
        this.tasks = [
          {
            id_pendiente: 0,
            tarea: "AUN NO TIENES PENDIENTES EN TU LISTA",
            materia: "---",
            prioridad: "---",
            completado: 0,
            fecha_entrega: "---"
          }
        ];
      } else {
        this.tasks = response.data;
      }
    })
    .catch((error) => {
      console.error("Error al obtener pendientes:", error);
    });
},

    addTask() {
  // Verificar que todos los campos estén llenos
  if (
    !this.newTask.tarea ||
    !this.newTask.materia ||
    !this.newTask.fecha_entrega
  ) {
    Swal.fire("Error", "Por favor, llena todos los campos del formulario.", "error");
    return;
  }

  const id_usuario = localStorage.getItem("id_usuario"); // Obtener id_usuario del localStorage
  if (!id_usuario) {
    Swal.fire("Error", "Usuario no logueado. Por favor, inicia sesión.", "error");
    return;
  }

  // Mostrar alerta de confirmación antes de agregar la tarea
  Swal.fire({
    title: "¿Estás seguro?",
    text: "¿Deseas agregar esta nueva tarea?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Sí, agregar",
    cancelButtonText: "Cancelar",
  }).then((result) => {
    if (result.isConfirmed) {
      // Si el usuario confirma, enviar la solicitud al backend
      axios
        .post("https://backend-syntaxpad.onrender.com/api/addPendiente", {
          tarea: this.newTask.tarea,
          materia: this.newTask.materia,
          prioridad: this.newTask.prioridad,
          fecha_entrega: this.newTask.fecha_entrega,
          id_usuario: id_usuario,
        })
        .then((response) => {
          // Agregar la tarea localmente con los datos recibidos
          this.tasks.push({
            id_pendiente: response.data.pendienteId,
            tarea: this.newTask.tarea,
            materia: this.newTask.materia,
            prioridad: this.newTask.prioridad,
            fecha_entrega: this.newTask.fecha_entrega,
            completado: 0,
          });

          // Limpiar el formulario
          this.newTask.tarea = "";
          this.newTask.materia = "";
          this.newTask.prioridad = "Alta";
          this.newTask.fecha_entrega = "";

          // Cerrar el modal y mostrar un mensaje de éxito
          $("#addTaskModal").modal("hide");
          Swal.fire("Agregado", "La tarea fue agregada exitosamente.", "success");
        })
        .catch((error) => {
          console.error("Error al agregar la tarea:", error);
          Swal.fire("Error", "No se pudo agregar la tarea. Intenta nuevamente.", "error");
        });
    }
  });
},


    deleteTask(task, index) {
  const { id_pendiente } = task;

  // Mostrar alerta de confirmación con SweetAlert
  Swal.fire({
    title: "¿Estás seguro?",
    text: "No podrás recuperar esta tarea una vez eliminada.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Sí, eliminar",
    cancelButtonText: "Cancelar",
  }).then((result) => {
    if (result.isConfirmed) {
      // Si el usuario confirma, enviar la solicitud para eliminar
      axios
        .delete(`https://backend-syntaxpad.onrender.com/api/deletePendiente/${id_pendiente}`)
        .then(() => {
          // Eliminar la tarea localmente de la lista
          this.tasks.splice(index, 1);

          // Mostrar mensaje de éxito
          Swal.fire("Eliminado", "La tarea ha sido eliminada con éxito.", "success");
        })
        .catch((error) => {
          console.error("Error al eliminar el pendiente:", error);
          Swal.fire("Error", "No se pudo eliminar la tarea.", "error");
        });
    }
  });
},

    toggleCompletion(task) {
      // Alternar el estado completado
      const newCompletionState = task.completado === 0 ? 1 : 0;

      // Hacer la solicitud al backend
      axios
        .post("https://backend-syntaxpad.onrender.com/api/updatePendiente", {
          id_pendiente: task.id_pendiente,
          completado: newCompletionState,
        })
        .then(() => {
          // Actualizar el estado de la tarea localmente
          task.completado = newCompletionState;
        })
        .catch((error) => {
          console.error("Error al actualizar la tarea:", error);
          alert("No se pudo actualizar el estado de la tarea.");
        });
    },
  },
  mounted() {
    this.CargarPendientes();
  },
};
</script>







  
  <style scoped>
  /* Estilos para la lista de tareas */

  .modal-content {
  background-color: #343a40; /* Fondo oscuro */
  color: white; /* Texto blanco */
}
  .content {
    padding: 20px;
    font-family: "Host Grotesk", sans-serif;
    font-weight: 200;
  }

  .banner-text {
    position: absolute;
    bottom: 10px; /* Ajusta la distancia del texto desde el final del banner */
    left: 20px;  /* Ajusta la distancia desde el borde izquierdo */
    font-size: 50px;  /* Ajusta el tamaño de la fuente según lo desees */
    font-weight: bold;
    padding: 5px;
    border-radius: 10px;
    background: rgb(237, 237, 237, .1);
    backdrop-filter: blur(10px);
  }
  
  .table {
  width: 100%;
  margin-top: 20px;
  border-collapse: collapse; /* Para que los bordes no se dupliquen */
  box-shadow: 9px 19px 32px -5px rgba(0,0,0,0.79);
-webkit-box-shadow: 9px 19px 32px -5px rgba(0,0,0,0.79);
-moz-box-shadow: 9px 19px 32px -5px rgba(0,0,0,0.79);
}

.table th,
.table td {
  padding: 12px 15px; /* Añadir más espacio en las celdas */
  text-align: left;
  vertical-align: middle;
  border: 1px solid #ddd; /* Bordes suaves */
}

.table th {
  background-color: #f8f9fa; /* Fondo claro para la cabecera */
  font-weight: bold;
  color: #343a40;
}

.table td {
  background-color: #ffffff;
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
  
  .form-group {
    margin-bottom: 15px;
  }
  
  input[type="text"], input[type="date"], select {
    width: 100%;
    padding: 8px;
    margin: 5px 0;
  }
  
  button {
    margin-top: 10px;
  }
  
  /* Estilos para el banner */
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
    transition: background-image 0.3s ease-in-out;
  }

  .search-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.search-bar input {
  width: 75%;
  padding: 8px;
}

.checkbox-container {
  display: flex;
  align-items: center;
  color: #ddd;
}

.checkbox-container input {
  margin-left: 10px;
}

button {
  margin-top: 10px;
}

/* Estilos para las filas completadas */
.completed {
  text-decoration: line-through;
  background-color: #666;
}

.table-dark {
  background-color: #343a40;
  color: white;
}

.table-dark th,
.table-dark td {
  background-color: #343a40; /* Fondo oscuro en tema dark */
  color: white;
  border-color: #454d55;
}

.table-rounded th,
.table-rounded td {
  border-radius: 8px;
}


/* Botones */
.btn-secondary {
  background-color: #6c757d;
}

.btn-success {
  background-color: #28a745;
}

.btn-danger {
  background-color: #dc3545;
}



  </style>
  