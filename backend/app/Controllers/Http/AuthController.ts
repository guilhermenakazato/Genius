import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default {
    async login ({ request, auth }: HttpContextContract) {
        const email = request.input('email')
        const password = request.input('password')
    
        const token = await auth.use('api').attempt(email, password)
        return token.toJSON()
    },
    async authenticateWithToken({auth}: HttpContextContract){
        await auth.authenticate()
        console.log(auth.user)

        return {
            message: "Login realizado com sucesso!"
        }
    },
    async logout({auth}: HttpContextContract){
        await auth.use("api").logout();
    }, 
    async getUserData({auth}: HttpContextContract){
        await auth.authenticate();
        await auth.user?.preload("achievements")
        await auth.user?.preload("projects")
        await auth.user?.preload("saved")
        await auth.user?.preload("surveys")

        return auth.user;
    },
    async checkTokenIsValid({auth}: HttpContextContract){
        return await auth.check();
    }
}