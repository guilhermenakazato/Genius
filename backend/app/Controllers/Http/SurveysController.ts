import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Survey from 'App/Models/Survey';
import SurveyView from 'App/Views/SurveyView';

export default {
  async create({request}: HttpContextContract){
    const surveyData = request.all();
    const survey = await Survey.create(surveyData)

    return SurveyView.render(survey);
  },
  async listAllSurveys(){
    return await Survey.all()
  }
}
