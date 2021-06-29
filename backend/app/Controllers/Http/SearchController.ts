import User from 'App/Models/User';
import Project from '../../Models/Project'
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class SearchController {
  async getAllProjectsAndUsers() {
    const users = await User.all();
    const projects = await Project.all();

    return [users, projects]
  }

  async search({request}: HttpContextContract) {
    const {search_text, filters} = request.all();
    const projects = []
    var users: User[] = []

    const findUsersByFullName = await User.query().where('name', search_text)
    const findUsersByUsername = await User.query().where('username', search_text)
    const findUsersByInstitution = await User.query().where('institution', search_text)
    

    if(findUsersByFullName != null) {
      users = users.concat(findUsersByFullName)
    }

    if(findUsersByUsername != null) {
      users = users.concat(findUsersByUsername)
    }

    if(findUsersByInstitution != null) {
      users = users.concat(findUsersByInstitution)
    }

    return users
  }
}