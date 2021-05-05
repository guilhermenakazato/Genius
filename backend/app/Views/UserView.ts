import User from "App/Models/User"

export default {
    render(user: User){
        return {
            id: user.id,
            username: user.username,
            email: user.email, 
            type: user.type,
            age: user.age,
            local: user.local,
            institution: user.institution,
            formation: user.formation
        };
    }
}