import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import ProjetoView from 'App/Views/ProjectView';
import Project from '../../Models/Project';

export default {
    async create({ request }: HttpContextContract){
        const data = request.all()
        const projeto = await Project.create(data);

        return ProjetoView.render(projeto);
    },
    async index(){
        const data = await Project.all()
        return data;
    }
}