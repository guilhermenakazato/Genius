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
| and then import them inside `start/routes.ts` as follows
|
| import './routes/cart'
| import './routes/customer'
|
*/

import Route from '@ioc:Adonis/Core/Route'
import HealthCheck from '@ioc:Adonis/Core/HealthCheck'
 
Route.get('health', async ({ response }) => {
  const report = await HealthCheck.getReport()
  
  return report.healthy
    ? response.ok(report)
    : response.badRequest(report)
})

Route.get('/users', 'UsersController.listAllUsers').middleware("auth");
Route.get("/user/:id", 'UsersController.getUserById').middleware("auth");
Route.get("/user-email/:email", 'UsersController.verifyIfEmailAlreadyExists')
Route.get("/user-username/:username", 'UsersController.verifyIfUsernameAlreadyExists')
Route.post("/user",'UsersController.createUser');
Route.delete("/user/:id", 'UsersController.deleteUser').middleware("auth");
Route.put("/user/:id", 'UsersController.updateUser').middleware("auth"); 
Route.post("/save-project", 'UsersController.saveProject').middleware("auth")
Route.post("/remove-save-project", 'UsersController.removeSavedProject').middleware("auth")
Route.post("/follow", 'UsersController.follow').middleware("auth")
Route.post("/unfollow", 'UsersController.unfollow').middleware("auth")
Route.post("/like", 'UsersController.likeProject').middleware("auth")
Route.post("/dislike", 'UsersController.dislikeProject').middleware("auth")
Route.put("/password/:userId", 'UsersController.changePassword').middleware("auth")
Route.put("/device-token/:userId", 'UsersController.setDeviceToken').middleware("auth")

Route.post("/login", 'AuthController.login');
Route.get("/token", 'AuthController.authenticateWithToken');
Route.get("/logout", 'AuthController.logout');
Route.get("/get-data", 'AuthController.getUserDataWithJwtToken');
Route.get("/check", 'AuthController.checkIfTokenIsValid');

Route.post("/project/:creatorId", 'ProjectsController.createProject').middleware("auth")
Route.get("/projects", 'ProjectsController.listAllProjects').middleware("auth")
Route.get("/project/:id", 'ProjectsController.getProjectById').middleware("auth")
Route.put("/project/:id", 'ProjectsController.updateProject').middleware("auth")
Route.put("/project/:projectId/:userId", 'ProjectsController.updateDeleteRequests').middleware("auth")
Route.post("/verify", 'ProjectsController.verifyIfProjectTitleAlreadyExists')
Route.get("/verify/:email", 'ProjectsController.verifyIfProjectEmailIsAlreadyBeingUsed')
Route.delete("/project/:projectId", 'ProjectsController.deleteProject').middleware("auth");

Route.post("/achievement/:userId", 'AchievementsController.createAchievement').middleware("auth")
Route.get("/achievements", 'AchievementsController.listAllAchievements').middleware("auth")
Route.get("/achievement/:id", 'AchievementsController.getAchievementById').middleware("auth")
Route.put("/achievement/:id", 'AchievementsController.updateAchievement').middleware("auth")
Route.delete('/achievement/:id', 'AchievementsController.deleteAchievement').middleware("auth")

Route.post("/survey/:userId", 'SurveysController.createSurvey').middleware("auth")
Route.get("/surveys", 'SurveysController.listAllSurveys').middleware("auth")
Route.get("/survey/:id", 'SurveysController.getSurveyById').middleware("auth")
Route.put("/survey/:id", 'SurveysController.updateSurvey').middleware("auth")
Route.delete("/survey/:id", 'SurveysController.deleteSurvey').middleware("auth")

Route.post("/tag", 'TagsController.createTag').middleware("auth")
Route.get("/tags", 'TagsController.getAllTags').middleware("auth")
Route.get("/tag/:id", 'TagsController.getTagById').middleware("auth")

Route.get("/search-all", 'SearchController.getAllProjectsAndUsers').middleware("auth")
Route.post("/search", 'SearchController.search').middleware("auth")