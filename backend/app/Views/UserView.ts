import Usuario from "App/Models/User"

export default {
    render(usuario: Usuario){
        return {
            id: usuario.id,
            username: usuario.username,
            email: usuario.email, 
            type: usuario.type,
            age: usuario.age,
            local: usuario.local,
            institution: usuario.institution,
            formation: usuario.formation
        };
    }
}