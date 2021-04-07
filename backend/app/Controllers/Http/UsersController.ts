import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import UsuarioView from 'App/Views/UserView';
import Usuario from "../../Models/User";

export default {
    async index(){
        const user = await User.all();
        return user;
    },
    async create({ request }: HttpContextContract){
        const data = request.all();
        const user = await User.create(data);
        
        console.log(user)
        return UserView.render(user);
    },
    async get({params}: HttpContextContract){
        const {id} = params;
        const user = await User.findOrFail(id);

        return UserView.render(user);
    },
}