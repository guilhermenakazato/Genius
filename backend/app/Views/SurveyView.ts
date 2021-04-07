import Survey from "App/Models/Survey";

export default {
  render(survey: Survey){
    return {
      id: survey.id,
      user_id: survey.user_id,
      link: survey.link,
    }
  }
}