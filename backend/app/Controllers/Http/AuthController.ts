import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { LucidModel, ManyToMany } from '@ioc:Adonis/Lucid/Orm'
import Project from 'App/Models/Project'
import User from 'App/Models/User'

export default class AuthController {
  async login({ request, auth }: HttpContextContract) {
    const email = request.input('email')
    const password = request.input('password')

    const token = await auth.use('api').attempt(email, password)
    return token.toJSON()
  }

  async authenticateWithToken({ auth }: HttpContextContract) {
    await auth.authenticate()

    return {
      message: 'Login realizado com sucesso!',
    }
  }

  async logout({ auth }: HttpContextContract) {
    await auth.use('api').logout()
  }

  async getUserData({ auth }: HttpContextContract) {
    await auth.authenticate()
    await auth.user?.load('achievements')
    await auth.user?.load('projects', (project) => {
      project.preload('participants')
    })
    await auth.user?.load('saved', (saved) => {
      saved.preload('participants')
    })
    await auth.user?.load('surveys')

    var projects = auth.user?.projects
    var saved = auth.user?.saved

    if (projects != undefined) {
        projects = await this.loadTeachersOfAProjectFromId(projects)
    }

    if (saved != undefined) {
        saved = await this.loadTeachersOfAProjectFromId(saved)
    }

    return auth.user
  }

  async loadTeachersOfAProjectFromId(projects: ManyToMany<typeof Project, LucidModel>) {
    for (let i = 0; i < projects.length; i++) {
      var mainTeacherId = projects[i].main_teacher
      var secondTeacherId = projects[i].second_teacher

      if (mainTeacherId != null && mainTeacherId != undefined) {
        projects[i].main_teacher = await User.findOrFail(mainTeacherId)
      }

      if (secondTeacherId != null && secondTeacherId != undefined) {
        projects[i].second_teacher = await User.findOrFail(secondTeacherId)
      }
    }

    return projects
  }

  async checkTokenIsValid({ auth }: HttpContextContract) {
    return await auth.check()
  }
}
