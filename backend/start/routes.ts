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
import HealthCheck from '@ioc:Adonis/Core/HealthCheck'
import AuthController from 'App/Controllers/Http/AuthController'
import UsuariosController from 'App/Controllers/Http/UserController'
import ProjetosController from 'App/Controllers/Http/ProjectController'
 
Route.get('health', async ({ response }) => {
  const report = await HealthCheck.getReport()
  
  return report.healthy
    ? response.ok(report)
    : response.badRequest(report)
})

Route.get('/usuarios', UsuariosController.index);
Route.get("/usuario/:id", UsuariosController.get);
Route.get("/usuario/id/:email", UsuariosController.getId);
Route.post("/usuario", UsuariosController.create);

Route.post("/login", AuthController.login);
Route.get("/token", AuthController.authenticateWithToken);
Route.get("/logout", AuthController.logout);
Route.get("/getData", AuthController.getUserData);
Route.get("/check", AuthController.checkTokenIsValid);

Route.post("/projeto", ProjetosController.create)
Route.get("/projetos", ProjetosController.index)