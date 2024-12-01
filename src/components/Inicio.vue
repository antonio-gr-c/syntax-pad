<template>
  <div class="main-container" :class="{ 'register-mode': isRegistering }">
    <!-- Contenedor de formulario y login -->
    <transition name="slide-fade" mode="out-in">
      <div v-if="!isRegistering" key="login" class="login-card">
        <div class="login-container">
          <h1>¡Hola de nuevo!</h1>
          <p>Por favor ingresa tus datos para iniciar</p>
          <form @submit.prevent="login">
            <label for="email">Email</label>
            <input type="email" id="email" placeholder="correo@ejemplo.com" v-model="loginEmail" required />

            <label for="password">Password</label>
            <input type="password" id="password" placeholder="ingresa tu contraseña" v-model="loginPassword" required />

            <a class="forgot-password" @click="toggleForm">¿Aún no tienes una cuenta? ¡Regístrate!</a>
            <div class="botonera">
              <button type="submit" class="login-button">
                <span class="material-symbols-outlined">login</span>
              </button>
            </div>
          </form>
        </div>
      </div>

      <div v-else key="register" class="login-card">
        <div class="register-container">
          <h1>Regístrate</h1>
          <p>Crea una nueva cuenta llenando el formulario</p>
          <form @submit.prevent="register">


            <div class="nombres">
            
            <input type="text" id="name" placeholder="nombre" v-model="name" required />

          
            <input type="text" id="lastName" placeholder="Apellido paterno" v-model="lastName" required />

           
            <input type="text" id="maternalLastName" placeholder="Apellido materno" v-model="maternalLastName" required />
            </div>




            <label for="registerEmail">Email</label>
            <input type="email" id="registerEmail" placeholder="correo@ejemplo.com" v-model="registerEmail" required />

            <label for="registerPassword">Password</label>
            <input
              type="password"
              id="registerPassword"
              placeholder="Ingresa tu contraseña"
              v-model="registerPassword"
              required
              minlength="8"
              pattern="(?=.*[a-z])(?=.*[A-Z]).{8,}"
              title="La contraseña debe tener al menos 8 caracteres, incluyendo mayúsculas y minúsculas"
            />

            <label for="confirmPassword">Confirmar Password</label>
            <input
              type="password"
              id="confirmPassword"
              placeholder="Confirma tu contraseña"
              v-model="confirmPassword"
              required
            />

            <span v-if="passwordMismatch" class="error-message">Las contraseñas no coinciden</span>

            <a class="forgot-password" @click="toggleForm">¿Ya tienes una cuenta? Inicia sesión</a>
            <div class="botonera">
              <button type="submit" class="login-button" :disabled="passwordMismatch">Regístrate</button>
            </div>
          </form>
        </div>
      </div>
    </transition>

    <!-- Columna de imagen -->
    <div class="image-container">
      <img
        src="https://cdn.prod.website-files.com/62aa5d914f45160a7f155660/62aa5d924f4516838d15585f_nocode.svg"
        alt="Coder Illustration"
      />
    </div>
  </div>
</template>

<script>
import Swal from 'sweetalert2';
import axios from 'axios'; // Importa axios

