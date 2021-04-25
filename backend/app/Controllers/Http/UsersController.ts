import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Project from 'App/Models/Project';
import { DateTime } from 'luxon';
import User from "../../Models/User";

export default {
    async listAllUsers(){
        const user = await User.all();
        return user;
    },
    async create({ request }: HttpContextContract){
        const data = request.all();
        const user = await User.create(data);
                
        return user
    },
    async getUserById({params}: HttpContextContract){
        const {id} = params;
        const user = await User.findOrFail(id);

        await user.preload("achievements")
        await user.preload("projects")
        await user.preload("saved")
        await user.preload("surveys")

        return user
    },
    async deleteUser({params}: HttpContextContract){
        const {id} = params; 
        const user = await User.findOrFail(id);

        await user.delete();
    },
    async updateUser({params, request}: HttpContextContract){
        const {id} = params;
        const {username, email, password, type, age, local, formation, institution} = request.all()
        const user = await User.findOrFail(id);
        
        user.username = username;
        user.email = email;
        user.password = password;
        user.type = type;
        user.age = age;
        user.local = local;
        user.formation = formation;
        user.institution = institution;
        user.updatedAt = DateTime.local()
        
        await user.save()
        return user
    },
    async saveProject({request}:HttpContextContract){
        const {projectId, userId} = request.all()

        const user = await User.findOrFail(userId)
        const project = await Project.findOrFail(projectId)
        await user.related("saved").save(project)

        await user.preload("saved")

        return user
    }
}