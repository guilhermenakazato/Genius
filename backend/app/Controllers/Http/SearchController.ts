import User from 'App/Models/User'
import Project from '../../Models/Project'
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class SearchController {
  async getAllProjectsAndUsers() {
    const users = await User.all()
    const projects = await Project.all()

    return [users, projects]
  }

  async search({ request }: HttpContextContract) {
    const { search_text, filter_tags, show_projects, show_users } = request.all()
    var projects: Project[] = []
    var users: User[] = []
    var findUsersByUsername: User[],
      findProjectByName: Project[],
      findProjectByAbstractText: Project[]

    if (filter_tags === undefined || filter_tags.length == 0) {
      ;[findUsersByUsername, findProjectByName, findProjectByAbstractText] =
        await this.searchWithNoFilter(search_text, show_projects, show_users)

      if (findUsersByUsername != null) {
        users = users.concat(findUsersByUsername)
      }

      if (findProjectByName != null) {
        projects = projects.concat(findProjectByName)
      }

      if (findProjectByAbstractText != null) {
        projects = projects.concat(findProjectByAbstractText)
      }
    } else {
      ;[users, projects] = await this.searchWithFilter(
        search_text,
        filter_tags,
        show_projects,
        show_users
      )
    }

    projects = [...new Map(projects.map(item => [item.id, item])).values()]
    users = [...new Map(users.map(item => [item.id, item])).values()]

    return [users, projects]
  }

  async searchWithNoFilter(search_text: string, showProjects: boolean, showUsers: boolean): Promise<[User[], Project[], Project[]]> {
    var findUsersByUsername: User[] = [], findProjectByAbstractText: Project[] = [], findProjectByName: Project[] = []

    if(showUsers) {
      findUsersByUsername = await User.query().where('username', 'ilike', `%${search_text}%`)
    }

    if(showProjects) {
      findProjectByName = await Project.query().where('name', 'ilike', `%${search_text}%`)
      findProjectByAbstractText = await Project.query().where(
        'abstract_text',
        'ilike',
        `%${search_text}%`
      )
    }
    return [findUsersByUsername, findProjectByName, findProjectByAbstractText]
  }

  async searchWithFilter(
    search_text: string,
    filters: string[],
    showProjects: boolean,
    showUsers: boolean
  ): Promise<[User[], Project[]]> {
    var findUsersByUsername: User[] = [],
      findProjectByName: Project[] = [],
      findProjectByAbstractText: Project[] = [],
      projects: Project[] = [],
      users: User[] = []

    for (let i = 0; i < filters.length; i++) {
      if (showUsers) {
        findUsersByUsername = await User.query()
          .where('username', 'ilike', `%${search_text}%`)
          .andWhereHas('tags', (tags) => {
            tags.where('name', filters[i])
          })
        }

      if (showProjects) {
        findProjectByName = await Project.query()
          .where('name', 'ilike', `%${search_text}%`)
          .andWhereHas('tags', (tags) => {
            tags.where('name', filters[i])
          })

        findProjectByAbstractText = await Project.query()
          .where('abstract_text', 'ilike', `%${search_text}%`)
          .andWhereHas('tags', (tags) => {
            tags.where('name', filters[i])
          })
      }

      if (findUsersByUsername != null) {
        users = users.concat(findUsersByUsername)
      }

      if (findProjectByName != null) {
        projects = projects.concat(findProjectByName)
      }

      if (findProjectByAbstractText != null) {
        projects = projects.concat(findProjectByAbstractText)
      }
    }

    return [users, projects]
  }
}
