import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Tag from 'App/Models/Tag'
import User from 'App/Models/User'
import Project from '../../Models/Project'

export default class ProjectsController {
  async createProject({ request, params, response }: HttpContextContract) {
    const {
      name,
      tags,
      main_teacher,
      second_teacher,
      main_teacher_name,
      second_teacher_name,
      institution,
      start_date,
      abstract_text,
      participants,
      email,
      participants_full_name,
    } = request.all()

    if (main_teacher != undefined && main_teacher != null) {
      participants.push(main_teacher)
    }

    if (second_teacher != undefined && second_teacher != null) {
      participants.push(second_teacher)
    }

    const { creatorId } = params
    const { allExists, username } = await this.allParticipantsExist(participants)

    if (allExists) {
      const project = new Project()
      project.name = name
      project.main_teacher = main_teacher
      project.second_teacher = second_teacher
      project.main_teacher_name = main_teacher_name
      project.second_teacher_name = second_teacher_name
      project.institution = institution
      project.start_date = start_date
      project.abstractText = abstract_text
      project.email = email
      project.participants_full_name = participants_full_name

      await project.save()

      await this.createProjectParticipantRelationship(participants, project)
      if (!(tags == null)) {
        await this.createProjectTagRelationship(tags, project)
      }

      const creator = await User.findOrFail(creatorId)
      await creator.related('projects').save(project)

      await project.load('participants')
      await project.load('tags')

      return project
    } else {
      return response.status(404).send({
        error: `Usuário ${username} não existe`,
      })
    }
  }

  async updateProject({ request, params, response }: HttpContextContract) {
    const { id } = params
    const {
      name,
      tags,
      main_teacher,
      second_teacher,
      main_teacher_name,
      second_teacher_name,
      institution,
      start_date,
      abstract_text,
      participants,
      email,
      participants_full_name,
    } = request.all()

    if (main_teacher != undefined && main_teacher != null) {
      participants.push(main_teacher)
    }

    if (second_teacher != undefined && second_teacher != null) {
      participants.push(second_teacher)
    }

    const { allExists, username } = await this.allParticipantsExist(participants)
    if (allExists) {
      const project = await Project.findOrFail(id)
      await project.load("deleteRequests")

      project.name = name
      project.main_teacher = main_teacher
      project.second_teacher = second_teacher
      project.main_teacher_name = main_teacher_name
      project.second_teacher_name = second_teacher_name
      project.institution = institution
      project.start_date = start_date
      project.abstractText = abstract_text
      project.participants_full_name = participants_full_name
      project.email = email

      await project.save()
      
      await this.removeAllDeleteRequestsFromAProjectIfNumberOfParticipantsIsLesserThanNumberOfRequests(participants, project)
      await this.updateProjectParticipantRelationship(participants, project)
      if (!(tags == null)) {
        await this.updateProjectTagRelationship(tags, project)
      }

      await project.load('participants')
      await project.load('tags')

      return project
    } else {
      return response.status(404).send({
        error: `Usuário ${username} não existe`,
      })
    }
  }

  async removeAllDeleteRequestsFromAProjectIfNumberOfParticipantsIsLesserThanNumberOfRequests (participants: string[], project: Project) {
    if(participants.length <= project.deleteRequests.length) {
      await project.related("deleteRequests").sync([])
    }
  }

  async updateDeleteRequests({ params }: HttpContextContract) {
    const { projectId, userId } = params

    const project = await Project.findOrFail(projectId)
    const user = await User.findOrFail(userId)
    await project.load('deleteRequests')

    const hasRequestedDelete = project.deleteRequests.map((item) => item.id).includes(user.id)

    if(hasRequestedDelete) {
      await project.related('deleteRequests').detach([user.id])
    } else {
      await project.related('deleteRequests').attach([user.id])
    }

    await project.load('deleteRequests')
    return project
  }

  async listAllProjects() {
    const projects = await Project.all()

    for (let i = 0; i < projects.length; i++) {
      await projects[i].load('participants')
      await projects[i].load('tags')
      await projects[i].load('likedBy')
      await projects[i].load('savedBy')
    }

    return projects
  }

  async getProjectById({ params }: HttpContextContract) {
    const { id } = params
    const project = await Project.findOrFail(id)

    await project.load('participants')
    await project.load('savedBy')
    await project.load('tags')
    await project.load('likedBy')
    await project.load('deleteRequests')

    return project
  }

  async verifyIfProjectTitleAlreadyExists({ request }: HttpContextContract) {
    const { project_title } = request.all()

    const project = await Project.findByOrFail('name', project_title)

    return project
  }

  async verifyIfProjectEmailIsAlreadyBeingUsed({ params }: HttpContextContract) {
    const { email } = params

    const project = await Project.findByOrFail('email', email)

    return project
  }

  async allParticipantsExist(participants: string[]) {
    for (let i = 0; i < participants.length; i++) {
      const user = await User.findBy('username', participants[i])

      if (user == null) {
        return { allExists: false, username: participants[i] }
      }
    }

    return { allExists: true, username: null }
  }

  async createProjectTagRelationship(tags: string[], project: Project) {
    for (let i = 0; i < tags.length; i++) {
      const tag = await Tag.findBy('name', tags[i])

      if (tag == null) {
        const newTag = new Tag()

        newTag.name = tags[i]

        await newTag.save()
        await newTag.related('projects').save(project)
      } else if (tag instanceof Tag) {
        await tag.related('projects').save(project)
      }
    }
  }

  async createProjectParticipantRelationship(participants: string[], project: Project) {
    for (let i = 0; i < participants.length; i++) {
      const user = await User.findByOrFail('username', participants[i])

      if (user instanceof User) {
        await user.related('projects').save(project)
      }
    }
  }

  async updateProjectTagRelationship(tags: string[], project: Project) {
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

    await project.related('tags').sync(arrayOfTagIds)
  }

  async updateProjectParticipantRelationship(participants: string[], project: Project) {
    let arrayOfParticipantIds: number[] = []

    for (let i = 0; i < participants.length; i++) {
      const user = await User.findByOrFail('username', participants[i])

      if (user instanceof User) {
        arrayOfParticipantIds.push(user.id)
      }
    }

    await project.related('participants').sync(arrayOfParticipantIds)
  }

  async deleteProject({ params }: HttpContextContract) {
    const {projectId} = params;
    const project = await Project.findOrFail(projectId)

    project.main_teacher = null
    project.second_teacher = null

    await project.save()

    await project.related("deleteRequests").sync([])
    await project.related("participants").sync([])
    await project.related("savedBy").sync([])
    await project.related("tags").sync([])
    await project.related("likedBy").sync([])

    await project.load('participants')
    await project.load('savedBy')
    await project.load('tags')
    await project.load('likedBy')
    await project.load('deleteRequests')

    await project.delete()
  }
}
