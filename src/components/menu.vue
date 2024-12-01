<template>
  <header class="navbar">
    <div class="navbar-left">
      <!-- Logo con evento de redirección -->
      <img
        src="https://i.postimg.cc/5NpRWNtp/Presentaci-n-Centro-de-Est-tica-Org-nico-Verde-1.png"
        alt="Logo"
        class="logo"
        @click.prevent="goToRoute('/tareas_pendientes')" 
      />
    </div>

    <div class="navbar-center">
      <!-- Enlaces de navegación -->
      <a href="#" @click.prevent="goToRoute('/calendario')" class="nav-link">Calendario</a>
      <a href="#" @click.prevent="goToRoute('/tareas_pendientes')" class="nav-link">Tareas Pendientes</a>
      
      <!-- Menú Desplegable para "Tus Materias" -->
      <div class="dropdown">
        <button class="dropdown-button" @click="toggleDropdown">
          Tus Materias 
          <span class="material-symbols-outlined">arrow_drop_down</span>
        </button>
        <div class="dropdown-content" v-if="isDropdownOpen">
          <div
            v-for="materia in materias"
            :key="materia.id_materia"
            class="materia-item"
          >
            <a
              href="#"
              @click.prevent="goToMateria(materia.id_materia)"
              class="materia-name"
            >
              {{ materia.materia }}
            </a>
            <span
              class="material-symbols-outlined menu-icon"
              @click="toggleMateriaMenu(materia.id_materia)"
            >
              more_vert
            </span>
            <div v-if="materia.showMenu" class="materia-menu">
              <a href="#" @click.prevent="editMateria(materia)" class="materia-option">
                <span class="material-symbols-outlined">edit</span>
                Editar
              </a>
              <a href="#" @click.prevent="deleteMateria(materia)" class="materia-option">
                <span class="material-symbols-outlined">delete</span>
                Eliminar
              </a>
            </div>
          </div>
          <a href="#" class="add-materia" @click.prevent="showAddMateriaDialog">
            Agregar Materia
          </a>
        </div>
      </div>
    </div>
    
    <div class="navbar-right">
      <!-- Botón Logout -->
      <button @click="logout" class="logout-button">
        <span class="material-symbols-outlined">logout</span>
      </button>
    </div>
  </header>
</template>

<script>
import axios from 'axios';
import Swal from 'sweetalert2';

