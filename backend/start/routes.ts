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
import UsersController from 'App/Controllers/Http/UsersController'
import ProjectsController from 'App/Controllers/Http/ProjectsController'
import ProjectsParticipantsController from 'App/Controllers/Http/ProjectsParticipantsController'
import AchievementsController from 'App/Controllers/Http/AchievementsController'
import SurveysController from 'App/Controllers/Http/SurveysController'
 
Route.get('health', async ({ response }) => {
  const report = await HealthCheck.getReport()
  
  return report.healthy
    ? response.ok(report)
    : response.badRequest(report)
})

Route.get('/users', UsersController.listAllUsers);
Route.get("/user/:id", UsersController.getUserById);
Route.post("/user", UsersController.create);
Route.delete("/user/:id", UsersController.deleteUser);
Route.put("/user/:id", UsersController.updateUser); 

Route.post("/login", AuthController.login);
Route.get("/token", AuthController.authenticateWithToken);
Route.get("/logout", AuthController.logout);
Route.get("/get-data", AuthController.getUserData);
Route.get("/check", AuthController.checkTokenIsValid);

Route.post("/project", ProjectsController.create)
Route.get("/projects", ProjectsController.index)

Route.post("/projects-participant", ProjectsParticipantsController.create)
Route.get("/projects-participants", ProjectsParticipantsController.listAllParticipants)

Route.post("/achievement", AchievementsController.create)
Route.get("/achievements", AchievementsController.listAllAchievements)

Route.post("/survey", SurveysController.create)
Route.get("/surveys", SurveysController.listAllSurveys)

Route.post("/partner", SurveysController.create)
Route.get("/partners", SurveysController.listAllSurveys)