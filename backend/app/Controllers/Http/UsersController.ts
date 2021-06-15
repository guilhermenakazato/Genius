import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Project from 'App/Models/Project'
import Tag from 'App/Models/Tag'
import { DateTime } from 'luxon'
import User from '../../Models/User'

export default class UsersController {
  async listAllUsers() {
    const user = await User.all()
    return user
  }

  async createUser({ request }: HttpContextContract) {
    const data = request.all()
    const user = await User.create(data)

    return user
  }

  async getUserById({ params }: HttpContextContract) {
    const { id } = params
    const user = await User.findOrFail(id)

    await user.load('achievements')
    await user.load('projects')
    await user.load('saved')
    await user.load('surveys')
    await user.load("tags")

    return user
  }

  async deleteUser({ params }: HttpContextContract) {
    const { id } = params
    const user = await User.findOrFail(id)

    await user.delete()
  }

  async updateUser({ params, request }: HttpContextContract) {
    const { id } = params
    const { name, username, email, password, type, age, local, formation, institution, bio, tags } =
      request.all()
    const user = await User.findOrFail(id)

    user.name = name
    user.username = username
    user.email = email
    user.password = password
    user.type = type
    user.age = age
    user.local = local
    user.formation = formation
    user.institution = institution
    user.bio = bio
    user.updatedAt = DateTime.local()

    await user.save()

    await this.updateUserTagRelationship(tags, user);
    await user.load("tags")

    return user
  }

  async saveProject({ request }: HttpContextContract) {
    const { projectId, userId } = request.all()

    const user = await User.findOrFail(userId)
    const project = await Project.findOrFail(projectId)
    await user.related('saved').save(project)

    await user.load('saved')

    return user
  }

  async verifyIfUsernameAlreadyExists({ params }: HttpContextContract) {
    const { username } = params
    const user = await User.findByOrFail('username', username)

    return user
  }

  async verifyIfEmailAlreadyExists({ params }: HttpContextContract) {
    const { email } = params
    const user = await User.findByOrFail('email', email)

    return user
  }

  async updateUserTagRelationship(tags: string[], user: User) {
    let arrayOfTagIds: number[] = []

    for (let i = 0; i < tags.length; i++) {
      const tag = await Tag.findBy('name', tags[i])

      if (tag == null) {
        const newTag = new Tag()

        newTag.name = tags[i]

        await newTag.save()
        arrayOfTagIds.push(newTag.id)
      } else if (tag instanceof Tag) {
        arrayOfTagIds.push(tag.id)
      }
    }

    await user.related('tags').sync(arrayOfTagIds)
  }
}
