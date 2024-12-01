import { createRouter, createWebHistory } from 'vue-router';
import Inicio from './components/Inicio.vue';
import menu from './components/menu.vue';
import tareas_pendientes from './components/tareas_pendientes.vue';
import calendario from './components/calendario.vue';
import Editor from './components/Editor.vue';

const routes = [
  { path: '/', name: 'Inicio', component: Inicio },
  { path: '/menu', name: 'menu', component: menu, meta: { requiresAuth: true } },
  { path: '/tareas_pendientes', name: 'tareas_pendientes', component: tareas_pendientes, meta: { requiresAuth: true } },
  { path: '/calendario', name: 'calendario', component: calendario, meta: { requiresAuth: true } },
  { path: '/Editor', name: 'Editor', component: Editor, meta: { requiresAuth: true } },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

// Guard para redirección basada en autenticación
router.beforeEach((to, from, next) => {
  const id_usuario = localStorage.getItem("id_usuario");

  if (to.path === '/' && id_usuario) {
    // Si está logueado y trata de ir a '/', redirige a '/tareas_pendientes'
    next({ path: '/tareas_pendientes' });
  } else if (to.meta.requiresAuth && !id_usuario) {
    // Si la ruta requiere autenticación y no hay usuario logueado, redirige a Inicio
    next({ path: '/' });
  } else {
    // Continuar con la navegación
    next();
  }
});

export default router;
