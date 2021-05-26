import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Survey from 'App/Models/Survey';
import User from 'App/Models/User';
import { DateTime } from 'luxon';

export default class SurveysController {
  async create({request, params}: HttpContextContract){
    const survey = request.all();
    const {userId} = params;

    const user = await User.findOrFail(userId)
    await user.related("surveys").create(survey)
    await user.load("surveys")

    return user
  }

  async listAllSurveys(){
    return await Survey.all()
  }
  
  async getSurveyById({params}: HttpContextContract){
    const {id} = params
    const survey = await Survey.findOrFail(id)

    await survey.load("user")

    return survey
  }

  async updateSurvey({params, request}: HttpContextContract) {
    const {id} = params
    const {link, name} = request.all();

    const survey = await Survey.findOrFail(id);

    survey.link = link 
    survey.name = name
    survey.updatedAt = DateTime.local()

    await survey.save()

    return survey
  }

  async deleteSurvey({params}: HttpContextContract) {
    const {id} = params
    const survey = await Survey.findOrFail(id);

    await survey.delete()
  }
}