export default {
  data() {
    return {
      userName: 'Cargando...', // Nombre del usuario
      isDropdownOpen: false, // Estado del menú desplegable
      materias: [], // Array de materias cargadas desde el backend
    };
  },
  methods: {
    showAddMateriaDialog() {
      const idUsuario = localStorage.getItem('id_usuario'); // Obtener el id_usuario
      if (!idUsuario) {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'No se puede obtener el ID del usuario. Por favor, inicia sesión.',
        });
        return;
      }

      Swal.fire({
        title: 'Agregar nueva materia',
        html: `
          <input id="materia-nombre" class="swal2-input" placeholder="Nombre de la materia">
        `,
        showCancelButton: true,
        confirmButtonText: 'Agregar',
        cancelButtonText: 'Cancelar',
        focusConfirm: false,
        preConfirm: () => {
          const nombreMateria = document.getElementById('materia-nombre').value;

          if (!nombreMateria) {
            Swal.showValidationMessage('Por favor, ingresa un nombre para la materia');
            return null;
          }
          return { materia: nombreMateria, id_usuario: idUsuario };
        },
      }).then(async (result) => {
        if (result.isConfirmed && result.value) {
          await this.addMateria(result.value);
        }
      });
    },
    async addMateria(nuevaMateria) {
      try {
        // Enviar la nueva materia al backend
        const response = await axios.post('https://backend-syntaxpad.onrender.com/api/materias', nuevaMateria);

        // Recargar las materias desde el backend
        await this.fetchMaterias();

        // Mostrar éxito al usuario
        Swal.fire({
          icon: 'success',
          title: 'Materia agregada',
          text: `Se agregó la materia "${nuevaMateria.materia}" correctamente.`,
        });
      } catch (error) {
        console.error('Error al agregar la materia:', error);
        Swal.fire({
          icon: 'error',
          title: 'Error al agregar materia',
          text: 'No se pudo agregar la materia. Intenta nuevamente.',
        });
      }
    },
  
    async fetchUserName() {
      try {
        const idUsuario = localStorage.getItem('id_usuario');
        if (!idUsuario) {
          this.userName = 'Usuario desconocido';
          return;
        }
        const response = await axios.get(`https://backend-syntaxpad.onrender.com/api/usuario/${idUsuario}`);
        this.userName = response.data.nombre_completo;
      } catch (error) {
        console.error('Error al obtener el nombre del usuario:', error);
        this.userName = 'Error al cargar usuario';
      }
    },
    async fetchMaterias() {
      try {
        const idUsuario = localStorage.getItem('id_usuario'); // Obtener id_usuario del localStorage
        if (!idUsuario) {
          console.error('Error: id_usuario no encontrado en localStorage.');
          return;
        }
        const response = await axios.get(`https://backend-syntaxpad.onrender.com/api/materias/${idUsuario}`);
        this.materias = response.data.map((materia) => ({
          ...materia,
          showMenu: false, // Agregar control para mostrar el menú de cada materia
        }));
      } catch (error) {
        console.error('Error al cargar las materias:', error);
        Swal.fire({
          icon: 'error',
          title: 'Error al cargar materias',
          text: 'No se pudieron cargar las materias. Intenta nuevamente.',
        });
      }
    },
    logout() {
      localStorage.clear();
      this.$router.push('/');
    },
    goToRoute(route) {
      this.$router.push(route);
    },
    goToMateria(idMateria) {
      this.$router.push({ path: '/editor', query: { id_materia: idMateria } });
    },
    toggleDropdown() {
      this.isDropdownOpen = !this.isDropdownOpen;
    },
    toggleMateriaMenu(idMateria) {
      this.materias = this.materias.map((materia) =>
        materia.id_materia === idMateria
          ? { ...materia, showMenu: !materia.showMenu }
          : { ...materia, showMenu: false }
      );
    },
    async editMateria(materia) {
      const { value: nombreMateria } = await Swal.fire({
        title: 'Editar Materia',
        input: 'text',
        inputLabel: 'Nombre de la materia',
        inputValue: materia.materia,
        showCancelButton: true,
        confirmButtonText: 'Guardar',
        cancelButtonText: 'Cancelar',
      });

      if (nombreMateria) {
        try {
          await axios.put(`https://backend-syntaxpad.onrender.com/api/materias/${materia.id_materia}`, {
            materia: nombreMateria,
          });
          await this.fetchMaterias(); // Recargar materias
          Swal.fire({
            icon: 'success',
            title: 'Materia actualizada',
            text: `La materia "${nombreMateria}" se actualizó correctamente.`,
          });
        } catch (error) {
          console.error('Error al editar la materia:', error);
          Swal.fire({
            icon: 'error',
            title: 'Error al editar materia',
            text: 'No se pudo editar la materia. Intenta nuevamente.',
          });
        }
      }
    },
    async deleteMateria(materia) {
      const result = await Swal.fire({
        title: '¿Estás seguro?',
        text: `La materia "${materia.materia}" se eliminará.`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Eliminar',
        cancelButtonText: 'Cancelar',
      });

      if (result.isConfirmed) {
        try {
          await axios.delete(`https://backend-syntaxpad.onrender.com/api/materias/${materia.id_materia}`);
          await this.fetchMaterias(); // Recargar materias
          Swal.fire({
            icon: 'success',
            title: 'Materia eliminada',
            text: `La materia "${materia.materia}" se eliminó correctamente.`,
          });
        } catch (error) {
          console.error('Error al eliminar la materia:', error);
          Swal.fire({
            icon: 'error',
            title: 'Error al eliminar materia',
            text: 'No se pudo eliminar la materia. Intenta nuevamente.',
          });
        }
      }
    },
  },
  async mounted() {
    await this.fetchUserName(); // Obtener el nombre del usuario
    await this.fetchMaterias(); // Cargar las materias del usuario
  },
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&display=swap');

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #333;
  padding: 10px 20px;
  position: sticky;
  top: 0;
  z-index: 10;
}

.logo {
  height: 70px;
  cursor: pointer;
}

.navbar-center {
  display: flex;
  gap: 20px;
  align-items: center;
}

.nav-link {
  color: white;
  text-decoration: none;
  font-size: 16px;
  padding: 5px 10px;
  border-radius: 4px;
}

.nav-link:hover {
  color: #778DA9;
}

/* Dropdown */
.dropdown {
  position: relative;
}

.dropdown-button {
  background-color: transparent;
  border: none;
  color: white;
  font-size: 16px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 5px;
  transition: color 0.3s ease;
}

.dropdown-button:hover {
  color: #778DA9;
}

.material-symbols-outlined {
  font-size: 20px;
}

.dropdown-content {
  position: absolute;
  background-color: #333;
  min-width: 160px;
  z-index: 1;
  border-radius: 4px;
  top: 30px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
}

.dropdown-content a {
  color: white;
  padding: 8px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {
  color: #778DA9;
  transition: color 0.3s ease;
}

.add-materia {
  font-weight: bold;
  text-align: center;
}

.logout-button {
  background-color: transparent;
  color: white;
  border: none;
  padding: 10px 10px;
  font-size: 30px;
  cursor: pointer;
  border-radius: 4px;
  transform: scale(1.2);
  transition: color 0.3s ease, transform 0.3s ease;
}

.logout-button:hover {
  color: #778DA9;
  transform: scale(1.5);
}
.materia-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.menu-icon {
  cursor: pointer;
  color: white; /* Cambiar el color del ícono a blanco */
  font-size: 20px; /* Ajustar el tamaño si es necesario */
  transition: color 0.3s ease; /* Añadir una transición para un efecto suave al interactuar */
}

.menu-icon:hover {
  color: #778DA9; /* Cambiar el color al pasar el mouse por encima, si lo deseas */
}

.materia-menu {
  position: absolute;
  background-color: #444;
  color: white;
  padding: 10px;
  border-radius: 4px;
  z-index: 10;
  transform: translate(120%,30%);

}

.materia-option {
  display: flex;
  align-items: center;
  gap: 5px;
  color: white;
  text-decoration: none;
  padding: 5px 10px;
}

.materia-option:hover {
  color: #778DA9;
}


</style>
