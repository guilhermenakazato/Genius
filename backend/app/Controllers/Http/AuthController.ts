import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default {
    // Pega email e senha e gera um token pra ser usado 
    async login ({ request, auth }: HttpContextContract) {
        const email = request.input('email')
        const password = request.input('password')
    
        const token = await auth.use('api').attempt(email, password)
        return token.toJSON()
    },
    // Usa token gerado para autenticar
    async token({auth}: HttpContextContract){
        await auth.authenticate()

        return {
            message: "Login realizado com sucesso!"
        }
    }
}
