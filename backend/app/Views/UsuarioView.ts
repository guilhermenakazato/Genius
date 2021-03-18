import Usuario from "App/Models/Usuario"

export default {
    render(usuario: Usuario){
        return {
            id: usuario.id,
            username: usuario.username,
            email: usuario.email, 
            type: usuario.type,
            age: usuario.age,
            local: usuario.local,
            instituicao: usuario.instituicao,
            formacao: usuario.formacao
        };
    }
}