import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import User from 'App/Models/User';
import Project from '../../Models/Project';

export default class ProjectsController {
    async createProject({ request, params }: HttpContextContract){
        const project = request.all()
        const {userId} = params;

        const user = await User.findOrFail(userId)
        await user.related("projects").create(project)
        await user.load("projects")

        return user
    }

    async listAllProjects(){
        const projects = await Project.all()
        
        for(let i = 0; i < projects.length; i++){
            await projects[i].load("participants")
            await projects[i].load("tags")

            var mainTeacherId = projects[i].main_teacher
            projects[i].main_teacher = await User.findOrFail(mainTeacherId)

            var secondTeacherId = projects[i].second_teacher
            
            if(secondTeacherId != null && secondTeacherId != undefined) {
                projects[i].second_teacher = await User.findOrFail(secondTeacherId)
            }
        }

        return projects;
    }
    
    async getProjectById({params}: HttpContextContract){
        const {id} = params
        const project = await Project.findOrFail(id)

        await project.load("participants")
        await project.load("savedBy")
        await project.load("tags")

        return project
    }
}