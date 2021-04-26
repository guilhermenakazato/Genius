import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import User from 'App/Models/User';
import Project from '../../Models/Project';

export default {
    async createProject({ request, params }: HttpContextContract){
        const project = request.all()
        const {userId} = params;

        const user = await User.findOrFail(userId)
        await user.related("projects").create(project)
        await user.preload("projects")

        return user
    },
    async listAllProjects(){
        const projects = await Project.all()
        
        for(let i = 0; i < projects.length; i++){
            await projects[i].preload("participants")
            await projects[i].preload("tags")

            var mainTeacherId = projects[i].main_teacher
            projects[i].main_teacher = await User.findOrFail(mainTeacherId)

            var secondTeacherId = projects[i].second_teacher
            
            if(secondTeacherId != null && secondTeacherId != undefined) {
                projects[i].second_teacher = await User.findOrFail(secondTeacherId)
            }
        }

        return projects;
    },
    async getProjectById({params}: HttpContextContract){
        const {id} = params
        const project = await Project.findOrFail(id)

        await project.preload("participants")
        await project.preload("savedBy")
        await project.preload("tags")

        return project
    }
}