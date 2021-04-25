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
import AchievementsController from 'App/Controllers/Http/AchievementsController'
import SurveysController from 'App/Controllers/Http/SurveysController'
import TagsController from 'App/Controllers/Http/TagsController'
 
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

Route.post("/project/:userId", ProjectsController.createProject)
Route.get("/projects", ProjectsController.listAllProjects)
Route.get("project/:id", ProjectsController.getProjectById)

Route.post("/achievement/:userId", AchievementsController.create)
Route.get("/achievements", AchievementsController.listAllAchievements)
Route.get("achievement/:id", AchievementsController.getAchievementById)

Route.post("/survey/:userId", SurveysController.create)
Route.get("/surveys", SurveysController.listAllSurveys)
Route.get("/survey/:id", SurveysController.getSurveyById)

Route.post("/partner", SurveysController.create)
Route.get("/partners", SurveysController.listAllSurveys)

Route.post("/tag", TagsController.create)
Route.get("/tags", TagsController.getAllTags)
Route.get("tag/:id", TagsController.getTagById)