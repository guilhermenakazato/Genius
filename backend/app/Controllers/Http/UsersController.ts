import Mail from '@ioc:Adonis/Addons/Mail'
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Project from 'App/Models/Project'
import Tag from 'App/Models/Tag'
import { DateTime } from 'luxon'
import User from '../../Models/User'
import Application from '@ioc:Adonis/Core/Application'

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
    await user.load('projects', project => {
      project.preload("participants")
      project.preload('tags')
    })
    await user.load('surveys')
    await user.load("tags")

    return user
  }

  async deleteUser({ params }: HttpContextContract) {
    const { id } = params
    const user = await User.findOrFail(id)

    await user.load("projects")
    await user.load("tags")

    if(user.projects.length >= 1) {
      for(let i = 0; i < user.projects.length; i++) {
        const project = await Project.find(user.projects[i].id);
        await project?.load("participants")
        
        await project?.related("participants").detach([id]);
      
        if(user.username == project?.main_teacher) {
          project.main_teacher = null
          await project.save()

          console.log(project.main_teacher)
        } else if(user.username == project?.second_teacher) {
          project.second_teacher = null
          await project.save()
        }

        if(project?.participants.length == 1) {
          await this.deleteProjectSinceThereAreNoParticipantsInIt(project);
        }
      }
    }

    if(user.tags.length >= 1) {
      for(let i = 0; i < user.tags.length; i++) {
        const tag = await Tag.find(user.tags[i].id);

        await tag?.related("users").detach([id]);
      }
    }

    await user.delete()
  }

  async deleteProjectSinceThereAreNoParticipantsInIt(project: Project) {
    await project.load("tags")

    if(project.tags.length >= 1) {
      for(let i = 0; i < project.tags.length; i++) {
        const tag = await Tag.find(project.tags[i].id);

        await tag?.related("projects").detach([project.id]);
      }
    }

    await project.delete()
  }

  async updateUser({ params, request }: HttpContextContract) {
    const { id } = params
    const { name, username, email, password, type, age, local, formation, institution, bio, tags, verified } =
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
    user.verified = verified
    user.updatedAt = DateTime.local()

    await user.save()

    if(tags != null && tags != undefined) {
      await this.updateUserTagRelationship(tags, user);
    }
    
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

  async sendEmail({request}: HttpContextContract) {
    const images = request.files('images')
    const {receptor_email, user_name} = request.all()

    for (let image of images) {
      await image.move(Application.tmpPath('uploads'))
    }

    await Mail.send((message) => {
      message
        .from('geniusapp.science@gmail.com', "Genius")
        .to(receptor_email)
        .subject('Seja bem-vindo!')
        .htmlView('emails/welcome', {
          user: {name: user_name}
        })

        for(let image of images) {
          if(image.filePath){
            message.attach(image.filePath, {filename: image.fileName});
          }
        }
    })
  }
}
