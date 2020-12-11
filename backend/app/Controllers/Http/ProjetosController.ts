import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import ProjetoView from 'App/Views/ProjetoView';
import Projeto from '../../Models/Projeto';

export default {
    async create({ request }: HttpContextContract){
        const data = request.all()
        const projeto = await Projeto.create(data);

        return ProjetoView.render(projeto);
    },
    async index(){
        const data = await Projeto.all()
        return data;
    }
}