export default {
  data() {
    return {
      isRegistering: false,
      loginEmail: '',
      loginPassword: '',
      name: '',
      lastName: '',
      maternalLastName: '',
      registerEmail: '',
      registerPassword: '',
      confirmPassword: '',
    };
  },
  computed: {
    passwordMismatch() {
      return this.registerPassword !== this.confirmPassword;
    },
  },
  methods: {
    toggleForm() {
      this.isRegistering = !this.isRegistering;
    },
    async login() {
      try {
        // Objeto con las credenciales de inicio de sesión
        const credentials = {
          email: this.loginEmail,
          password: this.loginPassword,
        };

        // Solicitud al endpoint de login
        const response = await axios.post('https://backend-syntaxpad.onrender.com/api/login', credentials);

        if (response.status === 200) {
          // Guardar el token y el id_usuario en localStorage
          localStorage.setItem('token', response.data.token);
          localStorage.setItem('id_usuario', response.data.user.id_usuario);

          Swal.fire({
            icon: 'success',
            title: 'Login exitoso',
            text: `¡Hola ${response.data.user.nombre}! vamos a trabajar`,
            confirmButtonText: 'Continuar',
          }).then(() => {
            // Redirigir al menú o dashboard
            this.$router.push('/tareas_pendientes');
          });
        }
      } catch (error) {
        // Manejo de errores
        if (error.response && error.response.status === 401) {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Contraseña incorrecta',
            confirmButtonText: 'Intentar de nuevo',
          });
        } else if (error.response && error.response.status === 404) {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Usuario no encontrado',
            confirmButtonText: 'Intentar de nuevo',
          });
        } else {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Ocurrió un problema al iniciar sesión. Intenta de nuevo.',
            confirmButtonText: 'Aceptar',
          });
        }
        console.error('Error al iniciar sesión:', error);
      }
    },
    async register() {
      if (this.passwordMismatch) {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'Las contraseñas no coinciden',
          confirmButtonText: 'Corregir',
        });
        return;
      }

      // Objeto con los datos del usuario a registrar
      const newUser = {
        nombre: this.name,
        apellido_paterno: this.lastName,
        apellido_materno: this.maternalLastName,
        email: this.registerEmail,
        password: this.registerPassword,
      };

      try {
        // Llama al endpoint `/api/usuarios` usando axios
        const response = await axios.post('https://backend-syntaxpad.onrender.com/api/usuarios', newUser);

        if (response.status === 201) {
          Swal.fire({
            icon: 'success',
            title: 'Registro Exitoso',
            text: 'Tu cuenta ha sido creada correctamente',
            confirmButtonText: 'Iniciar sesión',
          }).then(() => {
            this.clearForm();
            this.isRegistering = false;
          });
        }
      } catch (error) {
        // Manejo de errores en caso de problemas con el servidor o la solicitud
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'Ocurrió un problema al registrar el usuario. Intenta de nuevo.',
          confirmButtonText: 'Aceptar',
        });
        console.error('Error al registrar usuario:', error);
      }
    },
    clearForm() {
      this.name = '';
      this.lastName = '';
      this.maternalLastName = '';
      this.registerEmail = '';
      this.registerPassword = '';
      this.confirmPassword = '';
    },
  },
};
</script>


<style scoped>
.main-container {
  display: flex;
  flex-direction: row;
  height: 100vh;
  background-color: rgb(212, 212, 212);
}


.main-container.register-mode .login-card {
  transform: translateX(100%);
}

.main-container.register-mode .image-container {
  transform: translateX(-100%);
}

.login-card {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 2rem;
  width: 50%;
  text-align: center;
  background-color: #0d1b2a;
  transition: transform 0.5s ease;
}

.login-container {
  background-color: #E0E1DD;
  padding: 10%;
  border-radius: 10px;
  box-shadow: 10px 10px 32px -5px rgba(0, 0, 0, 0.79);
}



.register-container {
  background-color: #E0E1DD;
  padding: 10%;
  border-radius: 10px;
  box-shadow: 10px 10px 32px -5px rgba(0, 0, 0, 0.79);
}

.nombres{
  display: flex;
  gap: 10px;
}

h1 {
  color: #415A77;
  margin-bottom: 0.5rem;
}

.error-message {
  color: red;
  font-size: 0.9em;
}

p {
  color: black;
  margin-bottom: 1.5rem;
}

label {
  color: #415A77;
  font-weight: bold;
  display: block;
  margin: 0.5rem 0 0.25rem;
}

input {
  width: 100%;
  padding: 0.75rem;
  margin-bottom: 1rem;
  border: 1px solid #778DA9;
  border-radius: 4px;
}

.forgot-password {
  display: block;
  margin-bottom: 1rem;
  color: #778DA9;
  text-decoration: none;
  cursor: pointer;
}

.login-button {
  margin-left: 5px;
  margin-right: 5px;
  align-items: center;
  justify-content: center;
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 12px;
  border-radius: 25px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.3s ease;
}

.login-button:hover {
  background-color: #0056b3;
  transform: scale(1.05);
}

.image-container {
  width: 50%;
  height: 100%;
  overflow: hidden;
  background-color: #ececec;
  transition: transform 0.5s ease;
}

img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: opacity 0.5s ease, transform 0.5s ease;
}

/* Cambios en pantallas pequeñas (móviles y tabletas) */
@media (max-width: 768px) {
  .main-container {
    flex-direction: column;
    background-color: #0d1b2a; /* Asegura que el fondo sea del mismo color */
  }

  .image-container {
    display: none; /* Oculta la imagen */
  }

  .login-card {
    width: 100%; /* Ocupa todo el ancho */
    transform: none; /* Elimina animaciones */
  }

  .main-container.register-mode .login-card {
    transform: none; /* Elimina la animación */
  }

  .login-container,
  .register-container {
    padding: 5%; /* Reduce el padding en móviles */
    box-shadow: none; /* Simplifica el diseño */
  }

  .nombres {
    flex-direction: column; /* Apila los campos de nombres */
    gap: 5px;
  }
  

}

</style>
