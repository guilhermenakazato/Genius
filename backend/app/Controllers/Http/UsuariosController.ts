import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import UsuarioView from 'App/Views/UsuarioView';
import Usuario from "../../Models/Usuario";

export default {
    async index(){
        const user = await Usuario.all();
        return user;
    },
    async create({ request }: HttpContextContract){
        const data = request.all();
        const usuario = await Usuario.create(data);
        
        console.log(usuario)
        return UsuarioView.render(usuario);
    },
    async get({params}: HttpContextContract){
        const {id} = params;
        const user = await Usuario.findOrFail(id);

        return UsuarioView.render(user);
    },
    async getId({params}: HttpContextContract){
        const {email} = params;
        const user = await Usuario.findByOrFail("email", email);
        
        return user.id;
    }
}
