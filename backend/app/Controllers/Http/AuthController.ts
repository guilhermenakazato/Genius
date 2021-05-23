import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import User from 'App/Models/User'

export default class AuthController {
    async login ({ request, auth }: HttpContextContract) {
        const email = request.input('email')
        const password = request.input('password')
    
        const token = await auth.use('api').attempt(email, password)
        return token.toJSON()
    }

    async authenticateWithToken({auth}: HttpContextContract){
        await auth.authenticate()
        console.log(auth.user)

        return {
            message: "Login realizado com sucesso!"
        }
    }

    async logout({auth}: HttpContextContract){
        await auth.use("api").logout();
    }

    async getUserData({auth}: HttpContextContract){
        await auth.authenticate();
        await auth.user?.load("achievements")
        await auth.user?.load("projects")
        await auth.user?.load("saved")
        await auth.user?.load("surveys")

        var projects = auth.user?.projects;
        
        projects?.forEach((project) => {
            project.load("participants");
        })

        if(projects != undefined){
            for(let i = 0; i < projects.length; i++){
                var mainTeacherId = projects[i].main_teacher
                projects[i].main_teacher = await User.findOrFail(mainTeacherId)
    
                var secondTeacherId = projects[i].second_teacher
                
                if(secondTeacherId != null && secondTeacherId != undefined) {
                    projects[i].second_teacher = await User.findOrFail(secondTeacherId)
                }
            }
        }

        return auth.user;
    }

    getTeachersFromProjects(projects) {

    }
    
    async checkTokenIsValid({auth}: HttpContextContract){
        return await auth.check();
    }
}