import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

// consultar: https://preview.adonisjs.com/guides/auth/api-guard
// TODO: documentar
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
        console.log(await auth.check())

        return {
            message: "Login realizado com sucesso!"
        }
    },
    // desvalida o token e desloga o usuário
    async logout({auth}: HttpContextContract){
        await auth.use("api").logout();
    }, 
    // pega os dados do usuário caso esteja logado
    async getData({auth}: HttpContextContract){
        // usar auth.user.$attributes pra pegar os dados do usuário autenticado
        return auth.user?.$attributes;
    }
}
