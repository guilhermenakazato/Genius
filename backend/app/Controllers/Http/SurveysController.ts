import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Survey from 'App/Models/Survey';
import User from 'App/Models/User';

export default {
  async create({request, params}: HttpContextContract){
    const survey = request.all();
    const {userId} = params;

    const user = await User.findOrFail(userId)
    await user.related("surveys").create(survey)
    await user.preload("surveys")

    return user
  },
  async listAllSurveys(){
    return await Survey.all()
  },
  async getSurveyById({params}: HttpContextContract){
    const {id} = params
    const survey = await Survey.findOrFail(id)

    await survey.preload("user")

    return survey
  }
}
