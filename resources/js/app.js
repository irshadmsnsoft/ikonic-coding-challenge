require('./bootstrap');

import { createApp } from 'vue';
import Dashboard from './components/DashboardComponent.vue';
import 'bootstrap/dist/css/bootstrap.min.css';

const app = createApp({
    components: {
        Dashboard,
    }
});

app.component('Dashboard', Dashboard); // Register the component globally if needed

app.mount('#app');
