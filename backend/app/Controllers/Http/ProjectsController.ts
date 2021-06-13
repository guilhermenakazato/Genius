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
    } = request.all()

    const { creatorId } = params
    const { allExists, username } = await this.allParticipantsExist(participants)

    console.log(allExists)
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

      await project.save()

      await this.createProjectParticipantRelationship(participants, project)
      await this.createProjectTagRelationship(tags, project)

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
      }
      else if (tag instanceof Tag) {
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

  async listAllProjects() {
    const projects = await Project.all()

    for (let i = 0; i < projects.length; i++) {
      await projects[i].load('participants')
      await projects[i].load('tags')

      var mainTeacherUsername = projects[i].main_teacher
      var secondTeacherUsername = projects[i].second_teacher

      if (mainTeacherUsername != null && mainTeacherUsername != undefined) {
        projects[i].main_teacher = await User.findByOrFail("username", mainTeacherUsername)
      }

      if (secondTeacherUsername != null && secondTeacherUsername != undefined) {
        projects[i].second_teacher = await User.findByOrFail("username", secondTeacherUsername)
      }
    }

    return projects
  }

  async getProjectById({ params }: HttpContextContract) {
    const { id } = params
    const project = await Project.findOrFail(id)

    await project.load('participants')
    await project.load('savedBy')
    await project.load('tags')

    return project
  }
}
