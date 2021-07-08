import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

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
      project.preload('tags')
      project.preload("deleteRequests")
    })
    await auth.user?.load('saved', (saved) => {
      saved.preload('participants')
      saved.preload('tags')
    })
    await auth.user?.load('surveys')
    await auth.user?.load("tags")
    await auth.user?.load("followers")
    await auth.user?.load("following")

    return auth.user
  }

  async checkTokenIsValid({ auth }: HttpContextContract) {
    return await auth.check()
  }
}
