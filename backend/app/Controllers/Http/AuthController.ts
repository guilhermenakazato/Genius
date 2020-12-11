import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default {
    async login ({ request, auth }: HttpContextContract) {
        const email = request.input('email')
        const password = request.input('password')
    
        const token = await auth.use('api').attempt(email, password)
        return token.toJSON()
    },
    async token({auth}: HttpContextContract){
        await auth.authenticate()

        return {
            message: "Login realizado com sucesso!"
        }
    }
}
