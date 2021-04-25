import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import User from 'App/Models/User';
import UserView from 'App/Views/UserView';
import Project from '../../Models/Project';

export default {
    async createProject({ request, params }: HttpContextContract){
        const project = request.all()
        const {userId} = params;

        const user = await User.findOrFail(userId)
        await user.related("projects").create(project)
        await user.preload("projects")

        return UserView.render(user)
    },
    async listAllProjects(){
        return await Project.all();
    },
    async getProjectById({params}: HttpContextContract){
        
    }
}