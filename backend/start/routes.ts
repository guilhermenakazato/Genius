/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes/index.ts` as follows
|
| import './cart'
| import './customer'
|
*/

import Route from '@ioc:Adonis/Core/Route'
import AuthController from 'App/Controllers/Http/AuthController';
import ProjetosController from 'App/Controllers/Http/ProjetosController';
import UsuariosController from 'App/Controllers/Http/UsuariosController';

Route.get('/usuarios', UsuariosController.index);
Route.get("/usuario/:id", UsuariosController.get);
Route.get("/usuario/id/:email", UsuariosController.getId);
Route.post("/usuario", UsuariosController.create);

Route.post("/login", AuthController.login);
Route.post("/token", AuthController.token);

Route.post("/projeto", ProjetosController.create)
Route.get("/projetos", ProjetosController.index)